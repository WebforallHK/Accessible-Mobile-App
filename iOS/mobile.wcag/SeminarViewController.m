//
//  SeminarViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "SeminarViewController.h"
#import "DateUtil.h"
#import "Seminar.h"
#import "SeminarTableViewCell.h"
#import "SeminarDetailViewController.h"

@interface SeminarViewController() {
    int aniTime;
    CusTabBarController *tab;
}

@end

@implementation SeminarViewController
@synthesize mdict;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.titleArray = [[NSMutableArray alloc]initWithObjects:
                       @"Auto Update", @"Font Size", @"Background Music", @"Push Notification", @"Auto Update", nil];
    
    
    NSMutableArray *dateArray = [[NSMutableArray alloc] initWithObjects:@"25/10/2019", @"31/07/2019", @"25/2/2019", @"31/1/2019", @"26/10/2018", @"31/7/2018", @"18/5/2018", @"18/4/2018", @"20/3/2018", @"13/3/2018", @"31/1/2018", @"27/10/2017", @"29/9/2017", @"31/7/2017", @"13/6/2017", @"2/5/2017", @"31/3/2017", @"28/2/2017", @"31/1/2017", @"4/1/2017", @"28/10/2016", @"30/9/2016", @"28/9/2016", @"29/7/2016", @"30/5/2016", @"31/3/2016", @"29/2/2016", @"31/1/2016", @"11/12/2015", @"30/9/2015", @"31/7/2015", @"31/3/2015", @"30/1/2015", @"31/7/2014", @"31/1/2014", @"31/7/2013", nil];
    
    NSMutableArray *timeArray = [[NSMutableArray alloc] initWithObjects:@"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"15:00 – 17:00", @"15:00 – 17:00", @"15:00 – 17:00", @"15:00 – 17:00", @"10:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"15:00 – 18:00", @"17:00 – 18:00", @"09:30 - 12:30", @"15:00 – 18:00", @"10:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"15:00 – 18:00", @"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"10:30 - 12:30", @"10:30 - 12:30", @"10:30 - 12:30", nil];
    
    NSMutableArray *gpsArray = [[NSMutableArray alloc] initWithObjects:@"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.259364, 114.132380", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280210, 114.189675", @"22.280249, 114.172465", @"22.336380, 114.175727", @"22.280768, 114.165425", @"22.274509, 114.172650", @"22.280249, 114.172465", @"22.274509, 114.172650", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.278278, 114.169579", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280768, 114.165425", nil];
    
    //NSMutableDictionary *monthDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Jan",@"1",@"Feb",@"2",@"Mar",@"3",@"Apr",@"4",@"May",@"5",@"June",@"6",@"Jul",@"7",@"Aug",@"8",@"Sep",@"9",@"Oct",@"10",@"Nov",@"11",@"Dec",@"12", nil];
    
    if (self.pastEventArray != nil)
        [self.pastEventArray removeAllObjects];
    else
        self.pastEventArray = [NSMutableArray new];
    
    if (self.futureEventArray != nil)
        [self.futureEventArray removeAllObjects];
    else
        self.futureEventArray = [NSMutableArray new];
    
    if (mdict == nil) {
        mdict = [NSMutableDictionary new];
    } else {
        [mdict removeAllObjects];
    }
    
    if ([[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] != nil) {
        mdict = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] mutableCopy];
    }
    
    for (int i=0; i<[dateArray count]; i++) {
        Seminar *seminar = [[Seminar alloc] init];
        [seminar setDateLong:[dateArray objectAtIndex:i]];
        
        [seminar setTime:[timeArray objectAtIndex:i]];
        [seminar setTitle:[NSString stringWithFormat:@"Seminar%d",i+1]];
        [seminar setVenue:[NSString stringWithFormat:@"Venue%d",i+1]];
        [seminar setDetail:[NSString stringWithFormat:@"Detail%d",i+1]];
        NSArray *tempLocation = [[gpsArray objectAtIndex:i] componentsSeparatedByString: @", "];
        NSString *x = [tempLocation objectAtIndex: 0];
        NSString *y = [tempLocation objectAtIndex: 1];
        [seminar setMapLong:[x doubleValue]];
        [seminar setMapLat:[y doubleValue]];
        
        [seminar setIsBookingByDate:NO];
        NSDate *seminarDate = [DateUtil dateFromString:[dateArray objectAtIndex:i]];
        NSDate *todayDate = [NSDate date];
        if ([DateUtil compareDateStart:seminarDate compareDateEnd:todayDate] > 0) {
            [seminar setIsPastEvent:NO];
            [self.futureEventArray addObject:seminar];
        } else {
            [seminar setIsPastEvent:YES];
            [self.pastEventArray addObject:seminar];
        }
        //[self.seminarArray addObject:seminar];
    }
    
    //[self.findEventBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.findEventBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.findEventBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    
    
    self.findEventBtn.clipsToBounds = YES;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    
    [self.imageView setImage:[UIImage imageNamed:[self.bannerImgArray objectAtIndex:0]]];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [AppDelegate sharedAppDelegate].viewNum = 2;
    tab = [CusTabBarController sharedInstance];
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self.navigationItem setHidesBackButton:YES];
    
    if (self.bannerImgArray != nil)
        [self.bannerImgArray removeAllObjects];
    else
        self.bannerImgArray = [NSMutableArray new];
    [self.bannerImgArray addObjectsFromArray:[NSArray arrayWithObjects:AMLocalizedString(@"SeminarBanner_1",nil), AMLocalizedString(@"SeminarBanner_2",nil), AMLocalizedString(@"SeminarBanner_3",nil), nil]];
    aniTime = 0;
    
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
    
    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"SeminarTitle"];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.leftBarButtonItem.enabled = NO;
