/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller containing a player view and basic playback controls.
 */


@import Foundation;
@import AVFoundation;
@import CoreMedia.CMTime;
#import "VideoDetailNativeViewController.h"
#import "AAPLPlayerView.h"


// Private properties
@interface VideoDetailNativeViewController ()
{
    AVPlayer *_player;
    AVURLAsset *_asset;
    id<NSObject> _timeObserverToken;
    AVPlayerItem *_playerItem;
    NSString *boldText, *fullText;
    BOOL fullscreen;
    CusTabBarController * tab;
    CGRect orgPlayer, orgControl, orgRewind, orgFastForword, orgPlay, orgStartTime, orgDuration, orgSlider, orgResize, orgScroll;
}

@property AVPlayerItem *playerItem;

@property (readonly) AVPlayerLayer *playerLayer;

@end

@implementation VideoDetailNativeViewController

// MARK: - View Handling

/*
	KVO context used to differentiate KVO callbacks for this class versus other
	classes in its class hierarchy.
 */
static int AAPLPlayerViewControllerKVOContext = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    for(int i=1; i<=3; i++)
//    {
        UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
        leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [leftRecognizer setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:leftRecognizer];
//    }
    fullscreen = NO;
    [self.playerLayer setPlayer:self.player];
//    orgPlayer = self.playerView.bounds;
    
    
//    self.playerView.backgroundColor = [UIColor yellowColor];
//    [self.playerLayer setBackgroundColor:[UIColor greenColor].CGColor];
//    self.playerLayer.borderColor = [UIColor blueColor].CGColor;
//    self.playerLayer.borderWidth = 5.0;
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSUInteger touches = gestureRecognizer.numberOfTouches;
    switch (touches) {
        case 1:
            [self.navigationController popViewControllerAnimated:NO];
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
}

-(BOOL)accessibilityScroll:(UIAccessibilityScrollDirection)direction
{
    if(direction == UIAccessibilityScrollDirectionLeft)
        [self.navigationController popViewControllerAnimated:NO];
    return YES;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     Update the UI when these player properties change.
     
     Use the context parameter to distinguish KVO for our particular observers and not
     those destined for a subclass that also happens to be observing these properties.
     */
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 3;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self addObserver:self forKeyPath:@"asset" options:NSKeyValueObservingOptionNew context:&AAPLPlayerViewControllerKVOContext];
    [self addObserver:self forKeyPath:@"player.currentItem.duration" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:&AAPLPlayerViewControllerKVOContext];
    [self addObserver:self forKeyPath:@"player.rate" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:&AAPLPlayerViewControllerKVOContext];
    [self addObserver:self forKeyPath:@"player.currentItem.status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:&AAPLPlayerViewControllerKVOContext];
    
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.playerView.playerLayer.player = self.player;
    CGRect tframe = self.playerView.frame;
    tframe.size.height = tframe.size.width/16*9;
    self.playerView.frame = tframe;
    
    CGRect tframe2 = self.controlView.frame;
    tframe2.origin.y = CGRectGetMaxY(self.playerView.frame)+20;
    self.controlView.frame = tframe2;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackPressed:)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem.isAccessibilityElement = YES;
    self.navigationItem.leftBarButtonItem.accessibilityLabel = AMLocalizedString(@"BackBtnText", nil);
    self.navigationItem.leftBarButtonItem.accessibilityHint = AMLocalizedString(@"BackBtnText", nil);
    self.navigationItem.leftBarButtonItem.tag = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnMenuPressed:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem.isAccessibilityElement = YES;
    self.navigationItem.rightBarButtonItem.accessibilityLabel = AMLocalizedString(@"MenuBtnText", nil);
    self.navigationItem.rightBarButtonItem.accessibilityHint = AMLocalizedString(@"MenuBtnText", nil);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont fontWithName:@"Arial" size:[AppDelegate sharedAppDelegate].navTitleFont]
                                                                      }];
    [self.navigationController.navigationBar setBarTintColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController setNavigationBarHidden:NO];
