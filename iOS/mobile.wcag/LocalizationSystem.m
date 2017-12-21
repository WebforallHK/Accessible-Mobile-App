//
//  LocalizationSystem.h
//  POC
//
//  Created by Jeroen Trappers on 28/04/12.
//  Copyright (c) 2012 iCapps. All rights reserved.
//

#import "LocalizationSystem.h"

@implementation LocalizationSystem

//Singleton instance
static LocalizationSystem *_sharedLocalSystem = nil;

//Current application bungle to get the languages.
static NSBundle *bundle = nil;
/*
 + (LocalizationSystem *)sharedLocalSystem
 {
	@synchronized([LocalizationSystem class])
	{
 if (!_sharedLocalSystem){
 [[self alloc] init];
 }
 return _sharedLocalSystem;
	}
	// to avoid compiler warning
	return nil;
 }
 */
+ (LocalizationSystem *)sharedLocalSystem {
    @synchronized(self) {
        if(_sharedLocalSystem == nil)  {
            _sharedLocalSystem = [[LocalizationSystem alloc] init];
        }
    }
    return _sharedLocalSystem;
}

+(id)alloc
{
    @synchronized([LocalizationSystem class])
    {
        NSAssert(_sharedLocalSystem == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedLocalSystem = [super alloc];
        return _sharedLocalSystem;
    }
    // to avoid compiler warning
    return nil;
}


- (id)init
{
    if ((self = [super init]))
    {
        //empty.
        bundle = [NSBundle mainBundle];
    }
    return self;
}

// Gets the current localized string as in AMLocalizedString.
//
// example calls:
// AMLocalizedString(@"Text to localize",@"Alternative text, in case hte other is not find");
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment
{
    return [bundle localizedStringForKey:key value:comment table:nil];
}


// Sets the desired language of the ones you have.
// example calls:
// LocalizationSetLanguage(@"Italian");
// LocalizationSetLanguage(@"German");
// LocalizationSetLanguage(@"Spanish");
//
// If this function is not called it will use the default OS language.
// If the language does not exists y returns the default OS language.
- (void) setLanguage:(NSString*) l{
    //	DLog(@"preferredLang: %@", l);
    [[NSUserDefaults standardUserDefaults] setObject:l forKey:@"WCAGInterfaceLanguage"];
    l = l? l:[self getLanguage];
    
    NSString *path = [[ NSBundle mainBundle ] pathForResource:l ofType:@"lproj" ];
    
    
    if (path == nil)
        //in case the language does not exists
        [self resetLocalization];
    else
        bundle = [NSBundle bundleWithPath:path];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"LanguageChangedNotification" object:nil];
}

// Just gets the current setted up language.
// returns "es","fr",...
//
// example call:
// NSString * currentL = LocalizationGetLanguage;
- (NSString*)getLanguage{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"WCAGInterfaceLanguage"] != nil) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"WCAGInterfaceLanguage"];
    } else {
        NSString *preferredLang = @"";

        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] isKindOfClass:[NSArray class]])
        {
            NSLog(@"NSArray Class");
            preferredLang = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
        }
        else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] isKindOfClass:[NSString class]])
        {
            NSLog(@"NSString class");
            preferredLang = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        }
        else
        {
            NSLog(@"other class");
        }
        
        if ([preferredLang hasPrefix:@"en"]) {
            preferredLang = @"en";
        } else if ([preferredLang hasPrefix:@"zh-Hans"]) {
            preferredLang = @"zh-Hans";
        } else if ([preferredLang hasPrefix:@"zh-Hant"]) {
            preferredLang = @"zh-Hant";
        } else {
            preferredLang = @"en";
        }
        [[NSUserDefaults standardUserDefaults] setObject:preferredLang forKey:@"WCAGInterfaceLanguage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return preferredLang;
    }
}

// Resets the localization system, so it uses the OS default language.
//
// example call:
// LocalizationReset;
- (void) resetLocalization
{
    bundle = [NSBundle mainBundle];
}


@end
