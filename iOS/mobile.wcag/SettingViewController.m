//
//  SettingViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "SettingViewController.h"
#import "UIColor+PXExtensions.h"
#import "SettingDetailViewController.h"

@interface SettingViewController () {
    CusTabBarController *tab;
}

@end

@implementation SettingViewController

@synthesize optionArray, mdict;

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
    
    CusTabBarController * tab = [CusTabBarController sharedInstance];
    tab.viewNum = 4;
    [self.view addSubview:tab];
    
    [self.tableView setAlwaysBounceVertical:NO];
    self.tableView.bounces = NO;
    self.tableView.scrollEnabled = NO;
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [AppDelegate sharedAppDelegate].viewNum = 4;
    tab = [CusTabBarController sharedInstance];
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self.navigationItem setHidesBackButton:YES];
    
    
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
    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"SettingTitle"];
    [self.navigationController setNavigationBarHidden:NO];

    
    if ([[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] != nil) {
        mdict = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] mutableCopy];
    }
    
    [self.tableView reloadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return [self.titleArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellId = @"SimpleTableId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    NSString *stringForCell;
    if (indexPath.section == 0) {
        stringForCell = AMLocalizedString([self.titleArray objectAtIndex:indexPath.row], nil);
        
    }
    
    [cell.textLabel setText:stringForCell];
    
    if(indexPath.row == 0) {
        if ([mdict objectForKey:@"language"] != nil)
            cell.detailTextLabel.text = AMLocalizedString([mdict objectForKey:@"language"], nil);
        else{
            NSString *lang = @"";
            lang = LocalizationGetLanguage;
            
            if([lang hasPrefix:@"en"])
                cell.detailTextLabel.text = @"English";
            else if([lang hasPrefix:@"zh-Hant"])
                cell.detailTextLabel.text = @"繁體中文";
            else if([lang hasPrefix:@"zh-Hans"])
                cell.detailTextLabel.text = @"简体中文";
        }
        
    }
    
    if(indexPath.row == 1) {
        if ([mdict objectForKey:@"fontSize"] != nil)
            cell.detailTextLabel.text = AMLocalizedString([mdict objectForKey:@"fontSize"], nil);
        else
            cell.detailTextLabel.text = AMLocalizedString(@"Medium", nil);
    }
    
    if(indexPath.row == 2) {
        if ([mdict objectForKey:@"bgm"] != nil)
            cell.detailTextLabel.text = AMLocalizedString([mdict objectForKey:@"bgm"], nil);
        else
            cell.detailTextLabel.text = AMLocalizedString(@"Off", nil);
    }
    
    if(indexPath.row == 4) {
        if ([mdict objectForKey:@"autoUpdate"] != nil)
            cell.detailTextLabel.text = AMLocalizedString([mdict objectForKey:@"autoUpdate"], nil);
        else
            cell.detailTextLabel.text = AMLocalizedString(@"Off", nil);
    }
    
    
    cell.textLabel.font = [AppDelegate sharedAppDelegate].textFont;
    cell.detailTextLabel.font = [AppDelegate sharedAppDelegate].dtextFont;
    cell.detailTextLabel.textColor = [UIColor pxColorWithHexValue:@"#555555"];
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

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:
(NSInteger)section{
    return nil;
}

#pragma mark - TableView delegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%ld Row:%ld selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSString *vcName = @"SettingDetailViewController";;
    if(indexPath.row == 0) {
        [dict setObject:@"language" forKey:@"pageType"];
    }
    else if(indexPath.row == 1) {
        [dict setObject:@"fontSize" forKey:@"pageType"];
    }
    else if(indexPath.row == 2) {
        [dict setObject:@"bgm" forKey:@"pageType"];
    } else if(indexPath.row == 3) {
        [dict setObject:@"pushNotification" forKey:@"pageType"];
    }
    else if(indexPath.row == 4) {
        [dict setObject:@"autoUpdate" forKey:@"pageType"];
    }
    
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    if ([vcName isEqualToString:@"SettingDetailViewController"]) {
        SettingDetailViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:vcName];
        dvc.passDict = dict;
        [self.navigationController pushViewController:dvc animated:YES];
    } else {
        UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:vcName];
        [self.navigationController pushViewController:ivc animated:YES];
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

- (IBAction)btnSwitchPress:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.selected == NO) {
        btn.selected = YES;
        if (btn.tag == 2)
            [mdict setObject:@"YES" forKey:@"Bgm"];
        else if (btn.tag == 4)
            [mdict setObject:@"YES" forKey:@"AutoUpdate"];
    } else {
        btn.selected = NO;
        if (btn.tag == 2)
            [mdict setObject:@"NO" forKey:@"Bgm"];
        else if (btn.tag == 4)
            [mdict setObject:@"NO" forKey:@"AutoUpdate"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mdict forKey:@"settingDict"];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat row_height = 30;
    NSString *fontSize = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:@"fontSize"];
    if (isiPad) {
        if ([fontSize isEqualToString:@"Small"]) {
            row_height = 40;
        } else if ([fontSize isEqualToString:@"Large"]) {
            row_height = 70;
        } else {
            row_height = 50;
        }
    } else {
        if ([fontSize isEqualToString:@"Small"]) {
            row_height = 30;
        } else if ([fontSize isEqualToString:@"Large"]) {
            row_height = 60;
        } else {
            row_height = 40;
        }
    }
    return row_height*1.5;
}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}


@end