//    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    NSString *filepath;
    NSURL *fileURL;
    NSString *lang = @"";
    lang = LocalizationGetLanguage;
    
    self.textView.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
    if ([lang hasPrefix:@"en"] && [self.title isEqualToString:@"Video1Title"]) {
        boldText = @"How to Build Web Accessibility Website / Mobile App";
        
        fullText = @"Introduce web accessibility basic concept and standard and provide practical guide on web accessibility website / mobile app development.";

        filepath = [[NSBundle mainBundle] pathForResource:@"Web Accessibility Campaign Video" ofType:@"mp4"];
    }
    else if([lang hasPrefix:@"en"] && [self.title isEqualToString:@"Video2Title"])
    {
        boldText = @"Why Web Accessibility Website / Mobile App are Necessary";
        
        fullText = @"For people with disabilities, accessible website / mobile app enable them to deal with daily needs and live a more independent life, as well as maximise their potentials in the society.";
        
        filepath = [[NSBundle mainBundle] pathForResource:@"Why Web Accessibility Website  Mobile App are Necessary" ofType:@"mp4"];
    }
    else if ([lang hasPrefix:@"zh-Hant"] && [self.title isEqualToString:@"Video1Title"]) {
        boldText = @"怎樣建立無障礙網頁／流動應用程式";
        
        fullText = @"介紹無障礙設計的基本概念和標準，並提供實用指南，以協助開發無障礙網頁／流動應用程式。";
        
        filepath = [[NSBundle mainBundle] pathForResource:@"Web Accessibility Campaign Video" ofType:@"mp4"];
    }
    else if([lang hasPrefix:@"zh-Hant"] && [self.title isEqualToString:@"Video2Title"])
    {
        boldText = @"為何網頁／流動應用程式要採用無障礙設計";
        
        fullText = @"無障礙網頁／流動應用程式可以協助殘疾人士在知識型社會中更獨立地生活，讓他們充分發揮潛能。";
        
        filepath = [[NSBundle mainBundle] pathForResource:@"Why Web Accessibility Website  Mobile App are Necessary" ofType:@"mp4"];
    }
    else if ([lang hasPrefix:@"zh-Hans"] && [self.title isEqualToString:@"Video1Title"])
    {
        boldText = @"怎样建立无障碍网页／流动应用程式";
        
        fullText = @"介绍无障碍设计的基本概念和标准，并提供实用指南，以协助开发无障碍网页／流动应用程式。";
        
        filepath = [[NSBundle mainBundle] pathForResource:@"Web Accessibility Campaign Video" ofType:@"mp4"];
    }
    else if([lang hasPrefix:@"zh-Hans"] && [self.title isEqualToString:@"Video2Title"])
    {
        boldText = @"为何网页／流动应用程式要采用无障碍设计";
        
        fullText = @"无障碍网页／流动应用程式可以协助残疾人士在知识型社会中更独立地生活，让他们充分发挥潜能。";
        
        filepath = [[NSBundle mainBundle] pathForResource:@"Why Web Accessibility Website  Mobile App are Necessary" ofType:@"mp4"];
    }
    
    self.textLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, self.scrollView.frame.size.width-30, 30)];
    self.textLbl.text = boldText;
    self.textLbl.numberOfLines = 0;
    self.textLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    CGSize expectedLabelSize = [[[NSAttributedString alloc] initWithString:boldText attributes:@{NSFontAttributeName: [AppDelegate sharedAppDelegate].boldTextFont}] boundingRectWithSize:CGSizeMake(self.scrollView.frame.size.width-30, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGRect newFrame = self.textLbl.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.textLbl.frame = newFrame;
    [self.scrollView addSubview:self.textLbl];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, self.textLbl.frame.origin.y + self.textLbl.frame.size.height + 10, self.scrollView.frame.size.width-30, 30)];
    self.textView.text = fullText;
    self.textView.font = [AppDelegate sharedAppDelegate].textFont;
    self.textView.scrollEnabled = NO;
    CGRect frame = self.textView.frame;
    frame.size.height = [self.textView sizeThatFits:CGSizeMake(self.view.frame.size.width-30, MAXFLOAT)].height;
    self.textView.frame = frame;
    [self.textView setUserInteractionEnabled:NO];
    self.textView.textContainer.lineFragmentPadding = 0;
    self.textView.textContainerInset = UIEdgeInsetsZero;
    [self.scrollView addSubview:self.textView];
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, _textLbl.frame.size.height+_textView.frame.size.height+50)];
    
    fileURL = [NSURL fileURLWithPath:filepath];
    
    //NSURL *movieURL = [[NSBundle mainBundle] URLForResource:@"ElephantSeals" withExtension:@"mov"];
    self.asset = [AVURLAsset assetWithURL:fileURL];
    
    // Use a weak self variable to avoid a retain cycle in the block.
    VideoDetailNativeViewController __weak *weakSelf = self;
    _timeObserverToken = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:
                          ^(CMTime time) {
                              weakSelf.timeSlider.value = CMTimeGetSeconds(time);
                          }];
    NSLog(@"playview = %lf, %lf, %lf, %lf", self.playerView.frame.origin.x, self.playerView.frame.origin.y, self.playerView.frame.size.width, self.playerView.frame.size.height);
    orgPlayer = CGRectMake(self.playerView.frame.origin.x, self.playerView.frame.origin.y, self.playerView.frame.size.width, self.playerView.frame.size.height);
    orgControl = self.controlView.frame;
    orgRewind = self.rewindButton.frame;
    orgPlay = self.playPauseButton.frame;
    orgFastForword = self.fastForwardButton.frame;
    orgStartTime = self.startTimeLabel.frame;
    orgSlider = self.timeSlider.frame;
    orgDuration = self.durationLabel.frame;
    orgResize = self.resizeButton.frame;
    orgScroll = self.scrollView.frame;

