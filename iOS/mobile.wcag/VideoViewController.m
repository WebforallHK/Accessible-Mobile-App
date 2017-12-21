//
//  VideoViewController.m
//  mobile.wcag
//
//


#import <Foundation/Foundation.h>
#import "VideoViewController.h"
#import "UIColor+PXExtensions.h"

@interface VideoViewController () {
    CusTabBarController *tab;
}

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

- (void) viewWillAppear:(BOOL)animated
{
    [AppDelegate sharedAppDelegate].viewNum = 3;
    tab = [CusTabBarController sharedInstance];
    [self.view addSubview:tab];
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self.navigationItem setHidesBackButton:YES];
    
    if (self.titleArray != nil)
        [self.titleArray removeAllObjects];
    else
        self.titleArray = [NSMutableArray new];
    [self.titleArray addObjectsFromArray:[NSArray arrayWithObjects:@"Video1Title", @"Video2Title", nil]];
    [self.tableView reloadData];
    
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

    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:AMLocalizedString(@"VideoTitle",nil)];

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
                UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSString *stringForCell;
    if (indexPath.section == 0) {
        stringForCell = AMLocalizedString([self.titleArray objectAtIndex:indexPath.row],nil);
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    vcName = @"VideoDetailNativeViewController";
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:vcName];
    ivc.title = [self.titleArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:ivc animated:YES];
    
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


- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end
