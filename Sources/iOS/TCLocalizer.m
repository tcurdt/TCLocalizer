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

@implementation UITextField (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.placeholder = [localizer localizedString:self.placeholder];
}
@end

@implementation UILabel (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    if (self.attributedText) {
        NSAttributedString *as = [self.attributedText mutableCopy];
        NSMutableString *ms = [as mutableString];
        NSString *src = ms;
        NSString *dst = [localizer localizedString:src];
        [ms replaceOccurrencesOfString:src
                            withString:dst
                               options:NSLiteralSearch range:NSMakeRange(0, src.length)];
        self.attributedText = as;
    } else {
        self.text = [localizer localizedString:self.text];
    }
}
@end

@implementation UITextView (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    self.text = [localizer localizedString:self.text];
}
@end

@implementation UITableViewCell (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    [[self textLabel] localizeWithLocalizer:localizer];
    [[self detailTextLabel] localizeWithLocalizer:localizer];

    [[self contentView] localizeWithLocalizer:localizer];
    [[self backgroundView] localizeWithLocalizer:localizer];
    [[self accessoryView] localizeWithLocalizer:localizer];
}
@end

@implementation UICollectionViewCell (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer
{
    [[self contentView] localizeWithLocalizer:localizer];
    [[self backgroundView] localizeWithLocalizer:localizer];
    [[self selectedBackgroundView] localizeWithLocalizer:localizer];    
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
        table = theTable;
        bundle = theBundle;
    }
    return self;
}

- (NSString*)localizedString:(NSString*)string
{
    if([string length]) {
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *translate = [bundle localizedStringForKey:string value:nil table:table];
	if (translate) {
	    return translate;
	} else {
	    // key was not found in dictionary
	    return string;
	}
    } else {
	// key was empty
	return string;
    }
}

- (void)localizeTableViewCell:(UITableViewCell*)cell;
{
    [cell localizeWithLocalizer:self];
}

- (void)localizeCollectionViewCell:(UICollectionViewCell*)cell;
{
    [cell localizeWithLocalizer:self];
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
