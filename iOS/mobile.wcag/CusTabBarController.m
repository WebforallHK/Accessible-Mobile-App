//
//  CusTabBarController.m
//  mobile.wcag
//
//

#import "CusTabBarController.h"
#import "AppDelegate.h"

@interface CusTabBarController ()

@end

@implementation CusTabBarController

+ (instancetype)sharedInstance
{
    static CusTabBarController *sharedInstance = nil;

        if (isiPad) {
            sharedInstance = [[CusTabBarController alloc] initWithFrame:CGRectMake(0,([[UIScreen mainScreen]bounds].size.height)-162, ([[UIScreen mainScreen]bounds].size.width), [AppDelegate sharedAppDelegate].tabbarHeight)];
        } else {
            sharedInstance = [[CusTabBarController alloc] initWithFrame:CGRectMake(0,([[UIScreen mainScreen]bounds].size.height)-112, ([[UIScreen mainScreen]bounds].size.width), [AppDelegate sharedAppDelegate].tabbarHeight)];
        }
        // Do any other initialisation stuff here
        NSLog(@"screenWidth:%f,screenHeight:%f",[[UIScreen mainScreen]bounds].size.height,[[UIScreen mainScreen]bounds].size.height);

    return sharedInstance;
}

- (id)initWithFrame:(CGRect)aRect
{
    if ((self = [super initWithFrame:aRect])) {
        [self startTabBar:[AppDelegate sharedAppDelegate].viewNum+100];
    }
    return self;
}

