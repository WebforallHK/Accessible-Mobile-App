//
//  CusTabBarController.m
//  mobile.wcag
//
//  Created by Macbook on 3/10/2017.
//  Copyright © 2017 Eric Lai. All rights reserved.
//

#import "CusTabBarController.h"

@interface CusTabBarController () {
    UITabBar *myTabBar;
}

@end

@implementation CusTabBarController

+ (instancetype)sharedInstance
{
    static CusTabBarController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CusTabBarController alloc] initWithFrame:CGRectMake(0,([[UIScreen mainScreen]bounds].size.height)-112, ([[UIScreen mainScreen]bounds].size.width), 50)];
        // Do any other initialisation stuff here
        NSLog(@"screenWidth:%f,screenHeight:%f",[[UIScreen mainScreen]bounds].size.height,[[UIScreen mainScreen]bounds].size.height);
    });
    return sharedInstance;
}



- (id)initWithFrame:(CGRect)aRect
{
    if ((self = [super initWithFrame:aRect])) {
        [self startTabBar];
    }
    return self;
}

- (void)startTabBar {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabBarTitle:) name:@"LanguageChangedNotification" object:nil];
    
    myTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0,0, ([[UIScreen mainScreen]bounds].size.width), 50)];
    myTabBar.delegate=self;
    [myTabBar setBarTintColor:[UIColor pxColorWithHexValue:@"#4d4d4d"]];
    [self addSubview:myTabBar];
    
    myTabBar.translucent = false;
    
    
    
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
    
    self.tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg1",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:0];
