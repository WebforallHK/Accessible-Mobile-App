//
//  RegisterNowViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "RegisterNowViewController.h"
#import "RegisterInfoViewController.h"
#import "DateUtil.h"
#import "PickerView.h"

@interface RegisterNowViewController() {
    CusTabBarController *tab;
}
@end

@implementation RegisterNowViewController

-(void)viewDidLoad
{
    self.seminar = [[Seminar alloc] init];
    [self.seminar setIsBookingByDate:YES];
    
    NSMutableArray *dateArray = [[NSMutableArray alloc] initWithObjects:@"25/10/2019", @"31/07/2019", @"25/2/2019", @"31/1/2019", @"26/10/2018", @"31/7/2018", @"18/5/2018", @"18/4/2018", @"20/3/2018", @"13/3/2018", @"31/1/2018", @"27/10/2017", @"29/9/2017", @"31/7/2017", @"13/6/2017", @"2/5/2017", @"31/3/2017", @"28/2/2017", @"31/1/2017", @"4/1/2017", @"28/10/2016", @"30/9/2016", @"28/9/2016", @"29/7/2016", @"30/5/2016", @"31/3/2016", @"29/2/2016", @"31/1/2016", @"11/12/2015", @"30/9/2015", @"31/7/2015", @"31/3/2015", @"30/1/2015", @"31/7/2014", @"31/1/2014", @"31/7/2013", nil];
    
    NSMutableArray *timeArray = [[NSMutableArray alloc] initWithObjects:@"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"15:00 – 17:00", @"15:00 – 17:00", @"15:00 – 17:00", @"15:00 – 17:00", @"10:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"15:00 – 18:00", @"17:00 – 18:00", @"09:30 - 12:30", @"15:00 – 18:00", @"10:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"15:00 – 18:00", @"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"09:30 - 12:30", @"10:30 - 12:30", @"10:30 - 12:30", @"10:30 - 12:30", @"10:30 - 12:30", nil];
    
    NSMutableArray *gpsArray = [[NSMutableArray alloc] initWithObjects:@"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.259364, 114.132380", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280210, 114.189675", @"22.280249, 114.172465", @"22.336380, 114.175727", @"22.280768, 114.165425", @"22.274509, 114.172650", @"22.280249, 114.172465", @"22.274509, 114.172650", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.278278, 114.169579", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280249, 114.172465", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280768, 114.165425", @"22.280768, 114.165425", nil];
    
    if (self.futureEventArray != nil)
        [self.futureEventArray removeAllObjects];
    else
        self.futureEventArray = [NSMutableArray new];
    
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
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *todayDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:NSCalendarMatchStrictly];
        if ([DateUtil compareDateStart:seminarDate compareDateEnd:todayDate] > 0) {
            [seminar setIsPastEvent:NO];
            [self.futureEventArray addObject:seminar];
        } else {
            [seminar setIsPastEvent:YES];
        }
    }

    
   
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    self.todayDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:NSCalendarMatchStrictly];
    self.todayDateStr = [DateUtil stringFromDate:self.todayDate];
    
    self.startDateStr = self.todayDateStr;
    
    NSDate *weekDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:8 toDate:[NSDate date] options:NSCalendarMatchStrictly];
    self.endDateStr = [DateUtil stringFromDate:weekDate];
    
    
    CGFloat arrowSize = [AppDelegate sharedAppDelegate].titleFont.pointSize;
    UIImageView *imgViewArrow;
    
    imgViewArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.startDateBtn.frame.size.width-arrowSize, self.startDateBtn.frame.size.height/2-arrowSize/2, arrowSize, arrowSize)];
    imgViewArrow.image = [UIImage imageNamed:@"ico_arrow"];

    [self.startDateBtn addSubview:imgViewArrow];
    UIImageView *imgViewArrow2;
    
    imgViewArrow2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.endDateBtn.frame.size.width-arrowSize, self.endDateBtn.frame.size.height/2-arrowSize/2, arrowSize, arrowSize)];
    imgViewArrow2.image = [UIImage imageNamed:@"ico_arrow"];

    [self.endDateBtn addSubview:imgViewArrow2];

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