//    [[AppDelegate sharedAppDelegate] stopMusic];
    
//    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:AMLocalizedString(self.title,nil)];
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:AMLocalizedString(@"VideoTitle",nil)];
    self.startTimeLabel.font = [AppDelegate sharedAppDelegate].textFont;
    self.durationLabel.font = [AppDelegate sharedAppDelegate].textFont;
    self.textView.font = [AppDelegate sharedAppDelegate].textFont;
    
//    self.rewindButton.imageView.backgroundColor = [UIColor whiteColor];
//    self.fastForwardButton.imageView.backgroundColor = [UIColor whiteColor];
//    self.resizeButton.imageView.backgroundColor = [UIColor whiteColor];
//    self.playPauseButton.imageView.backgroundColor = [UIColor whiteColor];

//    self.fullScreenView.hidden = YES;
//    self.resizeButton.isAccessibilityElement = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    if (_timeObserverToken) {
        [self.player removeTimeObserver:_timeObserverToken];
        _timeObserverToken = nil;
    }
    [self.player pause];
    
    [self removeObserver:self forKeyPath:@"asset" context:&AAPLPlayerViewControllerKVOContext];
    [self removeObserver:self forKeyPath:@"player.currentItem.duration" context:&AAPLPlayerViewControllerKVOContext];
    [self removeObserver:self forKeyPath:@"player.rate" context:&AAPLPlayerViewControllerKVOContext];
    [self removeObserver:self forKeyPath:@"player.currentItem.status" context:&AAPLPlayerViewControllerKVOContext];
    
    [self.textLbl removeFromSuperview];
    [self.textView removeFromSuperview];
    [super viewDidDisappear:YES];
}

// MARK: - Properties

// Will attempt load and test these asset keys before playing
+ (NSArray *)assetKeysRequiredToPlay {
    return @[ @"playable", @"hasProtectedContent" ];
}

- (AVPlayer *)player {
    if (!_player)
        _player = [[AVPlayer alloc] init];
    return _player;
}

