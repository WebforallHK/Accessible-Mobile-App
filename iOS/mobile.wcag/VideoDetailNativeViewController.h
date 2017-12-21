/*
	Copyright (C) 2016 Apple Inc. All Rights Reserved.
	See LICENSE.txt for this sample’s licensing information
	
	Abstract:
	View controller containing a player view and basic playback controls.
 */

#ifndef VideoDetailNativeViewController_h
#define VideoDetailNativeViewController_h
#import "AppDelegate.h"
#import "CusTabBarController.h"

@import UIKit;

@class AAPLPlayerView;

@interface VideoDetailNativeViewController : UIViewController

@property (readonly) AVPlayer *player;
@property AVURLAsset *asset;

@property CMTime currentTime;
@property (readonly) CMTime duration;
@property float rate;

@property (nonatomic, strong) IBOutlet UISlider *timeSlider;
@property (nonatomic, strong) IBOutlet UILabel *startTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *durationLabel;
@property (nonatomic, strong) IBOutlet UIButton *rewindButton;
@property (nonatomic, strong) IBOutlet UIButton *playPauseButton;
@property (nonatomic, strong) IBOutlet UIButton *fastForwardButton;
@property (nonatomic, strong) IBOutlet UIButton *resizeButton;
@property (nonatomic, strong) IBOutlet AAPLPlayerView *playerView;
@property (nonatomic, strong) IBOutlet UILabel *textLbl;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
#endif /* VideoDetailNativeViewController_h */
