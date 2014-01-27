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

#import <Foundation/Foundation.h>

@interface TCLocalizer : NSObject
{
    NSString *table;
    NSBundle *bundle;
}

@property (readonly) NSString *table;
@property (readonly) NSBundle *bundle;

+ (TCLocalizer*)localizer;
+ (TCLocalizer*)localizerWithTable:(NSString*)table bundle:(NSBundle*)bundle;

- (NSString*)localizedString:(NSString*)string;

- (void)localizeTableViewCell:(UITableViewCell*)cell;
- (void)localizeCollectionViewCell:(UICollectionViewCell*)cell;
- (void)localizeView:(UIView*)view;
- (void)localizeViewController:(UIViewController*)viewController;

@end

@interface UIViewController (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface UINavigationItem (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface UIBarButtonItem (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface UIView (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface UIButton (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface UITextField (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface UILabel (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface UITextView (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface UITableViewCell (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface UICollectionViewCell (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end