//    self.tabBarItem1.imageInsets = UIEdgeInsetsMake(-10, 0, 10, -10);
    
    self.tabBarItem1.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg1s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem1.image.isAccessibilityElement = YES;
    self.tabBarItem1.isAccessibilityElement = YES;
    self.tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:1];
    self.tabBarItem2.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg2s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem2.image.isAccessibilityElement = YES;
    self.tabBarItem2.isAccessibilityElement = YES;
    self.tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg3",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:2];
    self.tabBarItem3.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg3s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem3.image.isAccessibilityElement = YES;
    self.tabBarItem3.isAccessibilityElement = YES;
    self.tabBarItem4 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg4",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:3];
    self.tabBarItem4.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg4s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem4.image.isAccessibilityElement = YES;
    self.tabBarItem4.isAccessibilityElement = YES;
    self.tabBarItem5 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg5",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:4];
    self.tabBarItem5.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg5s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem5.image.isAccessibilityElement = YES;
    self.tabBarItem5.isAccessibilityElement = YES;
    
    if (isiPad) {
//        self.tabBarItem1.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
//        self.tabBarItem2.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
//        self.tabBarItem3.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
//        self.tabBarItem4.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
//        self.tabBarItem5.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
    } else {
        self.tabBarItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.tabBarItem2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.tabBarItem3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.tabBarItem4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.tabBarItem5.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    
    self.tabBarItem1.title = nil;
    self.tabBarItem2.title = nil;
    self.tabBarItem3.title = nil;
    self.tabBarItem4.title = nil;
    self.tabBarItem5.title = nil;
    
    [tabBarItems addObject:self.tabBarItem1];
    [tabBarItems addObject:self.tabBarItem2];
    [tabBarItems addObject:self.tabBarItem3];
    [tabBarItems addObject:self.tabBarItem4];
    [tabBarItems addObject:self.tabBarItem5];
    
    
    myTabBar.items = tabBarItems;
    //self.accessibilityElements =@[self.tabBarItem1,self.tabBarItem2,self.tabBarItem3,self.tabBarItem4,self.tabBarItem5];
    if (isiPad) {
        self.accessibilityElements =@[myTabBar];
        self.tabBarItem1.accessibilityLabel = AMLocalizedString(@"About Web", nil);
        //self.tabBarItem1.image.accessibilityHint = AMLocalizedString(@"About Web", nil);
        self.tabBarItem2.accessibilityLabel = AMLocalizedString(@"Seminars", nil);
        //self.tabBarItem2.image.accessibilityHint = AMLocalizedString(@"Seminars", nil);
        self.tabBarItem3.accessibilityLabel = AMLocalizedString(@"Webforall", nil);
        //self.tabBarItem3.image.accessibilityHint = AMLocalizedString(@"Webforall", nil);
        self.tabBarItem4.accessibilityLabel = AMLocalizedString(@"Settings", nil);
        //self.tabBarItem4.image.accessibilityHint = AMLocalizedString(@"Settings", nil);
        self.tabBarItem5.accessibilityLabel = AMLocalizedString(@"Contact Us", nil);
        //self.tabBarItem5.image.accessibilityHint = AMLocalizedString(@"Contact Us", nil);
    } else {
        self.accessibilityElements = @[myTabBar];
        self.tabBarItem1.accessibilityHint = AMLocalizedString(@"About Web", nil);
        self.tabBarItem2.accessibilityHint = AMLocalizedString(@"Seminars", nil);
        self.tabBarItem3.accessibilityHint = AMLocalizedString(@"Webforall", nil);
        self.tabBarItem4.accessibilityHint = AMLocalizedString(@"Settings", nil);
        self.tabBarItem5.accessibilityHint = AMLocalizedString(@"Contact Us", nil);
    }

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
    myTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0,0, ([[UIScreen mainScreen]bounds].size.width), 50)];
    myTabBar.delegate=self;
    [myTabBar setBarTintColor:[UIColor pxColorWithHexValue:@"#4d4d4d"]];
    [self addSubview:myTabBar];
    
    myTabBar.translucent = false;
    
    
    
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
    
    self.tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg1",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:0];
    self.tabBarItem1.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg1s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem1.image.isAccessibilityElement = YES;
    self.tabBarItem1.isAccessibilityElement = YES;
    self.tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:1];
    self.tabBarItem2.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg2s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem2.image.isAccessibilityElement = YES;
    self.tabBarItem2.isAccessibilityElement = YES;
    self.tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg3",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:2];
    self.tabBarItem3.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg3s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem3.image.isAccessibilityElement = YES;
    self.tabBarItem3.isAccessibilityElement = YES;
    self.tabBarItem4 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg4",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:3];
    self.tabBarItem4.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg4s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem4.image.isAccessibilityElement = YES;
    self.tabBarItem4.isAccessibilityElement = YES;
    self.tabBarItem5 = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:AMLocalizedString(@"tabimg5",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:4];
    self.tabBarItem5.selectedImage = [[UIImage imageNamed:AMLocalizedString(@"tabimg5s",nil)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem5.image.isAccessibilityElement = YES;
    self.tabBarItem5.isAccessibilityElement = YES;
    
    [tabBarItems addObject:self.tabBarItem1];
    [tabBarItems addObject:self.tabBarItem2];
    [tabBarItems addObject:self.tabBarItem3];
    [tabBarItems addObject:self.tabBarItem4];
    [tabBarItems addObject:self.tabBarItem5];
    
    myTabBar.items = tabBarItems;
    //self.accessibilityElements =@[self.tabBarItem1,self.tabBarItem2,self.tabBarItem3,self.tabBarItem4,self.tabBarItem5];
//    self.accessibilityElements =@[myTabBar];
    
    if (isiPad) {
        self.accessibilityElements =@[myTabBar];
        self.tabBarItem1.accessibilityLabel = AMLocalizedString(@"About Web", nil);
        //self.tabBarItem1.image.accessibilityHint = AMLocalizedString(@"About Web", nil);
        self.tabBarItem2.accessibilityLabel = AMLocalizedString(@"Seminars", nil);
        //self.tabBarItem2.image.accessibilityHint = AMLocalizedString(@"Seminars", nil);
        self.tabBarItem3.accessibilityLabel = AMLocalizedString(@"Webforall", nil);
        //self.tabBarItem3.image.accessibilityHint = AMLocalizedString(@"Webforall", nil);
        self.tabBarItem4.accessibilityLabel = AMLocalizedString(@"Settings", nil);
        //self.tabBarItem4.image.accessibilityHint = AMLocalizedString(@"Settings", nil);
        self.tabBarItem5.accessibilityLabel = AMLocalizedString(@"Contact Us", nil);
        //self.tabBarItem5.image.accessibilityHint = AMLocalizedString(@"Contact Us", nil);
    } else {
        self.accessibilityElements = @[myTabBar];
        self.tabBarItem1.accessibilityHint = AMLocalizedString(@"About Web", nil);
        self.tabBarItem2.accessibilityHint = AMLocalizedString(@"Seminars", nil);
        self.tabBarItem3.accessibilityHint = AMLocalizedString(@"Webforall", nil);
        self.tabBarItem4.accessibilityHint = AMLocalizedString(@"Settings", nil);
        self.tabBarItem5.accessibilityHint = AMLocalizedString(@"Contact Us", nil);
    }
}

@end
