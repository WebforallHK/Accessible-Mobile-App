//
//  CusTabBarController.h
//  mobile.wcag
//
//

#import <UIKit/UIKit.h>

@interface CusTabBarController : UIView
@property (nonatomic, strong) UIImageView *imageView;
+ (instancetype)sharedInstance;
@property (nonatomic, strong) UIButton *tabBarItem1;
@property (nonatomic, strong) UIButton *tabBarItem2;
@property (nonatomic, strong) UIButton *tabBarItem3;
@property (nonatomic, strong) UIButton *tabBarItem4;
@property (nonatomic, strong) UIButton *tabBarItem5;
@property int viewNum;

@end
