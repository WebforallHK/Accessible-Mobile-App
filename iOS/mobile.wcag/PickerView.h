//
//  PickerView.h
//  <>
//
//  Created by Naveen Shan.
//  Copyright © 2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickerView : NSObject

+ (void)showPickerWithOptions:(NSArray *)options selectionBlock:(void (^)(NSString *selectedOption))block;
+ (void)showPickerWithOptions:(NSArray *)options defaultRow:(int)val title:(NSString *)title selectionBlock:(void (^)(NSString *selectedOption))block;
+ (void)showPickerWithOptionsIPad:(NSArray *)options defaultRow:(int)val title:(NSString *)title button:(UIButton *)button selectionBlock:(void (^)(NSString *selectedOption))block;

+ (void)showDatePickerWithTitle:(NSString *)title dateMode:(UIDatePickerMode)mode minDateStr:(NSString *)minDateStr maxDateStr:(NSString *)maxDateStr defaultDateStr:(NSString *)defaultDateStr selectionBlock:(void (^)(NSDate *selectedDate))block;
+ (void)showDatePickerWithTitleIPad:(NSString *)title dateMode:(UIDatePickerMode)mode minDateStr:(NSString *)minDateStr maxDateStr:(NSString *)maxDateStr defaultDateStr:(NSString *)defaultDateStr button:(UIButton *)button selectionBlock:(void (^)(NSDate *selectedDate))block;

+ (void)dismissPicker;

@end

@interface PickerAlertController : UIAlertController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSString *pickerTitle;
@property (nonatomic, strong) UIBarButtonItem *titleButton;

@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSString *selectedOption;
@property (nonatomic, copy) void (^pickerDoneBlock)(NSString *selectedOption);

@property (nonatomic, strong) UIBarButtonItem* cancelButton;
@property (nonatomic, strong) UIBarButtonItem* doneButton;
@property (nonatomic, strong) UIBarButtonItem *flexibleButton;
@end
