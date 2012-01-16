/*
 * Copyright 2008-2011, Torsten Curdt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "TCLocalizer.h"

@implementation NSWindow (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.title = [localizer localizedString:self.title];
    [[self contentView] localizeWithLocalizer:localizer];
}

@end

@implementation NSView (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    for(NSView *subview in [self subviews]) {
        if([subview respondsToSelector:@selector(localizeWithLocalizer:)]) {
            [subview localizeWithLocalizer:localizer];
        }
    }
}

@end

@implementation NSButton (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.title = [localizer localizedString:self.title];
    self.toolTip = [localizer localizedString:self.toolTip];
}

@end

@implementation NSTextField (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.stringValue = [localizer localizedString:self.stringValue];
}

@end

@implementation NSTextView (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    if (!self.isRichText) {
        self.string = [localizer localizedString:self.string];
    } else {
        // TODO handle attributed strings
    }
}

@end

@implementation TCLocalizer

@synthesize table;
@synthesize bundle;

+ (TCLocalizer*)localizer
{
    static TCLocalizer *localizer = nil;
    if (localizer == nil) {
        localizer = [[[self class] alloc] initWithTable:nil bundle:nil];
    }
    return localizer;
}

+ (TCLocalizer*)localizerWithTable:(NSString*)theTable bundle:(NSBundle*)theBundle
{
    return [[[[self class] alloc] initWithTable:theTable bundle:theBundle] autorelease];
}

- (id)initWithTable:(NSString*)theTable bundle:(NSBundle*)theBundle
{
    if(self = [super init]) {
        if (!theTable) {
            theTable = @"Localizable";
        }
        if (!theBundle) {
            theBundle = [NSBundle mainBundle];
        }
        table = theTable;
        bundle = theBundle;
    }
    return self;
}

- (NSString*)localizedString:(NSString*)string
{
    if([string length]) {
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return NSLocalizedStringFromTableInBundle(string, table, bundle, nil);
    }
    return string;
}

- (void)localizeView:(NSView*)view;
{
    [view localizeWithLocalizer:self];
}

- (void)localizeWindow:(NSWindow*)window
{
    [window localizeWithLocalizer:self];
}

@end
