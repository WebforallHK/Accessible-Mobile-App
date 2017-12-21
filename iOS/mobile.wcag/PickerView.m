//
//  PickerView.m
//  <>
//
//  Created by Naveen Shan.
//  Copyright © 2015. All rights reserved.
//

#import "PickerView.h"
#import "DateUtil.h"

#pragma mark - Picker Controller



@implementation PickerAlertController

- (instancetype)init    {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.toolbar = [[UIToolbar alloc] init];
    self.toolbar.clipsToBounds = YES;
    [self.view addSubview:self.toolbar];
    
    self.cancelButton = [[UIBarButtonItem alloc] initWithTitle:AMLocalizedString(@"Cancel", nil) style:UIBarButtonItemStylePlain target:self
          action:@selector(pickerCancel:)];

    self.doneButton = [[UIBarButtonItem alloc] initWithTitle:AMLocalizedString(@"Confirm", nil) style:UIBarButtonItemStylePlain target:self
            action:@selector(pickerDone:)];
    self.flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    self.titleButton = [[UIBarButtonItem alloc] initWithTitle:self.pickerTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.titleButton.tintColor = [UIColor blackColor];
    self.titleButton.isAccessibilityElement = NO;

    [self.toolbar setItems:@[self.cancelButton,self.flexibleButton,self.flexibleButton,self.doneButton]];
    [self createPickerView];
    
}

- (void)createPickerView {
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.clipsToBounds = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.isAccessibilityElement = YES;
    [self.view addSubview:self.pickerView];
}

- (void)setOptions:(NSArray *)options {
    _options = options;
    
    if ([options count] > 0) {
        self.selectedOption = self.options.firstObject;
    }
}

-(void)selectRow:(int)val{
    [self.pickerView selectRow:val inComponent:0 animated:YES];
}

- (void)setPickerTitle:(NSString *)pickerTitle {
    _pickerTitle = pickerTitle;
    
    self.titleButton.title = pickerTitle;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat screenWidth = self.view.frame.size.width;
    self.toolbar.frame = CGRectMake(0, 0, screenWidth, 0);
    [self.toolbar sizeToFit];
    self.pickerView.frame = CGRectMake(0, self.toolbar.bounds.size.height, screenWidth, 180);
    self.accessibilityElements = @[self.cancelButton, self.titleButton, self.doneButton];
    self.flexibleButton.isAccessibilityElement = NO;
}

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.options.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component   {
    return self.options[row];
}

#pragma mark - UIPickerView Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component  {
    self.selectedOption = self.options[row];
    NSLog(@"row=%ld", (long)row);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    NSString *rowItem = [self.options objectAtIndex: row];
    
    // Create and init a new UILabel.
    // We must set our label's width equal to our picker's width.
    // We'll give the default height in each row.
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    
    // Center the text.
    [lblRow setTextAlignment:NSTextAlignmentCenter];
    
    // Make the text color red.
    [lblRow setTextColor: [UIColor blackColor]];
    
    // Add the text.
    [lblRow setText:rowItem];
    
    // Clear the background color to avoid problems with the display.
    [lblRow setBackgroundColor:[UIColor clearColor]];
    
    // Return the label.
    return lblRow;
}

#pragma mark -