- (void)startTabBar:(int)viewNum {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabBarTitle:) name:@"LanguageChangedNotification" object:nil];
    [self setBackgroundColor:[UIColor pxColorWithHexValue:@"#4d4d4d"]];
    self.tabBarItem1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tabBarItem2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tabBarItem3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tabBarItem4 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tabBarItem5 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat itemWidth = self.frame.size.width/5;
    CGFloat itemHeight = self.frame.size.height;
    [self.tabBarItem1 setFrame:CGRectMake(0, 0, itemWidth, itemHeight)];
    [self.tabBarItem2 setFrame:CGRectMake(itemWidth, 0, itemWidth, itemHeight)];
    [self.tabBarItem3 setFrame:CGRectMake(itemWidth*2, 0, itemWidth, itemHeight)];
    [self.tabBarItem4 setFrame:CGRectMake(itemWidth*3, 0, itemWidth, itemHeight)];
    [self.tabBarItem5 setFrame:CGRectMake(itemWidth*4, 0, itemWidth, itemHeight)];
    
    CGFloat scale, imgHeight;
    scale = 40/35;
    imgHeight = itemHeight;
    
    if (isiPad) {
        [self.tabBarItem1 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg1",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem1 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg1",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [self.tabBarItem2 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem2 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [self.tabBarItem3 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg3",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem3 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg3",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [self.tabBarItem4 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg4",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem4 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg4",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [self.tabBarItem5 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg5",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem5 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg5",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    } else {
        UIImage *icon;
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg1",nil)];
        [self.tabBarItem1 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg1s",nil)];
        [self.tabBarItem1 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)];
        [self.tabBarItem2 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg2s",nil)];
        [self.tabBarItem2 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg3",nil)];
        [self.tabBarItem3 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg3s",nil)];
        [self.tabBarItem3 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg4",nil)];
        [self.tabBarItem4 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg4s",nil)];
        [self.tabBarItem4 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg5",nil)];
        [self.tabBarItem5 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg5s",nil)];
        [self.tabBarItem5 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    }
    
    self.tabBarItem1.isAccessibilityElement = YES;
    self.tabBarItem2.isAccessibilityElement = YES;
    self.tabBarItem3.isAccessibilityElement = YES;
    self.tabBarItem4.isAccessibilityElement = YES;
    self.tabBarItem5.isAccessibilityElement = YES;
    
    self.tabBarItem1.accessibilityLabel = AMLocalizedString(@"tab1", nil);
    self.tabBarItem2.accessibilityLabel = AMLocalizedString(@"tab2", nil);
    self.tabBarItem3.accessibilityLabel = AMLocalizedString(@"tab3", nil);
    self.tabBarItem4.accessibilityLabel = AMLocalizedString(@"tab4", nil);
    self.tabBarItem5.accessibilityLabel = AMLocalizedString(@"tab5", nil);
    
    self.tabBarItem1.contentMode = UIViewContentModeCenter;
    self.tabBarItem2.contentMode = UIViewContentModeCenter;
    self.tabBarItem3.contentMode = UIViewContentModeCenter;
    self.tabBarItem4.contentMode = UIViewContentModeCenter;
    self.tabBarItem5.contentMode = UIViewContentModeCenter;
    
    self.tabBarItem1.tag = 101;
    self.tabBarItem2.tag = 102;
    self.tabBarItem3.tag = 103;
    self.tabBarItem4.tag = 104;
    self.tabBarItem5.tag = 105;
    [self.tabBarItem1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItem2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItem3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItem4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItem5 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.tabBarItem1];
    [self addSubview:self.tabBarItem2];
    [self addSubview:self.tabBarItem3];
    [self addSubview:self.tabBarItem4];
    [self addSubview:self.tabBarItem5];
    
    switch (viewNum) {
        case 101:
            self.tabBarItem1.selected = YES;
            self.tabBarItem2.selected = NO;
            self.tabBarItem3.selected = NO;
            self.tabBarItem4.selected = NO;
            self.tabBarItem5.selected = NO;
            self.tabBarItem1.accessibilityLabel = AMLocalizedString(@"tab1s", nil);
            break;
        case 102:
            self.tabBarItem1.selected = NO;
            self.tabBarItem2.selected = YES;
            self.tabBarItem3.selected = NO;
            self.tabBarItem4.selected = NO;
            self.tabBarItem5.selected = NO;
            self.tabBarItem2.accessibilityLabel = AMLocalizedString(@"tab2s", nil);
            break;
        case 103:
            self.tabBarItem1.selected = NO;
            self.tabBarItem2.selected = NO;
            self.tabBarItem3.selected = YES;
            self.tabBarItem4.selected = NO;
            self.tabBarItem5.selected = NO;
            self.tabBarItem3.accessibilityLabel = AMLocalizedString(@"tab3s", nil);
            break;
        case 104:
            self.tabBarItem1.selected = NO;
            self.tabBarItem2.selected = NO;
            self.tabBarItem3.selected = NO;
            self.tabBarItem4.selected = YES;
            self.tabBarItem5.selected = NO;
            self.tabBarItem4.accessibilityLabel = AMLocalizedString(@"tab4s", nil);
            break;
        case 105:
            self.tabBarItem1.selected = NO;
            self.tabBarItem2.selected = NO;
            self.tabBarItem3.selected = NO;
            self.tabBarItem4.selected = NO;
            self.tabBarItem5.selected = YES;
            self.tabBarItem5.accessibilityLabel = AMLocalizedString(@"tab5s", nil);
            break;
            
        default:
            break;
    }

}

- (void)buttonClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc1 = [storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
    UIViewController *ivc2 = [storyboard instantiateViewControllerWithIdentifier:@"SeminarViewController"];
    UIViewController *ivc3 = [storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
    UIViewController *ivc4 = [storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    UIViewController *ivc5 = [storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
    UINavigationController *nc;
    switch (btn.tag) {
        case 101:
            nc = [[UINavigationController alloc] initWithRootViewController:ivc1];
            break;
        case 102:
            nc = [[UINavigationController alloc] initWithRootViewController:ivc2];
            break;
        case 103:
            nc = [[UINavigationController alloc] initWithRootViewController:ivc3];
            break;
        case 104:
            nc = [[UINavigationController alloc] initWithRootViewController:ivc4];
            break;
        case 105:
            nc = [[UINavigationController alloc] initWithRootViewController:ivc5];
            break;
            
        default:
            break;
    }
    [nc popToRootViewControllerAnimated:NO];
    self.window.rootViewController = nc;
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    item.imageInsets = UIEdgeInsetsMake(-4, -4, -4, -4);
    NSInteger selectedTag = tabBar.selectedItem.tag;
    NSLog(@"%ld",(long)selectedTag);
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    if (selectedTag == 0) {
        
        UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ivc];
        [nc popToRootViewControllerAnimated:NO];
        self.window.rootViewController = nc;
        
        //Do what ever you want here
    } else if(selectedTag == 1) {
        UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"SeminarViewController"];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ivc];
        [nc popToRootViewControllerAnimated:NO];
        self.window.rootViewController = nc;
        
        //Do what ever you want
    }else if(selectedTag == 2) {
        UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ivc];
        [nc popToRootViewControllerAnimated:NO];
        self.window.rootViewController = nc;
        
        //Do what ever you want
    }else if(selectedTag == 3) {
        UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ivc];
        [nc popToRootViewControllerAnimated:NO];
        self.window.rootViewController = nc;
        
        //Do what ever you want
    }else if(selectedTag == 4) {
        UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ivc];
        [nc popToRootViewControllerAnimated:NO];
        self.window.rootViewController = nc;
        
        //Do what ever you want
    }
}

- (void)changeTabBarTitle:(NSNotification *)notification {
    CGFloat itemWidth = self.frame.size.width/5;
    CGFloat itemHeight = self.frame.size.height;
    [self.tabBarItem1 setFrame:CGRectMake(0, 0, itemWidth, itemHeight)];
    [self.tabBarItem2 setFrame:CGRectMake(itemWidth, 0, itemWidth, itemHeight)];
    [self.tabBarItem3 setFrame:CGRectMake(itemWidth*2, 0, itemWidth, itemHeight)];
    [self.tabBarItem4 setFrame:CGRectMake(itemWidth*3, 0, itemWidth, itemHeight)];
    [self.tabBarItem5 setFrame:CGRectMake(itemWidth*4, 0, itemWidth, itemHeight)];
    
    CGFloat scale, imgHeight;
    scale = 40/35;
    imgHeight = itemHeight;
    
    if (isiPad) {
        [self.tabBarItem1 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg1",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem1 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg1",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [self.tabBarItem2 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem2 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [self.tabBarItem3 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg3",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem3 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg3",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [self.tabBarItem4 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg4",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem4 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg4",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [self.tabBarItem5 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg5",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.tabBarItem5 setImage:[[UIImage imageNamed:AMLocalizedString(@"tabimg5",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    } else {
        UIImage *icon;
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg1",nil)];
        [self.tabBarItem1 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg1s",nil)];
        [self.tabBarItem1 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)];
        [self.tabBarItem2 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg2s",nil)];
        [self.tabBarItem2 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg3",nil)];
        [self.tabBarItem3 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg3s",nil)];
        [self.tabBarItem3 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg4",nil)];
        [self.tabBarItem4 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg4s",nil)];
        [self.tabBarItem4 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg5",nil)];
        [self.tabBarItem5 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        icon = [UIImage imageNamed:AMLocalizedString(@"tabimg5s",nil)];
        [self.tabBarItem5 setImage:[[AppDelegate imageWithImage:icon  scaledToSize:CGSizeMake(icon.size.width*itemHeight/icon.size.height, imgHeight)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    }

    self.tabBarItem1.isAccessibilityElement = YES;
    self.tabBarItem2.isAccessibilityElement = YES;
    self.tabBarItem3.isAccessibilityElement = YES;
    self.tabBarItem4.isAccessibilityElement = YES;
    self.tabBarItem5.isAccessibilityElement = YES;
    
    self.tabBarItem1.accessibilityLabel = AMLocalizedString(@"tab1", nil);
    self.tabBarItem2.accessibilityLabel = AMLocalizedString(@"tab2", nil);
    self.tabBarItem3.accessibilityLabel = AMLocalizedString(@"tab3", nil);
    self.tabBarItem4.accessibilityLabel = AMLocalizedString(@"tab4", nil);
    self.tabBarItem5.accessibilityLabel = AMLocalizedString(@"tab5", nil);
    
    self.tabBarItem1.contentMode = UIViewContentModeCenter;
    self.tabBarItem2.contentMode = UIViewContentModeCenter;
    self.tabBarItem3.contentMode = UIViewContentModeCenter;
    self.tabBarItem4.contentMode = UIViewContentModeCenter;
    self.tabBarItem5.contentMode = UIViewContentModeCenter;
    
    self.tabBarItem1.tag = 101;
    self.tabBarItem2.tag = 102;
    self.tabBarItem3.tag = 103;
    self.tabBarItem4.tag = 104;
    self.tabBarItem5.tag = 105;
    [self.tabBarItem1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItem2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItem3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItem4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItem5 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.tabBarItem1];
    [self addSubview:self.tabBarItem2];
    [self addSubview:self.tabBarItem3];
    [self addSubview:self.tabBarItem4];
    [self addSubview:self.tabBarItem5];
    
    int viewNum = [AppDelegate sharedAppDelegate].viewNum+100;
    switch (viewNum) {
        case 101:
            self.tabBarItem1.selected = YES;
            self.tabBarItem2.selected = NO;
            self.tabBarItem3.selected = NO;
            self.tabBarItem4.selected = NO;
            self.tabBarItem5.selected = NO;
            self.tabBarItem1.accessibilityLabel = AMLocalizedString(@"tab1s", nil);
            break;
        case 102:
            self.tabBarItem1.selected = NO;
            self.tabBarItem2.selected = YES;
            self.tabBarItem3.selected = NO;
            self.tabBarItem4.selected = NO;
            self.tabBarItem5.selected = NO;
            self.tabBarItem2.accessibilityLabel = AMLocalizedString(@"tab2s", nil);
            break;
        case 103:
            self.tabBarItem1.selected = NO;
            self.tabBarItem2.selected = NO;
            self.tabBarItem3.selected = YES;
            self.tabBarItem4.selected = NO;
            self.tabBarItem5.selected = NO;
            self.tabBarItem3.accessibilityLabel = AMLocalizedString(@"tab3s", nil);
            break;
        case 104:
            self.tabBarItem1.selected = NO;
            self.tabBarItem2.selected = NO;
            self.tabBarItem3.selected = NO;
            self.tabBarItem4.selected = YES;
            self.tabBarItem5.selected = NO;
            self.tabBarItem4.accessibilityLabel = AMLocalizedString(@"tab4s", nil);
            break;
        case 105:
            self.tabBarItem1.selected = NO;
            self.tabBarItem2.selected = NO;
            self.tabBarItem3.selected = NO;
            self.tabBarItem4.selected = YES;
            self.tabBarItem5.selected = NO;
            self.tabBarItem5.accessibilityLabel = AMLocalizedString(@"tab5s", nil);
            break;
            
        default:
            break;
    }
}

@end
