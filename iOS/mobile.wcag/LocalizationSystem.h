//
//  LocalizationSystem.h
//  POC
//
//  Created by Jeroen Trappers on 28/04/12.
//  Copyright (c) 2012 iCapps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AMLocalizedString(key, comment) \
[[LocalizationSystem sharedLocalSystem] localizedStringForKey:(key) value:(comment)]

#define LocalizationSetLanguage(language) \
[[LocalizationSystem sharedLocalSystem] setLanguage:(language)]

#define LocalizationGetLanguage \
[[LocalizationSystem sharedLocalSystem] getLanguage]

#define LocalizationReset \
[[LocalizationSystem sharedLocalSystem] resetLocalization]

#define LanguageChangedNotification @"LanguageChangedNotification"
#define FontSizeChangedNotification @"FontSizeChangedNotification"

@interface LocalizationSystem : NSObject {
    NSString *language;
}

// you really shouldn't care about this functions and use the MACROS
+ (LocalizationSystem *)sharedLocalSystem;

//gets the string localized
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment;

//sets the language
- (void)setLanguage:(NSString*) language;

//gets the current language
- (NSString*)getLanguage;

//resets this system.
- (void) resetLocalization;


@end

