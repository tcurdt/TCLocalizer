/*
 * Copyright 2008-2014, Torsten Curdt
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

@interface TCLocalizer ()

- (NSString*)localizedString:(NSString*)string context:(id)context;

@property (strong, readwrite) NSString *table;
@property (strong, readwrite) NSBundle *bundle;

@end


@implementation NSWindow (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.title = [localizer localizedString:self.title context:self];
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

@implementation NSMenu (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.title = [localizer localizedString:self.title context:self];

    for(NSMenuItem *menuitem in self.itemArray) {
        if (!menuitem.isSeparatorItem) {
            menuitem.title = [localizer localizedString:menuitem.title context:menuitem];
        }

        [menuitem.submenu localizeWithLocalizer:localizer];
    }
}
@end


@implementation NSButton (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.title = [localizer localizedString:self.title context:self];
    self.toolTip = [localizer localizedString:self.toolTip context:self];
}
@end

@implementation NSTextField (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.stringValue = [localizer localizedString:self.stringValue context:self];
}
@end

@implementation NSTextView (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    if (!self.isRichText) {
        self.string = [localizer localizedString:self.string context:self];
    } else {
        // TODO handle attributed strings
    }
}
@end

@implementation TCLocalizer

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
    return [[[self class] alloc] initWithTable:theTable bundle:theBundle];
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
        self.table = theTable;
        self.bundle = theBundle;
    }
    return self;
}
- (NSString*)localizedString:(NSString*)string
{
    return [self localizedString:string context:nil];
}

- (NSString*)localizedString:(NSString*)string context:(id)context
{
    if([string length]) {
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *translate = [self.bundle localizedStringForKey:string value:nil table:self.table];
        if (translate) {
            return translate;
        } else {
            // key was not found in dictionary
            #ifdef DEBUG
            NSLog(@"WARN: no translation for '%@' for %@", string, context);
            #endif
            return string;
        }
    } else {
        // key was empty
        #ifdef DEBUG
        NSLog(@"WARN: empty key for %@", context);
        #endif
        return string;
    }
}

- (void)localizeView:(NSView*)view;
{
    [view localizeWithLocalizer:self];
}

- (void)localizeMenu:(NSMenu*)menu;
{
    [menu localizeWithLocalizer:self];
}

- (void)localizeWindow:(NSWindow*)window
{
    [window localizeWithLocalizer:self];
}

@end