- (CMTime)currentTime {
    return self.player.currentTime;
}
- (void)setCurrentTime:(CMTime)newCurrentTime {
    [self.player seekToTime:newCurrentTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (CMTime)duration {
    return self.player.currentItem ? self.player.currentItem.duration : kCMTimeZero;
}

- (float)rate {
    return self.player.rate;
}
- (void)setRate:(float)newRate {
    self.player.rate = newRate;
}

- (AVPlayerLayer *)playerLayer {
    return self.playerView.playerLayer;
}

- (AVPlayerItem *)playerItem {
    return _playerItem;
}

- (void)setPlayerItem:(AVPlayerItem *)newPlayerItem {
    if (_playerItem != newPlayerItem) {
        
        _playerItem = newPlayerItem;
        
        // If needed, configure player item here before associating it with a player
        // (example: adding outputs, setting text style rules, selecting media options)
        [self.player replaceCurrentItemWithPlayerItem:_playerItem];
    }
}

// MARK: - Asset Loading

- (void)asynchronouslyLoadURLAsset:(AVURLAsset *)newAsset {
    
    /*
     Using AVAsset now runs the risk of blocking the current thread
     (the main UI thread) whilst I/O happens to populate the
     properties. It's prudent to defer our work until the properties
     we need have been loaded.
     */
    [newAsset loadValuesAsynchronouslyForKeys:VideoDetailNativeViewController.assetKeysRequiredToPlay completionHandler:^{
        
        /*
         The asset invokes its completion handler on an arbitrary queue.
         To avoid multiple threads using our internal state at the same time
         we'll elect to use the main thread at all times, let's dispatch
         our handler to the main queue.
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (newAsset != self.asset) {
                /*
                 self.asset has already changed! No point continuing because
                 another newAsset will come along in a moment.
                 */
                return;
            }
            
            /*
             Test whether the values of each of the keys we need have been
             successfully loaded.
             */
            for (NSString *key in self.class.assetKeysRequiredToPlay) {
                NSError *error = nil;
                if ([newAsset statusOfValueForKey:key error:&error] == AVKeyValueStatusFailed) {
                    
                    NSString *message = [NSString localizedStringWithFormat:AMLocalizedString(@"error.asset_key_%@_failed.description", @"Can't use this AVAsset because one of it's keys failed to load"), key];
                    
                    [self handleErrorWithMessage:message error:error];
                    
                    return;
                }
            }
            
            // We can't play this asset.
            if (!newAsset.playable || newAsset.hasProtectedContent) {
                NSString *message = AMLocalizedString(@"error.asset_not_playable.description", @"Can't use this AVAsset because it isn't playable or has protected content");
                
                [self handleErrorWithMessage:message error:nil];
                
                return;
            }
            
            /*
             We can play this asset. Create a new AVPlayerItem and make it
             our player's current item.
             */
            self.playerItem = [AVPlayerItem playerItemWithAsset:newAsset];
        });
    }];
}

// MARK: - IBActions

- (IBAction)playPauseButtonWasPressed:(UIButton *)sender {
    if (self.player.rate != 1.0) {
        // not playing foward so play
        if (CMTIME_COMPARE_INLINE(self.currentTime, ==, self.duration)) {
            // at end so got back to begining
            self.currentTime = kCMTimeZero;
        }
        [self.player play];
        self.playPauseButton.accessibilityLabel = AMLocalizedString(@"pause", nil);
        self.playPauseButton.accessibilityHint = AMLocalizedString(@"pause", nil);
    } else {
        // playing so pause
        [self.player pause];
        self.playPauseButton.accessibilityLabel = AMLocalizedString(@"play", nil);
        self.playPauseButton.accessibilityHint = AMLocalizedString(@"play", nil);
        
    }
}

- (IBAction)rewindButtonWasPressed:(UIButton *)sender {
    self.rate = MAX(self.player.rate - 2.0, -2.0); // rewind no faster than -2.0
}

- (IBAction)fastForwardButtonWasPressed:(UIButton *)sender {
    self.rate = MIN(self.player.rate + 2.0, 2.0); // fast forward no faster than 2.0
}

- (IBAction)timeSliderDidChange:(UISlider *)sender {
    self.currentTime = CMTimeMakeWithSeconds(sender.value, 1000);
}

- (IBAction)fullScreenButtonWasPressed:(UIButton *)sender {
    if (fullscreen == NO) {
        fullscreen = YES;
    } else {
        fullscreen = NO;
    }
    [self fullScreenSetup];
}

// MARK: - KV Observation