//    self.navigationItem.leftBarButtonItem.isAccessibilityElement = NO;
    
    [self.navigationController setNavigationBarHidden:NO];
    NSString *status = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:@"autoUpdate"];
    if(status == nil)
        status = @"Off";
    
    NSString *autoUpdatStr = [NSString stringWithFormat:@"%@ %@", AMLocalizedString(@"Auto Update:", nil), AMLocalizedString(status, nil)];
    [self.autoUpdateBtn setTitle:autoUpdatStr forState:UIControlStateNormal];
//    [self.autoUpdateBtn.titleLabel setBackgroundColor:[UIColor pxColorWithHexValue:@"#3d82c3"]];
//    [self.autoUpdateBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [self.autoUpdateBtn setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 38*[UIScreen mainScreen].bounds.size.height/667)];
    [self.autoUpdateBtn layoutIfNeeded];
    [self.findEventBtn setTitle:AMLocalizedString(@"FindEventBtnText", nil) forState:UIControlStateNormal];
    self.findEventBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.autoUpdateBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    
    self.imageView.image = [UIImage imageNamed:[self.bannerImgArray objectAtIndex:0]];
    
    if ([status isEqual: @"On"]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_COUNT_SEM
                                                      target:self
                                                    selector:@selector(rollingImage)
                                                    userInfo:nil
                                                     repeats:YES];
    } else {
        self.imageView.image = [UIImage imageNamed:[self.bannerImgArray objectAtIndex:0]];
    }
    
    [self.tableView reloadData];
//    [self.tabBarController setSelectedIndex:1];
    
    [self.imageView setFrame:CGRectMake(0, self.imageView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.width*210/580)];
    
    if (isiPad)
        [self.tableView setFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.view.frame.size.width, CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.autoUpdateBtn.frame)-CGRectGetHeight(self.imageView.frame)-100)];
    else
        [self.tableView setFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.view.frame.size.width, CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.autoUpdateBtn.frame)-CGRectGetHeight(self.imageView.frame)-49)];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    [tab removeFromSuperview];
}

