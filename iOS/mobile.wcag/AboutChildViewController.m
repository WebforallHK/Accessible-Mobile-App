//
//  AboutChildViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "AboutChildViewController.h"
#import "UIColor+PXExtensions.h"

@interface AboutChildViewController () {
    CusTabBarController *tab;
}

@end

@implementation AboutChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.titleArray = [[NSMutableArray alloc]initWithObjects:
                       @"LeadershipTitle", @"AwarenessTitle", @"TipsTitle", @"ExpertiseTitle", nil];
    
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 44;
   
//    for(int i=1; i<=3; i++)
//    {
        UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
        leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [leftRecognizer setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:leftRecognizer];
//    }
    

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
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 1;
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
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"InfoTitle"];
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
                UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
   
    NSString *stringForCell;
    if (indexPath.section == 0) {
        stringForCell = AMLocalizedString([self.titleArray objectAtIndex:indexPath.row], nil);
        
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

#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%ld Row:%ld selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
    
    NSString *vcName;
    vcName = @"AboutDetailViewController";
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:vcName];
    //ivc.title = AMLocalizedString([self.titleArray objectAtIndex:indexPath.row], nil);
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