-(void)viewWillAppear:(BOOL)animated
{
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 2;
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
    
//    self.navigationItem.title = AMLocalizedString(@"RegisterNowTitle", nil);
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"RegisterNowTitle"];
    [self.navigationController setNavigationBarHidden:NO];
    
    
    self.descLbl.text = AMLocalizedString(@"Please choose the start and end date of your available period:",nil);
    self.startDateLbl.text = AMLocalizedString(@"Start Date:", nil);
    self.endDateLbl.text = AMLocalizedString(@"End Date:", nil);
    
   
    
    self.descLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.descLbl.numberOfLines = 0;
//    CGRect tf = self.descLbl.frame;
//    tf.size.height = [AppDelegate sharedAppDelegate].titleFont.pointSize*2;
//    self.descLbl.frame = tf;
    self.startDateLbl.font = [UIFont boldSystemFontOfSize:[AppDelegate sharedAppDelegate].titleFont.pointSize];
    self.endDateLbl.font = [UIFont boldSystemFontOfSize:[AppDelegate sharedAppDelegate].titleFont.pointSize];
    self.startDateBtn.titleLabel.font = [AppDelegate sharedAppDelegate].textFont;
    [self.startDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.endDateBtn.titleLabel.font = [AppDelegate sharedAppDelegate].textFont;
    [self.endDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    
    [self.nextBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setTitle:AMLocalizedString(@"NextBtnText", nil) forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    self.nextBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.nextBtn.clipsToBounds = YES;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    self.todayDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:NSCalendarMatchStrictly];
    self.todayDateStr = [DateUtil stringFromDate:self.todayDate]; //[DateUtil formattedDate:[seminar getLdate] language:LocalizationGetLanguage isLongDate:YES];

    [self.startDateBtn setTitle:[DateUtil formattedDate:self.startDateStr language:LocalizationGetLanguage isLongDate:YES] forState:UIControlStateNormal];
    [self.endDateBtn setTitle:[DateUtil formattedDate:self.endDateStr language:LocalizationGetLanguage isLongDate:YES] forState:UIControlStateNormal];
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

-(IBAction)btnStartPressed:(id)sender
{
    
    if(isiPad){
        [PickerView showDatePickerWithTitleIPad:@"" dateMode:UIDatePickerModeDate minDateStr:self.todayDateStr maxDateStr:@"" defaultDateStr:self.startDateStr  button:(UIButton *)sender selectionBlock:^(NSDate *selectedDate) {
            NSLog(@"Select date : %@",selectedDate);
            self.startDateStr = [DateUtil stringFromDate:selectedDate];
            //            [self.startDateBtn setTitle:self.startDateStr forState:UIControlStateNormal];
            [self.startDateBtn setTitle:[DateUtil formattedDate:self.startDateStr language:LocalizationGetLanguage isLongDate:YES] forState:UIControlStateNormal];
            self.startDate = selectedDate;
        }];
    }

    else
        [PickerView showDatePickerWithTitle:@"" dateMode:UIDatePickerModeDate minDateStr:self.todayDateStr maxDateStr:@"" defaultDateStr:self.startDateStr selectionBlock:^(NSDate *selectedDate) {
            NSLog(@"Select date : %@",selectedDate);
            self.startDateStr = [DateUtil stringFromDate:selectedDate];
//            [self.startDateBtn setTitle:self.startDateStr forState:UIControlStateNormal];
        [self.startDateBtn setTitle:[DateUtil formattedDate:self.startDateStr language:LocalizationGetLanguage isLongDate:YES] forState:UIControlStateNormal];
        self.startDate = selectedDate;
    }];
}

-(IBAction)btnEndPressed:(id)sender
{
//    MDCalendarViewController *viewController = [[MDCalendarViewController alloc] init];
//    viewController.isStartDateSetting = NO;
//    viewController.seminar = self.seminar;
//    viewController.delegate=self;
//    [self.navigationController pushViewController:viewController animated:NO];
    
    if(isiPad)
    {
        [PickerView showDatePickerWithTitleIPad:@"" dateMode:UIDatePickerModeDate minDateStr:self.startDateStr maxDateStr:@"" defaultDateStr:self.endDateStr button:(UIButton *)sender selectionBlock:^(NSDate *selectedDate) {
            NSLog(@"Select date : %@",selectedDate);
            self.endDateStr = [DateUtil stringFromDate:selectedDate];
            [self.endDateBtn setTitle:[DateUtil formattedDate:self.endDateStr language:LocalizationGetLanguage isLongDate:YES] forState:UIControlStateNormal];
            self.endDate = selectedDate;
        }];
        
    }
    else
        [PickerView showDatePickerWithTitle:@"" dateMode:UIDatePickerModeDate minDateStr:self.startDateStr maxDateStr:@"" defaultDateStr:self.endDateStr selectionBlock:^(NSDate *selectedDate) {
            NSLog(@"Select date : %@",selectedDate);
            self.endDateStr = [DateUtil stringFromDate:selectedDate];
        [self.endDateBtn setTitle:[DateUtil formattedDate:self.endDateStr language:LocalizationGetLanguage isLongDate:YES] forState:UIControlStateNormal];
        self.endDate = selectedDate;
    }];
}

-(IBAction)btnNextPressed:(id)sender
{
    if([self validation])
    {
        [self searchSeminar];
        [self.seminar setIsBookingByDate:YES];
        [self.seminar setStartDateStr:self.startDateBtn.titleLabel.text];
        [self.seminar setEndDateStr:self.endDateBtn.titleLabel.text];
        //[self.seminar set]
        UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
        RegisterInfoViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterInfoViewController"];
        ivc.seminar = self.seminar;
        ivc.canBack = YES;
        [self.navigationController pushViewController:ivc animated:YES];
    }
    else
    {
        NSString *errMsg = [NSString stringWithFormat:@""];
        
        if(self.isStartDateEmpty == YES)
            errMsg = [errMsg stringByAppendingFormat:@"%@%@", AMLocalizedString(@"Please choose your available date (from). ", nil),@"\r\n"];
        if(self.isEndDateEmpty == YES)
            errMsg = [errMsg stringByAppendingFormat:@"%@%@", AMLocalizedString(@"Please choose your available date (to).", nil),@"\r\n"];
        if(self.isStartDateLaterThanEndDate == YES)
            errMsg = [errMsg stringByAppendingFormat:@"%@%@", AMLocalizedString(@"Users are not allowed to select dates earlier than the From date.", nil),@"\r\n"];
        
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:errMsg
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* closeButton = [UIAlertAction
                                      actionWithTitle:AMLocalizedString(@"CLOSE", nil)
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {
                                          //Handle your yes please button action here
                                        
                                      }];
        
        
        
        [alert addAction:closeButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}


-(BOOL)validation
{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    if (self.startDate == nil)

        self.startDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:NSCalendarMatchStrictly];
    if (self.endDate == nil) {
        self.endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:8 toDate:[NSDate date] options:NSCalendarMatchStrictly];
    }
    
    NSString *startStr = [DateUtil stringFromDate:self.startDate];
    NSString *endStr = [DateUtil stringFromDate:self.endDate];
    
    if([self.startDateBtn.titleLabel.text isEqualToString:@""])
        self.isStartDateEmpty = YES;
    else
        self.isStartDateEmpty = NO;
    
    if([self.endDateBtn.titleLabel.text isEqualToString:@""])
        self.isEndDateEmpty = YES;
    else
        self.isEndDateEmpty = NO;
    
    if([DateUtil compareDateStart:[DateUtil dateFromString:startStr] compareDateEnd:[DateUtil dateFromString:endStr]] == 1)
        self.isStartDateLaterThanEndDate = YES;
    else
        self.isStartDateLaterThanEndDate = NO;
        
    if(self.isStartDateEmpty || self.isEndDateEmpty || self.isStartDateLaterThanEndDate)
        return NO;
    else
        return YES;
}

-(Seminar *)searchSeminar
{
    NSDate *startDate = [DateUtil dateFromString:self.startDateBtn.titleLabel.text];
    NSDate *endDate = [DateUtil dateFromString:self.endDateBtn.titleLabel.text];
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Seminar *seminar, NSDictionary *bind){
        // this is the important part, lets get things in NSDate form so we can use them.
        // of course it would be quicker to alter the data type, but we can covert on the fly
        NSDate *seminarDate = [DateUtil dateFromString:[seminar getLdate]];
        
        return ([DateUtil compareDateStart:seminarDate compareDateEnd:startDate] >= 0) && ([DateUtil compareDateStart:endDate compareDateEnd:seminarDate] >= 0);
    }];
    
    // assumes allPeople is an NSArray of Person objects to be filtered
    // and assumes Person has an NSString date_of_birth property
    NSArray *semArray = [self.futureEventArray filteredArrayUsingPredicate:predicate];
    if([semArray count] > 0)
        return [semArray objectAtIndex:0];
    return nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end

