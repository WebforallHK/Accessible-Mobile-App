//
//  MenuViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "MenuViewController.h"
#import "UIColor+PXExtensions.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.titleArray = [[NSMutableArray alloc]initWithObjects:
               @"Home", @"About Web", @"Seminars", @"Webforall", @"Settings", @"Contact Us", nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self.navigationItem setHidesBackButton:YES];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnMenuPressed:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem.isAccessibilityElement = YES;
    self.navigationItem.rightBarButtonItem.accessibilityLabel = AMLocalizedString(@"MenuClose", nil);
    self.navigationItem.rightBarButtonItem.accessibilityHint = AMLocalizedString(@"MenuClose", nil);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont fontWithName:@"Arial" size:[AppDelegate sharedAppDelegate].navTitleFont]
                                                                      }];
    [self.navigationController.navigationBar setBarTintColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.navigationItem.isAccessibilityElement = YES;
    self.navigationController.navigationBar.accessibilityLabel = AMLocalizedString(@"MenuTitle", nil);
    self.navigationItem.accessibilityLabel  = AMLocalizedString(@"MenuTitle", nil);
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:AMLocalizedString(@"MenuTitle",nil)];
    [self.navigationController setNavigationBarHidden:NO];
    
    self.tabBarController.tabBar.hidden = YES;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data source

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
    return row_height;
}

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
                UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if(indexPath.row == 0)
        cell.imageView.image = [UIImage imageNamed:@"ico_home.png"];
    else if(indexPath.row == 1)
        cell.imageView.image = [UIImage imageNamed:@"ico_about.png"];
    else if(indexPath.row == 2)
        cell.imageView.image = [UIImage imageNamed:@"ico_seminars.png"];
    else if(indexPath.row == 3)
        cell.imageView.image = [UIImage imageNamed:@"ico_video.png"];
    else if(indexPath.row == 4)
        cell.imageView.image = [UIImage imageNamed:@"ico_setting.png"];
    else if(indexPath.row == 5)
        cell.imageView.image = [UIImage imageNamed:@"ico_contact.png"];
    NSString *stringForCell;
    if (indexPath.section == 0) {
        stringForCell = AMLocalizedString([self.titleArray objectAtIndex:indexPath.row], nil);
        
    }
    
    [cell.textLabel setText:stringForCell];
    cell.textLabel.font = [AppDelegate sharedAppDelegate].textFont;
    cell.textLabel.numberOfLines = 0;
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
    NSString *vcName;
    if(indexPath.row == 0)
        vcName = @"MainScreenViewController";
    else if(indexPath.row == 1)
        vcName = @"AboutViewController";
    else if(indexPath.row == 2)
        vcName = @"SeminarViewController";
    else if(indexPath.row == 3)
        vcName = @"VideoViewController";
    else if(indexPath.row == 4)
        vcName = @"SettingViewController";
    else if(indexPath.row == 5)
        vcName = @"ContactUsViewController";

    
    //tobe
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:vcName];
    
    NSLog(@"vcs0:%@",self.navigationController.viewControllers);

    if (indexPath.row == 0) {
        [self.navigationController pushViewController:ivc animated:YES];
    } else {
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ivc];
        [nc popToRootViewControllerAnimated:NO];
        [self.navigationController pushViewController:ivc animated:YES];

    }
    
    NSLog(@"vcs2:%@",self.navigationController.viewControllers);

}


- (IBAction)btnMenuPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
