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

- (id)initWithTable:(NSString *)table bundle:(NSBundle *)bundle;

- (NSString*)localizedString:(NSString*)string;
- (void)localizeView:(NSView*)view;
- (void)localizeWindow:(NSWindow*)window;

@end

@interface NSWindow (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface NSView (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface NSButton (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface NSTextField (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

@interface NSTextView (TCLocalizerExtension)
- (void)localizeWithLocalizer:(TCLocalizer*)localizer;
@end