// Update our UI when player or player.currentItem changes
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context != &AAPLPlayerViewControllerKVOContext) {
        // KVO isn't for us.
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if ([keyPath isEqualToString:@"asset"]) {
        if (self.asset) {
            [self asynchronouslyLoadURLAsset:self.asset];
        }
    }
    else if ([keyPath isEqualToString:@"player.currentItem.duration"]) {
        
        // Update timeSlider and enable/disable controls when duration > 0.0
        
        // Handle NSNull value for NSKeyValueChangeNewKey, i.e. when player.currentItem is nil
        NSValue *newDurationAsValue = change[NSKeyValueChangeNewKey];
        CMTime newDuration = [newDurationAsValue isKindOfClass:[NSValue class]] ? newDurationAsValue.CMTimeValue : kCMTimeZero;
        BOOL hasValidDuration = CMTIME_IS_NUMERIC(newDuration) && newDuration.value != 0;
        double newDurationSeconds = hasValidDuration ? CMTimeGetSeconds(newDuration) : 0.0;
        
        self.timeSlider.maximumValue = newDurationSeconds;
        self.timeSlider.value = hasValidDuration ? CMTimeGetSeconds(self.currentTime) : 0.0;
        self.rewindButton.enabled = hasValidDuration;
        self.rewindButton.isAccessibilityElement = YES;
        self.rewindButton.accessibilityLabel = AMLocalizedString(@"rewind", nil);
        self.rewindButton.accessibilityHint = AMLocalizedString(@"rewind", nil);

        self.playPauseButton.enabled = hasValidDuration;
        self.playPauseButton.isAccessibilityElement = YES;
        self.playPauseButton.accessibilityLabel = AMLocalizedString(@"play", nil);
        self.playPauseButton.accessibilityHint = AMLocalizedString(@"play", nil);
        self.fastForwardButton.enabled = hasValidDuration;
        self.fastForwardButton.isAccessibilityElement = YES;
        self.fastForwardButton.accessibilityLabel = AMLocalizedString(@"fastforward", nil);
        self.fastForwardButton.accessibilityHint = AMLocalizedString(@"fastforward", nil);
        self.timeSlider.enabled = hasValidDuration;
        self.startTimeLabel.enabled = hasValidDuration;
        self.durationLabel.enabled = hasValidDuration;
        int wholeMinutes = (int)trunc(newDurationSeconds / 60);
        self.durationLabel.text = [NSString stringWithFormat:@"%d:%02d", wholeMinutes, (int)trunc(newDurationSeconds) - wholeMinutes * 60];
        self.resizeButton.isAccessibilityElement = YES;
        self.resizeButton.accessibilityLabel = AMLocalizedString(@"enlarge", nil);
        self.resizeButton.accessibilityHint = AMLocalizedString(@"enlarge", nil);
    }
    else if ([keyPath isEqualToString:@"player.rate"]) {
        // Update playPauseButton image
        
        double newRate = [change[NSKeyValueChangeNewKey] doubleValue];
        UIImage *buttonImage = (newRate == 1.0) ? [UIImage imageNamed:@"PauseButton"] : [UIImage imageNamed:@"PlayButton"];
        [self.playPauseButton setImage:buttonImage forState:UIControlStateNormal];
        
    }
    else if ([keyPath isEqualToString:@"player.currentItem.status"]) {
        // Display an error if status becomes Failed
        
        // Handle NSNull value for NSKeyValueChangeNewKey, i.e. when player.currentItem is nil
        NSNumber *newStatusAsNumber = change[NSKeyValueChangeNewKey];
        AVPlayerItemStatus newStatus = [newStatusAsNumber isKindOfClass:[NSNumber class]] ? newStatusAsNumber.integerValue : AVPlayerItemStatusUnknown;
        
        if (newStatus == AVPlayerItemStatusFailed) {
            [self handleErrorWithMessage:self.player.currentItem.error.localizedDescription error:self.player.currentItem.error];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// Trigger KVO for anyone observing our properties affected by player and player.currentItem
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"duration"]) {
        return [NSSet setWithArray:@[ @"player.currentItem.duration" ]];
    } else if ([key isEqualToString:@"currentTime"]) {
        return [NSSet setWithArray:@[ @"player.currentItem.currentTime" ]];
    } else if ([key isEqualToString:@"rate"]) {
        return [NSSet setWithArray:@[ @"player.rate" ]];
    } else {
        return [super keyPathsForValuesAffectingValueForKey:key];
    }
}

// MARK: - Error Handling

- (void)handleErrorWithMessage:(NSString *)message error:(NSError *)error {
    NSLog(@"Error occured with message: %@, error: %@.", message, error);
    
    NSString *alertTitle = AMLocalizedString(@"alert.error.title", @"Alert title for errors");
    NSString *defaultAlertMesssage = AMLocalizedString(@"error.default.description", @"Default error message when no NSError provided");
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:alertTitle message:message ?: defaultAlertMesssage preferredStyle:UIAlertControllerStyleAlert];
    
    NSString *alertActionTitle = AMLocalizedString(@"alert.error.actions.OK", @"OK on error alert");
    UIAlertAction *action = [UIAlertAction actionWithTitle:alertActionTitle style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)btnMenuPressed:(id)sender
{
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self.navigationController pushViewController:ivc animated:YES];
}

