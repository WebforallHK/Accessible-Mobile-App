//
//  AppDelegate.m
//  mobile.wcag
//
//

#import "AppDelegate.h"
#import "AboutViewController.h"
#import "SeminarViewController.h"
#import "VideoViewController.h"
#import "SettingViewController.h"
#import "ContactUsViewController.h"
@import GoogleMaps;
@import AVFoundation;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide;
    
    NSString *lang;
    
    if ([[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] != nil) {
        lang = [[[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] mutableCopy] objectForKey:@"language"];
    } else {
        lang = LocalizationGetLanguage;
    }
    if (lang == nil)
        lang = @"en";
    NSLog(@"lang0:%@",lang);
//    if(lang != NULL && [lang isEqualToString:@""] == NO)
//    {
//        NSLog(@"WCAGInterfaceLanguage=%@", lang);
//        [[LocalizationSystem sharedLocalSystem] setLanguage:lang];
//    } else {
//        LocalizationSetLanguage(@"en");
//       // [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"AppleLanguages"];
//    }
    if ([lang isEqualToString:@"繁體中文"]) {
        LocalizationSetLanguage(@"zh-Hant");
    } else if ([lang isEqualToString:@"简体中文"]) {
        LocalizationSetLanguage(@"zh-Hans");
    } else {
        LocalizationSetLanguage(@"en");
    }
//    LocalizationSetLanguage(LocalizationGetLanguage);
    NSLog(@"lang:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]);
    [GMSServices provideAPIKey:@"AIzaSyArrjfw9LAUwy6bN96KLWPk1-IyOkIgnwY"];
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"bensound-ukulele" ofType:@"mp3"];
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    self.audioPlayer.numberOfLoops = -1; //infinite loop
    
    self.btnRad = 18;
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    
    /*
    int offset = 7;
    UIEdgeInsets imageInset = UIEdgeInsetsMake(offset, 0, -offset, 0);
    
    AboutViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
    UINavigationController *navigationViewController1 = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    mainViewController.tabBarItem.image = [[UIImage imageNamed:AMLocalizedString(@"tabimg1",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainViewController.tabBarItem.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg1s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainViewController.tabBarItem.image.isAccessibilityElement = YES;
    mainViewController.tabBarItem.isAccessibilityElement = YES;
    mainViewController.tabBarItem.accessibilityLabel = AMLocalizedString(@"About Web", nil);
    mainViewController.tabBarItem.accessibilityHint = AMLocalizedString(@"About Web", nil);
//    mainViewController.tabBarItem.title = AMLocalizedString(@"tab1", nil);
    mainViewController.tabBarItem.imageInsets = imageInset;
    [mainViewController initMethod];
    
    SeminarViewController *seminarViewController = [storyboard instantiateViewControllerWithIdentifier:@"SeminarViewController"];
    UINavigationController *navigationViewController2 = [[UINavigationController alloc] initWithRootViewController:seminarViewController];
    seminarViewController.tabBarItem.image = [[UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    seminarViewController.tabBarItem.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg2s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    seminarViewController.tabBarItem.image.isAccessibilityElement = YES;
    seminarViewController.tabBarItem.isAccessibilityElement = YES;
    seminarViewController.tabBarItem.accessibilityLabel = AMLocalizedString(@"Seminars", nil);
    seminarViewController.tabBarItem.accessibilityHint = AMLocalizedString(@"Seminars", nil);
//    seminarViewController.tabBarItem.title = AMLocalizedString(@"tab2", nil);
    seminarViewController.tabBarItem.imageInsets = imageInset;
    [seminarViewController initMethod];
    
    VideoViewController *videoViewController = [storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
    UINavigationController *navigationViewController3 = [[UINavigationController alloc] initWithRootViewController:videoViewController];
    videoViewController.tabBarItem.image = [[UIImage imageNamed:AMLocalizedString(@"tabimg3",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    videoViewController.tabBarItem.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg3s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    videoViewController.tabBarItem.image.isAccessibilityElement = YES;
    videoViewController.tabBarItem.isAccessibilityElement = YES;
    videoViewController.tabBarItem.accessibilityLabel = AMLocalizedString(@"Webforall", nil);
    videoViewController.tabBarItem.accessibilityHint = AMLocalizedString(@"Webforall", nil);
//    videoViewController.tabBarItem.title = AMLocalizedString(@"tab3", nil);
    videoViewController.tabBarItem.imageInsets = imageInset;
    [videoViewController initMethod];
    
    SettingViewController *settingViewController = [storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    UINavigationController *navigationViewController4 = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    settingViewController.tabBarItem.image = [[UIImage imageNamed:AMLocalizedString(@"tabimg4",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    settingViewController.tabBarItem.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg4s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    settingViewController.tabBarItem.image.isAccessibilityElement = YES;
    settingViewController.tabBarItem.isAccessibilityElement = YES;
    settingViewController.tabBarItem.accessibilityLabel = AMLocalizedString(@"Settings", nil);
    settingViewController.tabBarItem.accessibilityHint = AMLocalizedString(@"Settings", nil);
//    settingViewController.tabBarItem.title = AMLocalizedString(@"tab4", nil);
    settingViewController.tabBarItem.imageInsets = imageInset;
    [settingViewController initMethod];
    
    ContactUsViewController *contactUsViewController = [storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
    UINavigationController *navigationViewController5 = [[UINavigationController alloc] initWithRootViewController:contactUsViewController];
    contactUsViewController.tabBarItem.image = [[UIImage imageNamed:AMLocalizedString(@"tabimg5",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contactUsViewController.tabBarItem.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg5s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contactUsViewController.tabBarItem.image.isAccessibilityElement = YES;
    contactUsViewController.tabBarItem.isAccessibilityElement = YES;
    contactUsViewController.tabBarItem.accessibilityLabel = AMLocalizedString(@"Contact Us", nil);
    contactUsViewController.tabBarItem.image.accessibilityHint = AMLocalizedString(@"Contact Us", nil);
//    contactUsViewController.tabBarItem.title = AMLocalizedString(@"tab5", nil);
    contactUsViewController.tabBarItem.imageInsets = imageInset;
    [contactUsViewController initMethod];
    
     self.tabBarController = [[UITabBarController alloc] init];
     self.tabBarController.delegate = self;
     
     self.tabBarController.viewControllers = @[navigationViewController1, navigationViewController2, navigationViewController3, navigationViewController4, navigationViewController5];
     NSLog(@"self.tabBarController=%@", self.tabBarController);
     */
    
    
    UIViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainScreenViewController"];
    UINavigationController *rootNavigationViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    
    self.window.rootViewController = rootNavigationViewController;

//    LocalizationSetLanguage(LocalizationGetLanguage);
    
    [self.window makeKeyAndVisible];
    
    
//    ContactUsViewController *vc5 = [[ContactUsViewController alloc] init];
//    [vc5 initMethod];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}




- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"Exception - %@",[exception description]);
    exit(EXIT_FAILURE);
}


