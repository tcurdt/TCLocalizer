/*
 * Copyright 2008-2013, Torsten Curdt
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

@implementation UIViewController (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    [[self view] localizeWithLocalizer:localizer];
    [[self navigationItem] localizeWithLocalizer:localizer];
}

@end


@implementation UIView (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    for(UIView *subview in [self subviews]) {
        if([subview respondsToSelector:@selector(localizeWithLocalizer:)]) {
            [subview localizeWithLocalizer:localizer];
        }
    }
}

@end

@implementation UINavigationItem (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    [self setTitle:[localizer localizedString:[self title]]];
    [self setPrompt:[localizer localizedString:[self prompt]]];
    [[self leftBarButtonItem] localizeWithLocalizer:localizer];
    [[self rightBarButtonItem] localizeWithLocalizer:localizer];
}

@end

@implementation UIBarButtonItem (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    [self setTitle:[localizer localizedString:[self title]]];
}

@end


@implementation UIButton (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    [self setTitle:[localizer localizedString:[self titleForState:UIControlStateNormal]] forState:UIControlStateNormal];
    [self setTitle:[localizer localizedString:[self titleForState:UIControlStateHighlighted]] forState:UIControlStateHighlighted];
    [self setTitle:[localizer localizedString:[self titleForState:UIControlStateDisabled]] forState:UIControlStateDisabled];
    [self setTitle:[localizer localizedString:[self titleForState:UIControlStateSelected]] forState:UIControlStateSelected];
}

@end

@implementation UILabel (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.text = [localizer localizedString:self.text];
}

@end

@implementation UITextView (TCLocalizerExtension)

- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.text = [localizer localizedString:self.text];
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

- (void)localizeView:(UIView*)view;
{
    [view localizeWithLocalizer:self];
}

- (void)localizeViewController:(UIViewController*)viewController
{
    [viewController localizeWithLocalizer:self];
}

@end
