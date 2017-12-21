//
//  SettingDetailViewController.m
//  mobile.wcag
//
//  Created by Eric Lai on 4/9/2017.
//  Copyright © 2017 Eric Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingDetailViewController.h"
#import "UIColor+PXExtensions.h"
#import "RadioButton.h"

@interface SettingDetailViewController () {
    
}

@end

@implementation SettingDetailViewController
@synthesize mdict,optionArray,buttons;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.titleArray = [[NSMutableArray alloc]initWithObjects:
                       @"Language", @"Font Size", @"Background Music", @"Push Notification", @"Auto Update", nil];
    
    if (optionArray == nil) {
        optionArray = [NSMutableArray new];
    } else {
        [optionArray removeAllObjects];
    }
    if (mdict == nil) {
        mdict = [NSMutableDictionary new];
    } else {
        [mdict removeAllObjects];
    }
    if ([[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] != nil) {
        mdict = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] mutableCopy];
    }
    
    if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"language"]) {
        [optionArray addObjectsFromArray:[NSArray arrayWithObjects:@"English", @"繁體中文", @"简体中文", nil]];
        if ([[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:[self.passDict objectForKey:@"pageType"]] == nil) {
            [mdict setObject:@"English" forKey:[self.passDict objectForKey:@"pageType"]];
        }
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"fontSize"]) {
        [optionArray addObjectsFromArray:[NSArray arrayWithObjects:@"Small", @"Medium", @"Large", nil]];
        if ([[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:[self.passDict objectForKey:@"pageType"]] == nil) {
            [mdict setObject:@"Medium" forKey:[self.passDict objectForKey:@"pageType"]];
        }
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"bgm"]) {
        [optionArray addObjectsFromArray:[NSArray arrayWithObjects:@"On", @"Off", nil]];
        if ([[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:[self.passDict objectForKey:@"pageType"]] == nil) {
            [mdict setObject:@"Off" forKey:[self.passDict objectForKey:@"pageType"]];
        }
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"pushNotification"]) {
        [optionArray addObjectsFromArray:[NSArray arrayWithObjects:@"Ringtone", @"Vibration", nil]];
        for (int i=0; i<[optionArray count]; i++) {
            if ([[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:[optionArray objectAtIndex:i]] == nil) {
                [mdict setObject:@"Off" forKey:[optionArray objectAtIndex:i]];
            }
        }
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"autoUpdate"]) {
        [optionArray addObjectsFromArray:[NSArray arrayWithObjects:@"On", @"Off", nil]];
        if ([[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:[self.passDict objectForKey:@"pageType"]] == nil) {
            [mdict setObject:@"Off" forKey:[self.passDict objectForKey:@"pageType"]];
        }
    }
    buttons = [NSMutableArray arrayWithCapacity:[optionArray count]];
    
    UIButton *btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_confirm setTitle:AMLocalizedString(@"ConfirmChangeBtnText", nil) forState:UIControlStateNormal];
    btn_confirm.titleLabel.textColor = [UIColor whiteColor];
    btn_confirm.backgroundColor = [UIColor pxColorWithHexValue:@"3f51b5"];
    [btn_confirm setFrame:CGRectMake(37.0*[[UIScreen mainScreen] bounds].size.width/320, [[UIScreen mainScreen] bounds].size.height-(130*[[UIScreen mainScreen] bounds].size.height/667), 245.0*[[UIScreen mainScreen] bounds].size.width/320, 44.0*[[UIScreen mainScreen] bounds].size.height/667)];
    btn_confirm.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    btn_confirm.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    btn_confirm.layer.cornerRadius = btn_confirm.frame.size.height*0.3;
    [btn_confirm addTarget:self action:@selector(btnConfirmPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_confirm];
    
//    for(int i=1; i<=3; i++)
//    {
        UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
        leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [leftRecognizer setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:leftRecognizer];
//    }
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
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

- (void) viewWillAppear:(BOOL)animated
{
    CusTabBarController * tab = [CusTabBarController sharedInstance];
    tab.viewNum = 4;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cellNotification" object:nil];
    
    NSString *title;
    if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"language"]) {
//        self.navigationItem.title = AMLocalizedString(@"LanguageTitle", nil);
        title = AMLocalizedString(@"LanguageTitle", nil);
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"fontSize"]) {
//        self.navigationItem.title = AMLocalizedString(@"FontSizeTitle", nil);
        title = AMLocalizedString(@"FontSizeTitle", nil);
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"bgm"]) {
//        self.navigationItem.title = AMLocalizedString(@"BgmTitle", nil);
        title = AMLocalizedString(@"BgmTitle", nil);
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"pushNotification"]) {
//        self.navigationItem.title = AMLocalizedString(@"PushNotiTitle", nil);
        title = AMLocalizedString(@"PushNotiTitle", nil);
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"autoUpdate"]) {
//        self.navigationItem.title = AMLocalizedString(@"AutoUpdateTitle", nil);
        title = AMLocalizedString(@"AutoUpdateTitle", nil);
    }
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:title];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.navigationController setNavigationBarHidden:NO];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return [optionArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellId = @"SimpleTableId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellId];
    
    
    if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"language"]) {
        RadioButton *btn = [[RadioButton alloc] initWithFrame:cell.accessoryView.frame];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [btn setImage:[UIImage imageNamed:@"indicator"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"indicator_selected"] forState:UIControlStateSelected];
        btn.imageView.transform = CGAffineTransformMakeScale(2, 2);
        [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
        btn.tag = indexPath.row;
        [buttons addObject:btn];
        [btn setGroupButtons:buttons];
        cell.accessoryView = btn;
        if (indexPath.row == 0) {
            cell.accessibilityLabel = AMLocalizedString(@"s1a", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s1a", nil);
        } else if (indexPath.row == 1) {
            cell.accessibilityLabel = AMLocalizedString(@"s1b", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s1b", nil);
        } else {
            cell.accessibilityLabel = AMLocalizedString(@"s1c", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s1c", nil);
        }
        [btn setUserInteractionEnabled:NO];
        btn.isAccessibilityElement = NO;
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"fontSize"]) {
        RadioButton *btn = [[RadioButton alloc] initWithFrame:cell.accessoryView.frame];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [btn setImage:[UIImage imageNamed:@"indicator"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"indicator_selected"] forState:UIControlStateSelected];
        btn.imageView.transform = CGAffineTransformMakeScale(2, 2);
        [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
        btn.tag = indexPath.row;
        [buttons addObject:btn];
        [btn setGroupButtons:buttons];
        cell.accessoryView = btn;
        if (indexPath.row == 0) {
            cell.accessibilityLabel = AMLocalizedString(@"s2a", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s2a", nil);
        } else if (indexPath.row == 1) {
            cell.accessibilityLabel = AMLocalizedString(@"s2b", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s2b", nil);
        } else {
            cell.accessibilityLabel = AMLocalizedString(@"s2c", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s2c", nil);
        }
        [btn setUserInteractionEnabled:NO];
        btn.isAccessibilityElement = NO;
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"bgm"]) {
        RadioButton *btn = [[RadioButton alloc] initWithFrame:cell.accessoryView.frame];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [btn setImage:[UIImage imageNamed:@"indicator"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"indicator_selected"] forState:UIControlStateSelected];
        btn.imageView.transform = CGAffineTransformMakeScale(2, 2);
        [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
        btn.tag = indexPath.row;
        [buttons addObject:btn];
        [btn setGroupButtons:buttons];
        cell.accessoryView = btn;
        if (indexPath.row == 0) {
            cell.accessibilityLabel = AMLocalizedString(@"s3on", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s3on", nil);
        } else if (indexPath.row == 1) {
            cell.accessibilityLabel = AMLocalizedString(@"s3off", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s3off", nil);
        }
        [btn setUserInteractionEnabled:NO];
        btn.isAccessibilityElement = NO;
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"autoUpdate"]) {
        RadioButton *btn = [[RadioButton alloc] initWithFrame:cell.accessoryView.frame];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [btn setImage:[UIImage imageNamed:@"indicator"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"indicator_selected"] forState:UIControlStateSelected];
        btn.imageView.transform = CGAffineTransformMakeScale(2, 2);
        [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
        btn.tag = indexPath.row;
        [buttons addObject:btn];
        [btn setGroupButtons:buttons];
        cell.accessoryView = btn;
        if (indexPath.row == 0) {
            cell.accessibilityLabel = AMLocalizedString(@"s5on", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s5on", nil);
        } else if (indexPath.row == 1) {
            cell.accessibilityLabel = AMLocalizedString(@"s5off", nil);
            btn.accessibilityLabel = AMLocalizedString(@"s5off", nil);
        }
        [btn setUserInteractionEnabled:NO];
        btn.isAccessibilityElement = NO;
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"pushNotification"]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        [btn setImage:[UIImage imageNamed:@"switch_off"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"switch_on"] forState:UIControlStateSelected];
        btn.tag = indexPath.row+100;
        if ([[mdict objectForKey:[optionArray objectAtIndex:indexPath.row]] isEqualToString:@"On"]) {
            [btn setSelected:YES];
            if (indexPath.row == 0) {
                cell.accessibilityLabel = AMLocalizedString(@"ringtoneOn", nil);
                btn.accessibilityLabel = AMLocalizedString(@"ringtoneOn", nil);
            } else if (indexPath.row == 1) {
                cell.accessibilityLabel = AMLocalizedString(@"vibrateOn", nil);
                btn.accessibilityLabel = AMLocalizedString(@"vibrateOn", nil);
            }
        } else {
            [btn setSelected:NO];
            if (indexPath.row == 0) {
                cell.accessibilityLabel = AMLocalizedString(@"ringtoneOff", nil);
                btn.accessibilityLabel = AMLocalizedString(@"ringtoneOff", nil);
            } else if (indexPath.row == 1) {
                cell.accessibilityLabel = AMLocalizedString(@"vibrateOff", nil);
                btn.accessibilityLabel = AMLocalizedString(@"vibrateOff", nil);
            }
        }
        
        NSLog(@"mdict=%@", mdict);
        NSLog(@"optionArray=%@",[optionArray objectAtIndex:indexPath.row]);
        
        cell.detailTextLabel.text = AMLocalizedString([mdict objectForKey:[optionArray objectAtIndex:indexPath.row]], nil);
        
        cell.detailTextLabel.font = [AppDelegate sharedAppDelegate].dtextFont;
        [btn addTarget:self action:@selector(btnSwitchPressed:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = btn;
        tableView.allowsMultipleSelection = NO;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [btn setUserInteractionEnabled:NO];
        btn.isAccessibilityElement = NO;
    }
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    [cell.accessoryView setFrame:CGRectMake(0, 0, 50, 31)];
    

    NSString *stringForCell;

    stringForCell = AMLocalizedString([optionArray objectAtIndex:indexPath.row], nil);
    
    if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"bgm"]) {
        if (indexPath.row == 0) {
            cell.textLabel.text = AMLocalizedString(@"bgmOn", nil);
        } else {
            cell.textLabel.text = AMLocalizedString(@"bgmOff", nil);
        }
    } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"autoUpdate"]) {
        if (indexPath.row == 0) {
            cell.textLabel.text = AMLocalizedString(@"autoUpdateOn", nil);
        } else {
            cell.textLabel.text = AMLocalizedString(@"autoUpdateOff", nil);
        }
    } else {
        [cell.textLabel setText:stringForCell];
    }
    cell.selected = NO;
    
    if ([[mdict objectForKey:[self.passDict objectForKey:@"pageType"]] isEqualToString:[optionArray objectAtIndex:indexPath.row]]) {
        [buttons[indexPath.row] setSelected:YES];
        cell.selected = YES;
    }
        if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"language"]) {
            if (indexPath.row == 0) {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"s1as", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"s1a", nil);
            } else if (indexPath.row == 1) {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"s1bs", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"s1b", nil);
            } else {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"s1cs", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"s1c", nil);
            }
            [[NSNotificationCenter defaultCenter] addObserver:cell selector:@selector(cellMod:) name:@"cellNotification" object:nil];
        } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"fontSize"]) {
            if (indexPath.row == 0) {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"s2as", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"s2a", nil);
            } else if (indexPath.row == 1) {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"s2bs", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"s2b", nil);
            } else {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"s2cs", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"s2c", nil);
            }
            [[NSNotificationCenter defaultCenter] addObserver:cell selector:@selector(cellMod:) name:@"cellNotification" object:nil];
        } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"autoUpdate"]) {
            if (indexPath.row == 0) {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"autoUpdateOns", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"autoUpdateOn", nil);
            } else if (indexPath.row == 1) {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"autoUpdateOffs", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"autoUpdateOff", nil);
            }
            [[NSNotificationCenter defaultCenter] addObserver:cell selector:@selector(cellMod:) name:@"cellNotification" object:nil];
        } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"bgm"]) {
            if (indexPath.row == 0) {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"bgmOns", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"bgmOn", nil);
            } else if (indexPath.row == 1) {
                if (cell.selected == YES)
                    cell.accessibilityLabel = AMLocalizedString(@"bgmOffs", nil);
                else
                    cell.accessibilityLabel = AMLocalizedString(@"bgmOff", nil);
            }
            [[NSNotificationCenter defaultCenter] addObserver:cell selector:@selector(cellMod:) name:@"cellNotification" object:nil];
        }