- (void)pickerDone:(id)sender {
    if (self.pickerDoneBlock) {
        self.pickerDoneBlock(self.selectedOption);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pickerCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

#pragma mark - DatePicker Controller

@interface DatePickerController : PickerAlertController

@property (nonatomic, strong) UIDatePicker *datePickerView;
@property (nonatomic, copy) void (^datePickerDoneBlock)(NSDate *selectedDate);

@end

@implementation DatePickerController

- (void)createPickerView {
    self.datePickerView = [[UIDatePicker alloc] init];
    self.datePickerView.clipsToBounds = YES;
    if([LocalizationGetLanguage hasPrefix:@"en"])
        self.datePickerView.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    else if ([LocalizationGetLanguage hasPrefix:@"zh-Hant"])
        self.datePickerView.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hant_HK"];
    else if ([LocalizationGetLanguage hasPrefix:@"zh-Hans"])
        self.datePickerView.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"];
    else
        self.datePickerView.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    self.datePickerView.isAccessibilityElement = YES;
    [self.view addSubview:self.datePickerView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat screenWidth = self.view.frame.size.width;
    self.datePickerView.frame = CGRectMake(0, self.toolbar.bounds.size.height, screenWidth, 180);
}

#pragma mark -

- (void)pickerDone:(id)sender {
    if (self.datePickerDoneBlock) {
        self.datePickerDoneBlock(self.datePickerView.date);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

#pragma mark - Picker View

@implementation PickerView

+ (UIViewController *)presentationContorller    {
    UIViewController *presentationContorller = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (presentationContorller == nil) {
        presentationContorller = [[[UIApplication sharedApplication] windows] firstObject].rootViewController;
    }
    
    if (![presentationContorller isMemberOfClass:[UIViewController class]]) {
        if ([presentationContorller isKindOfClass:[UITabBarController class]]) {
            presentationContorller = ((UITabBarController *)presentationContorller).selectedViewController;
        } else if ([presentationContorller isKindOfClass:[UINavigationController class]]) {
            presentationContorller = ((UINavigationController *)presentationContorller).topViewController;
        }
        else {
            presentationContorller = presentationContorller.presentedViewController;
        }
    }
    
    return presentationContorller;
}

#pragma mark -

+ (void)showPickerWithOptions:(NSArray *)options selectionBlock:(void (^)(NSString *selectedOption))block  {
    [[self class] showPickerWithOptions:options defaultRow:0 title:nil selectionBlock:block];
}

+ (void)showPickerWithOptions:(NSArray *)options defaultRow:(int)val title:(NSString *)title selectionBlock:(void (^)(NSString *selectedOption))block  {

    PickerAlertController *alertController = [PickerAlertController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n\n\n\n\n"preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.options = options;
    alertController.pickerTitle = title;
    [alertController selectRow:val];

    [alertController setPickerDoneBlock:block];
    
    [[[self class] presentationContorller] presentViewController:alertController animated:YES completion:nil];
}

+ (void)showPickerWithOptionsIPad:(NSArray *)options defaultRow:(int)val title:(NSString *)title button:(UIButton *)button selectionBlock:(void (^)(NSString *selectedOption))block  {

    PickerAlertController *alertController = [PickerAlertController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n\n\n\n\n"preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.options = options;
    alertController.pickerTitle = title;
    [alertController selectRow:val];
    [alertController setPickerDoneBlock:block];
    
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];

    popPresenter.sourceView = button;
    popPresenter.sourceRect = button.bounds;
    [[[self class] presentationContorller]  presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark -

+ (void)showDatePickerWithTitle:(NSString *)title dateMode:(UIDatePickerMode)mode minDateStr:(NSString *)minDateStr maxDateStr:(NSString *)maxDateStr defaultDateStr:(NSString *)defaultDateStr selectionBlock:(void (^)(NSDate *selectedDate))block  {
    DatePickerController *alertController = [DatePickerController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n\n\n\n\n"preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.pickerTitle = title;
    alertController.datePickerView.datePickerMode = mode;
    if(minDateStr)
        alertController.datePickerView.minimumDate = [DateUtil dateFromString:minDateStr];
    if(maxDateStr)
        alertController.datePickerView.maximumDate = [DateUtil dateFromString:maxDateStr];
    if(defaultDateStr)
        [alertController.datePickerView  setDate:[DateUtil dateFromString:defaultDateStr] animated:YES];
    [alertController setDatePickerDoneBlock:block];
    
    [[[self class] presentationContorller] presentViewController:alertController animated:YES completion:nil];
}

+ (void)showDatePickerWithTitleIPad:(NSString *)title dateMode:(UIDatePickerMode)mode minDateStr:(NSString *)minDateStr maxDateStr:(NSString *)maxDateStr defaultDateStr:(NSString *)defaultDateStr button:(UIButton *)button selectionBlock:(void (^)(NSDate *selectedDate))block  {
    DatePickerController *alertController = [DatePickerController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n\n\n\n\n"preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.pickerTitle = title;
    alertController.datePickerView.datePickerMode = mode;
    if(minDateStr)
        alertController.datePickerView.minimumDate = [DateUtil dateFromString:minDateStr];
    if(maxDateStr)
        alertController.datePickerView.maximumDate = [DateUtil dateFromString:maxDateStr];
    if(defaultDateStr)
        [alertController.datePickerView  setDate:[DateUtil dateFromString:defaultDateStr] animated:YES];
    [alertController setDatePickerDoneBlock:block];
    
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    popPresenter.sourceView = button;
    popPresenter.sourceRect = button.bounds;
    [[[self class] presentationContorller]  presentViewController:alertController animated:YES completion:nil];
}

+ (void)dismissPicker
{
    [[[self class] presentationContorller] dismissViewControllerAnimated:YES completion:nil];
}

@end