+ (AppDelegate *)sharedAppDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (UILabel *)getTitleLabel:(NSString *)title {
    NSLog(@"lang:%@",LocalizationGetLanguage);
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, 44)];
    titleLbl.text = AMLocalizedString(title, nil);
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.numberOfLines = 2;
    titleLbl.font = [UIFont systemFontOfSize:20];
    titleLbl.minimumScaleFactor = 0.5;
    titleLbl.adjustsFontSizeToFitWidth = YES;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor whiteColor];
    
    return titleLbl;
}

- (void)updateEnv {
    CGFloat scale;
    if ( isiPad) {
        scale = 3;
    } else {
        scale = 2;
    }
    
    NSString *fontSize = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:@"fontSize"];
    if ([fontSize isEqualToString:@"Small"]) {
        self.btnFont = [UIFont systemFontOfSize:5*scale];
        self.titleFont = [UIFont systemFontOfSize:7*scale];
        self.textFont = [UIFont systemFontOfSize:5*scale];
        self.boldTextFont = [UIFont boldSystemFontOfSize:6*scale];
        self.dtextFont = [UIFont systemFontOfSize:4*scale];
        if (isiPad)
            self.webFont = [NSString stringWithFormat:@"%.1f",scale * 0.7 * 10];
        else
            self.webFont = [NSString stringWithFormat:@"%.1f",scale * 1.1 * 10];
        self.navTitleFont = 8.0*scale;
    } else if ([fontSize isEqualToString:@"Large"]) {
        self.btnFont = [UIFont systemFontOfSize:9*scale];
        self.titleFont = [UIFont systemFontOfSize:11*scale];
        self.textFont = [UIFont systemFontOfSize:9*scale];
        self.boldTextFont = [UIFont boldSystemFontOfSize:10*scale];
        self.dtextFont = [UIFont systemFontOfSize:8*scale];
        if (isiPad)
            self.webFont = [NSString stringWithFormat:@"%.1f",scale * 0.7 * 18];
        else
            self.webFont = [NSString stringWithFormat:@"%.1f",scale * 1.3 * 18];
        self.navTitleFont = 12.0*scale;
    } else {
        self.btnFont = [UIFont systemFontOfSize:7*scale];
        self.titleFont = [UIFont systemFontOfSize:9*scale];
        self.textFont = [UIFont systemFontOfSize:7*scale];
        self.boldTextFont = [UIFont boldSystemFontOfSize:8*scale];
        self.dtextFont = [UIFont systemFontOfSize:6*scale];
        if (isiPad)
            self.webFont = [NSString stringWithFormat:@"%.1f",scale * 0.7 * 14];
        else
            self.webFont = [NSString stringWithFormat:@"%.1f",scale * 1.2 * 14];
        self.navTitleFont = 10.0*scale;
    }
    
    if (isiPad) {
        _titleX = 40;
        _textX = 36;
        _buttonX = 74;
        _spacingY = 30;
        _spacingLY = 5;
        _buttonHeight = 65;
        _tabbarHeight = 100;
    } else {
        _titleX = 30;
        _textX = 40;
        _buttonX = 37;
        _spacingY = 20;
        _spacingLY = 2;
        _buttonHeight = 45;
        _tabbarHeight = 50;
    }
    
    NSString *bgMusicStatus = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:@"bgm"];
    if([bgMusicStatus isEqualToString:@"On"])
        [self startMusic];
    else
        [self stopMusic];

}

- (IBAction)stopMusic
{
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [self.audioPlayer stop];
}


- (IBAction)startMusic
{
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [self.audioPlayer play];
}

- (UITextField *)iPadTxtFrame:(UITextField*)txtfield {
    CGRect tempFrame = txtfield.frame;
    tempFrame.size.height = 60;
    txtfield.frame = tempFrame;
    txtfield.font = self.textFont;
    
    return txtfield;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)resizeIPhoneImage:(UIImage *)image {
    CGRect rect = CGRectMake(0,0,75,75);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *img=[UIImage imageWithData:imageData];
    return img;
}
@end