//    }

    cell.textLabel.font = [AppDelegate sharedAppDelegate].textFont;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return CGFLOAT_MIN+2;
}

#pragma mark - TableView delegate

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return nil;
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%ld Row:%ld selected and its data is %@",
          (long)indexPath.section,(long)indexPath.row,cell.textLabel.text);
    for (UIView *view in cell.subviews) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *btn = (UIButton *)view;
//            if (btn.selected == NO) {
//                btn.selected = YES;
//            } else {
//                btn.selected = NO;
//            }
//            [buttons[btn.tag] setSelected:YES];
//            [mdict setObject:[optionArray objectAtIndex:btn.tag] forKey:[self.passDict objectForKey:@"pageType"]];
//            NSLog(@"RadioButton mdict=%@", mdict);
//        } else if ([view isKindOfClass:[UISwitch class]]) {
//            UISwitch *btn = (UISwitch *)view;
//            if (btn.selected == NO) {
//                if (btn.tag == 0)
//                    [mdict setObject:@"On" forKey:@"Ringtone"];
//                else if (btn.tag == 1)
//                    [mdict setObject:@"On" forKey:@"Vibration"];
//                btn.selected = YES;
//            } else {
//                if (btn.tag == 0)
//                    [mdict setObject:@"Off" forKey:@"Ringtone"];
//                else if (btn.tag == 1)
//                    [mdict setObject:@"Off" forKey:@"Vibration"];
//                btn.selected = NO;
//            }
//        }
        if ([view isKindOfClass:[UIButton class]]) {
            if (view.tag >= 100 && view.tag < 200) {
                UIButton *btn = (UIButton *)view;
                if (btn.selected == NO) {
                    if (btn.tag == 100) {
                        [mdict setObject:@"On" forKey:@"Ringtone"];
                        cell.accessibilityLabel = AMLocalizedString(@"ringtoneOff", nil);
                    }
                    else if (btn.tag == 101) {
                        [mdict setObject:@"On" forKey:@"Vibration"];
                        cell.accessibilityLabel = AMLocalizedString(@"vibrateOff", nil);
                    }
                    btn.selected = YES;
//                    cell.selected = YES;
                } else {
                    if (btn.tag == 100) {
                        [mdict setObject:@"Off" forKey:@"Ringtone"];
                        cell.accessibilityLabel = AMLocalizedString(@"ringtoneOn", nil);
                    }
                    else if (btn.tag == 101) {
                        [mdict setObject:@"Off" forKey:@"Vibration"];
                        cell.accessibilityLabel = AMLocalizedString(@"vibrateOn", nil);
                    }
                    btn.selected = NO;
//                    cell.selected = NO;
                }
            } else {
                UIButton *btn = (UIButton *)view;
                if (btn.selected == NO) {
                    btn.selected = YES;
//                    cell.selected = YES;
                } else {
                    btn.selected = NO;
//                    cell.selected = NO;
                }
                [buttons[btn.tag] setSelected:YES];
                UIButton *selectedBtn = buttons[btn.tag];
                for (int i=0; i<[buttons count];i++) {
                    UIButton *btns = buttons[i];
                    
                    UITableViewCell *cell = (UITableViewCell *)[btns superview];
                    cell.backgroundColor = [UIColor yellowColor];
                    cell.selected = NO;
                }
                UITableViewCell *selectedCell = (UITableViewCell *)[selectedBtn superview];
                selectedCell.backgroundColor = [UIColor redColor];
                selectedCell.selected = YES;
                selectedBtn.backgroundColor = [UIColor greenColor];
                [mdict setObject:[optionArray objectAtIndex:btn.tag] forKey:[self.passDict objectForKey:@"pageType"]];
                NSLog(@"RadioButton mdict=%@", mdict);
                
                if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"language"]) {
                    if (indexPath.row == 0) {
                        if (cell.selected == YES)
//                            cell.accessibilityLabel = AMLocalizedString(@"s1as", nil);
                            cell.backgroundColor = [UIColor redColor];
                        else
//                            cell.accessibilityLabel = AMLocalizedString(@"s1a", nil);
                            cell.backgroundColor = [UIColor blackColor];
                    } else if (indexPath.row == 1) {
                        if (cell.selected == YES)
                            cell.accessibilityLabel = AMLocalizedString(@"s1bs", nil);
                        else
                            cell.accessibilityLabel = AMLocalizedString(@"s1b", nil);
                    } else {
                        if (cell.selected == YES)
                            cell.accessibilityLabel = AMLocalizedString(@"s1cs", nil);
                        else
                            cell.accessibilityLabel = AMLocalizedString(@"s1c", nil);
                    }
                } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"fontSize"]) {
                    if (indexPath.row == 0) {
                        if (cell.selected == YES)
                            cell.accessibilityLabel = AMLocalizedString(@"s2as", nil);
                        else
                            cell.accessibilityLabel = AMLocalizedString(@"s2a", nil);
                    } else if (indexPath.row == 1) {
                        if (cell.selected == YES)
                            cell.accessibilityLabel = AMLocalizedString(@"s2bs", nil);
                        else
                            cell.accessibilityLabel = AMLocalizedString(@"s2b", nil);
                    } else {
                        if (cell.selected == YES)
                            cell.accessibilityLabel = AMLocalizedString(@"s2cs", nil);
                        else
                            cell.accessibilityLabel = AMLocalizedString(@"s2c", nil);
                    }
                } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"autoUpdate"]) {
                    if (indexPath.row == 0) {
                        if (cell.selected == YES)
                            cell.accessibilityLabel = AMLocalizedString(@"autoUpdateOns", nil);
                        else
                            cell.accessibilityLabel = AMLocalizedString(@"autoUpdateOn", nil);
                    } else if (indexPath.row == 1) {
                        if (cell.selected == YES)
                            cell.accessibilityLabel = AMLocalizedString(@"autoUpdateOffs", nil);
                        else
                            cell.accessibilityLabel = AMLocalizedString(@"autoUpdateOff", nil);
                    }
                } else if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"bgm"]) {
                    if (indexPath.row == 0) {
                        if (cell.selected == YES)
                            cell.accessibilityLabel = AMLocalizedString(@"bgmOns", nil);
                        else
                            cell.accessibilityLabel = AMLocalizedString(@"bgmOn", nil);
                    } else if (indexPath.row == 1) {
                        if (cell.selected == YES)
                            cell.accessibilityLabel = AMLocalizedString(@"bgmOffs", nil);
                        else
                            cell.accessibilityLabel = AMLocalizedString(@"bgmOff", nil);
                    }
                }
                
            }
            
        }
        
    }

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

