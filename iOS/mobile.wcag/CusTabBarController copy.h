//
//  CusTabBarController.h
//  mobile.wcag
//
//  Created by Macbook on 3/10/2017.
//  Copyright © 2017 Eric Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusTabBarController : UIView <UITabBarDelegate>
@property (nonatomic, strong) UIImageView *imageView;
+ (instancetype)sharedInstance;
@property (nonatomic, strong) UITabBarItem *tabBarItem1;
@property (nonatomic, strong) UITabBarItem *tabBarItem2;
@property (nonatomic, strong) UITabBarItem *tabBarItem3;
@property (nonatomic, strong) UITabBarItem *tabBarItem4;
@property (nonatomic, strong) UITabBarItem *tabBarItem5;

@end
