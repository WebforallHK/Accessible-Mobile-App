//
//  AppDelegate.h
//  mobile.wcag
//
//



#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "IQKeyboardManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property(nonatomic, strong) UITabBarController *tabBarController;

@property int btnRad, viewNum;
@property NSString *webFont;
@property CGFloat navTitleFont, titleX, textX, buttonX, spacingY, spacingLY, buttonHeight, tabbarHeight;
@property UIFont *btnFont, *titleFont, *textFont, *dtextFont, *boldTextFont;

@property (nonatomic, retain) AVAudioPlayer *audioPlayer;


+ (AppDelegate *)sharedAppDelegate;
- (UILabel *)getTitleLabel:(NSString *)title;
- (void)updateEnv;
- (IBAction)stopMusic;
- (IBAction)startMusic;
- (void)changeRootViewController;
- (UITextField *)iPadTxtFrame:(UITextField*)txtfield;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)resizeIPhoneImage:(UIImage *)image;
@end