- (IBAction)btnSwitchPressed:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.selected == NO) {
        btn.selected = YES;
        if (btn.tag == 100) {
            [mdict setObject:@"On" forKey:@"Ringtone"];
            
        }
        else if (btn.tag == 101)
            [mdict setObject:@"On" forKey:@"Vibration"];
    } else {
        btn.selected = NO;
        if (btn.tag == 100)
            [mdict setObject:@"Off" forKey:@"Ringtone"];
        else if (btn.tag == 101)
            [mdict setObject:@"Off" forKey:@"Vibration"];
    }
//    [self.tableView reloadData];
}

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
    UIButton *btn = (UIButton *)sender;
    [buttons[btn.tag] setSelected:YES];
    [mdict setObject:[optionArray objectAtIndex:btn.tag] forKey:[self.passDict objectForKey:@"pageType"]];
    NSLog(@"RadioButton mdict=%@", mdict);

}

- (IBAction)btnConfirmPressed:(id)sender {
    if ([[self.passDict objectForKey:@"pageType"] isEqualToString:@"language"]) {
        if (![[mdict objectForKey:[self.passDict objectForKey:@"pageType"]] isEqualToString:[[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:[self.passDict objectForKey:@"pageType"]]]) {
            if ([[mdict objectForKey:@"language"] isEqualToString:@"繁體中文"]) {
//                [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:@"AppleLanguages"];
//                [[LocalizationSystem sharedLocalSystem] setLanguage:@"zh-Hant"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
                //[[UIApplication sharedApplication] setAccessibilityLanguage:@"zh-Hant"];
                LocalizationSetLanguage(@"zh-Hant");
            } else if ([[mdict objectForKey:@"language"] isEqualToString:@"简体中文"]) {
//                [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"AppleLanguages"];
//                [[LocalizationSystem sharedLocalSystem] setLanguage:@"zh-Hans"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
                //[[UIApplication sharedApplication] setAccessibilityLanguage:@"zh-Hans-CN"];
                LocalizationSetLanguage(@"zh-Hans");
            } else {
//                [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"AppleLanguages"];
//                [[LocalizationSystem sharedLocalSystem] setLanguage:@"en"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
                //[[UIApplication sharedApplication] setAccessibilityLanguage:@"en-US"];
                LocalizationSetLanguage(@"en");
            }
        }
    }
    else {
    
    }
    [[NSUserDefaults standardUserDefaults] setObject:mdict forKey:@"settingDict"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) btnBackPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}



@end