-(void)rollingImage
{
    if (aniTime > [self.bannerImgArray count] - 1)
        aniTime = 0;

        self.imageView.alpha = 0.0;
        [self.imageView setImage:[UIImage imageNamed:[self.bannerImgArray objectAtIndex:aniTime]]];
        aniTime += 1;
        self.imageView.alpha = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    if(section == 0)
        return [self.futureEventArray count];
    else
        return [self.pastEventArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *aCellIdentifier = nil;
    if (indexPath.row >= 0){
        aCellIdentifier = @"SeminarTableViewCell";
    }
    
    return [self tableView:self.tableView cellForRowAtIndexPath:indexPath forCellIdentifier:aCellIdentifier];
}

#pragma mark - tableviewcell

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath forCellIdentifier:(NSString *)aCellIdentifier{
    
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:aCellIdentifier];
    
    if ([aCellIdentifier isEqualToString:@"SeminarTableViewCell"]){

        NSString *stringKey = nil;
        if (indexPath.row >= 0) {
            stringKey = [NSString stringWithFormat:@"Seminar"];
            Seminar *seminar;
            if(indexPath.section == 0)
                seminar = [self.futureEventArray objectAtIndex:(indexPath.row)];
            else
                seminar = [self.pastEventArray objectAtIndex:(indexPath.row)];
            cell.textLabel.text = [DateUtil formattedDate:[seminar getLdate] language:LocalizationGetLanguage isLongDate:YES];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:[AppDelegate sharedAppDelegate].textFont.pointSize];
            cell.detailTextLabel.text = AMLocalizedString([seminar getTitle], nil);
            cell.detailTextLabel.font = [AppDelegate sharedAppDelegate].textFont;
            cell.detailTextLabel.textColor = [UIColor pxColorWithHexValue:@"#555555"];
            cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.detailTextLabel.numberOfLines = 0;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"accessoryButtonTappedForRowWithIndexPath");
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 120)];
    /* Create custom view to display section header... */
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, SECTION_HEIGHT)];
    vi.isAccessibilityElement = NO;
    [vi setBackgroundColor:[UIColor pxColorWithHexValue:@"#bfe5ee"]];
    [view addSubview:vi];
    UILabel *eventTypeLabel;
    if (isiPad)
        eventTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width-250, SECTION_HEIGHT)];
    else
        eventTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width-180, SECTION_HEIGHT)];
    //[label setFont:[UIFont boldSystemFontOfSize:12]];
    [eventTypeLabel setFont:[UIFont systemFontOfSize:[AppDelegate sharedAppDelegate].btnFont.pointSize weight:2.0]];
    [eventTypeLabel setBackgroundColor:[UIColor pxColorWithHexValue:@"#bfe5ee"]];
    /* Section header is in 0th index... */
    if(section == 0){
        [eventTypeLabel setText:AMLocalizedString(@"News", nil)];
        UIButton *findEventBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [findEventBtn addTarget:self
                   action:@selector(btnFindEventPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [findEventBtn setTitle:AMLocalizedString(@"FindEventBtnText", nil) forState:UIControlStateNormal];
        [findEventBtn.titleLabel setFont:[UIFont systemFontOfSize:[AppDelegate sharedAppDelegate].btnFont.pointSize weight:2.0]];
        if (isiPad)
            findEventBtn.frame = CGRectMake(self.tableView.frame.size.width-240, 0, 200, SECTION_HEIGHT);
        else
            findEventBtn.frame = CGRectMake(self.tableView.frame.size.width-160, 0, 130, SECTION_HEIGHT);
        [findEventBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"#bfe5ee"]];
        [findEventBtn setTitleColor:[UIColor pxColorWithHexValue:@"#424242"] forState:UIControlStateNormal];
        [view addSubview:findEventBtn];
        [view bringSubviewToFront:findEventBtn];
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(findEventBtn.frame), 0, 30, SECTION_HEIGHT)];
        vi.isAccessibilityElement = NO;
        [vi setBackgroundColor:[UIColor pxColorWithHexValue:@"#bfe5ee"]];
        UIImageView *iv_image;
        if (isiPad) {
            iv_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, SECTION_HEIGHT/2-16, 32, 32)];
        }
        else
            iv_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, SECTION_HEIGHT/2-8, 16, 16)];
        iv_image.image = [UIImage imageNamed:@"ico_arrow"];
        vi.isAccessibilityElement = NO;
        [vi addSubview:iv_image];
        [view addSubview:vi];
        if (isiPad) {
            UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-10, 0, 10, SECTION_HEIGHT)];
            vi.isAccessibilityElement = NO;
            [vi setBackgroundColor:[UIColor pxColorWithHexValue:@"#bfe5ee"]];
            [view addSubview:vi];
        }
    } else if(section == 1) {
        [eventTypeLabel setFrame:CGRectMake(20, 0, self.tableView.frame.size.width-180, SECTION_HEIGHT)];
        [eventTypeLabel setText:AMLocalizedString(@"Past Event", nil)];
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width-160, 0, 160, SECTION_HEIGHT)];
        vi.isAccessibilityElement = NO;
        [vi setBackgroundColor:[UIColor pxColorWithHexValue:@"#bfe5ee"]];
        [view addSubview:vi];
    }
    [view addSubview:eventTypeLabel];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEIGHT;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{
    if(section == 0)
        return nil;
    else if(section == 1)
        return AMLocalizedString(@"Past Event", nil);
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:
(NSInteger)section{
    return nil;
}

#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    if(indexPath.row >= 0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"Section:%ld Row:%ld selected and its data is %@",
              indexPath.section,indexPath.row,cell.detailTextLabel.text);
        
        NSString *vcName = @"SeminarDetailViewController";
        
        
        UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
        SeminarDetailViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:vcName];
        if(indexPath.section == 0)
            ivc.seminar = [self.futureEventArray objectAtIndex:(indexPath.row)];
        else if(indexPath.section == 1)
            ivc.seminar = [self.pastEventArray objectAtIndex:(indexPath.row)];
        [self.navigationController pushViewController:ivc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *stringForCell, *stringForCell1;
    if (indexPath.section == 0 || indexPath.section == 1) {
        Seminar *seminar;
        if (indexPath.section == 0)
            seminar = [self.futureEventArray objectAtIndex:indexPath.row];
        else if (indexPath.section == 1)
            seminar = [self.pastEventArray objectAtIndex:indexPath.row];
        stringForCell = AMLocalizedString([seminar getTitle], nil);
        CGSize maximumLabelSize = CGSizeMake(tableView.frame.size.width, FLT_MAX);
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:stringForCell attributes:@{NSFontAttributeName: [AppDelegate sharedAppDelegate].textFont}];
        CGRect expectedLabelRect = [attributedText boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize expectedLabelSize = expectedLabelRect.size;
        
        stringForCell1 = AMLocalizedString([seminar getLdate], nil);
        NSAttributedString *attributedText1 = [[NSAttributedString alloc] initWithString:stringForCell1 attributes:@{NSFontAttributeName: [AppDelegate sharedAppDelegate].textFont}];
        CGRect expectedLabelRect1 = [attributedText1 boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize expectedLabelSize1 = expectedLabelRect1.size;
        
        return expectedLabelSize.height+expectedLabelSize1.height+30;
    } else {
        return 60;
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

-(IBAction)btnFindEventPressed:(id)sender;
{
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterNowViewController"];
    [self.navigationController pushViewController:ivc animated:YES];
}

-(IBAction)btnAutoUpdatePressed:(id)sender
{
    NSString *status = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] objectForKey:@"autoUpdate"];
    NSString *msg = @"";
    if ([status isEqualToString:@"Off"] || status == nil)
        msg = AMLocalizedString(@"Resume?", nil);
    else
        msg = AMLocalizedString(@"Pause?", nil);
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@""
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:AMLocalizedString(@"Confirm", nil)
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                                   if ([status isEqualToString:@"Off"] || status == nil) {
                                       [mdict setObject:@"On" forKey:@"autoUpdate"];
                                       if (self.timer == nil) {
                                           self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_COUNT_SEM
                                                                                         target:self
                                                                                       selector:@selector(rollingImage)
                                                                                       userInfo:nil
                                                                                        repeats:YES];
                                       }
                                   } else {
                                       [mdict setObject:@"Off" forKey:@"autoUpdate"];
                                       [self.timer invalidate];
                                       self.timer = nil;
                                       //[self.timer fire];
                                   }
                                   
                                   [[NSUserDefaults standardUserDefaults] setObject:mdict forKey:@"settingDict"];
                                   NSString *autoUpdatStr = [NSString stringWithFormat:@"%@ %@", AMLocalizedString(@"Auto Update:", nil), AMLocalizedString([mdict objectForKey:@"autoUpdate"], nil)];
                                   [self.autoUpdateBtn setTitle:autoUpdatStr forState:UIControlStateNormal];
                               }];
    
    UIAlertAction* closeButton = [UIAlertAction
                                  actionWithTitle:AMLocalizedString(@"CLOSE", nil)
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action) {
                                      //Handle no, thanks button
                                      
                                  }];
    
    [alert addAction:okButton];
    [alert addAction:closeButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

//- (void)changeTabBarTitle:(NSNotification *)notification {
//    self.tabBarItem.image = [UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)];
//    self.tabBarItem.selectedImage = [UIImage imageNamed:AMLocalizedString(@"tabimg2",nil)];
//    self.tabBarItem.accessibilityLabel = AMLocalizedString(@"Seminars", nil);
//    self.tabBarItem.accessibilityHint = AMLocalizedString(@"Seminars", nil);
//    NSLog(@"tab2");
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint p = scrollView.contentOffset;
    if(scrollView.contentOffset.y<0)
    {   p.y=0;
        scrollView.contentOffset = p;
    }
}

@end