- (IBAction) btnBackPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)fullScreenSetup {
    CGFloat widthScale = [UIScreen mainScreen].bounds.size.width/320.0;
    CGFloat heightScale = [UIScreen mainScreen].bounds.size.height/568.0;
    
    if (fullscreen == YES) {
        [self.navigationController setNavigationBarHidden:YES];
        tab.hidden = YES;
        
        self.controlView.backgroundColor = [UIColor whiteColor];
        
        
        [self.playerView.layer setAffineTransform:CGAffineTransformMakeRotation(M_PI/2)];
        NSLog(@"controlView:%@",self.controlView);
        NSLog(@"View:%@",self.view);
//        CGRect fullFrame = CGRectMake(self.view.frame.origin.x-self.controlView.frame.origin.x, self.view.frame.origin.x-self.controlView.frame.origin.x, self.view.frame.size.height-self.controlView.frame.size.height, self.view.frame.size.width-self.controlView.frame.size.width);
        CGFloat currentControlX = 50;
        CGRect fullFrame = CGRectMake(currentControlX, self.view.frame.origin.x, self.view.frame.size.width-currentControlX, self.view.frame.size.height);
        self.playerView.frame = fullFrame;
        
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        
        for (UIView *view in self.controlView.subviews) {
            [view.layer setAffineTransform:CGAffineTransformMakeRotation(M_PI/2)];
        }
        self.controlView.frame = CGRectMake(0*widthScale, 0*heightScale, 30*widthScale, 568*heightScale);
        self.rewindButton.frame = CGRectMake(0*widthScale, 0*heightScale, 30*widthScale, 58*heightScale);
        self.playPauseButton.frame = CGRectMake(0*widthScale, 60*heightScale, 30*widthScale, 58*heightScale);
        self.fastForwardButton.frame = CGRectMake(0*widthScale, 120*heightScale, 30*widthScale, 58*heightScale);
        self.startTimeLabel.frame = CGRectMake(5*widthScale, 180*heightScale, 20*widthScale, 42*heightScale);
        self.timeSlider.frame = CGRectMake(0*widthScale, 225*heightScale, 31.5*widthScale, 240*heightScale);
        self.durationLabel.frame = CGRectMake(5*widthScale, 470*heightScale, 20*widthScale, 42*heightScale);
        self.resizeButton.frame = CGRectMake(0*widthScale, 520*heightScale, 30*widthScale, 46*heightScale);
        self.scrollView.hidden = YES;
        [self.resizeButton setImage:[UIImage imageNamed:@"resize2"] forState:UIControlStateNormal];
        self.resizeButton.accessibilityLabel = AMLocalizedString(@"shrink", nil);
        self.resizeButton.accessibilityHint = AMLocalizedString(@"shrink", nil);
    } else {
        [self.navigationController setNavigationBarHidden:NO];
        tab.hidden = NO;
        
        self.controlView.backgroundColor = [UIColor whiteColor];
        
        
        [self.playerView.layer setAffineTransform:CGAffineTransformMakeRotation(2*M_PI)];
        self.playerView.frame = orgPlayer;
        
        
        self.controlView.frame = orgControl;
        for (UIView *view in self.controlView.subviews) {
            [view.layer setAffineTransform:CGAffineTransformMakeRotation(2*M_PI)];
        }
        self.rewindButton.frame = orgRewind;
        self.playPauseButton.frame = orgPlay;
        self.fastForwardButton.frame = orgFastForword;
        self.timeSlider.frame = orgSlider;
        self.startTimeLabel.frame = orgStartTime;
        self.durationLabel.frame = orgDuration;
        self.resizeButton.frame = orgResize;
        self.scrollView.hidden = NO;
        self.scrollView.frame = orgScroll;
        [self.resizeButton setImage:[UIImage imageNamed:@"resize"] forState:UIControlStateNormal];
        self.resizeButton.accessibilityLabel = AMLocalizedString(@"enlarge", nil);
        self.resizeButton.accessibilityHint = AMLocalizedString(@"enlarge", nil);
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end
