//
//  RegisterInfoViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "RegisterInfoViewController.h"
#import "ConfirmationViewController.h"
#import "Person.h"
#import "PickerView.h"

@interface RegisterInfoViewController() {
    CusTabBarController *tab;
}
@end

@implementation RegisterInfoViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.addressTextField.delegate = self;
    self.phoneTextField.delegate = self;
    
    self.isFirstNameEmpty = YES;
    self.isLastNameEmpty = YES;
    self.isDistrictEmpty = YES;
    self.isPhoneEmpty = YES;
    
    self.districtOption = -1;
    self.districtArray = [NSArray arrayWithObjects:AMLocalizedString(@"Central and Western", nil), AMLocalizedString(@"Eastern", nil), AMLocalizedString(@"Southern", nil), AMLocalizedString(@"Wan Chai", nil), AMLocalizedString(@"Sham Shui Po", nil), AMLocalizedString(@"Kowloon City", nil), AMLocalizedString(@"Kwun Tong", nil),AMLocalizedString(@"Wong Tai Sin", nil),AMLocalizedString(@"Yau Tsim Mong", nil), AMLocalizedString(@"Islands", nil),AMLocalizedString(@"Kwai Tsing", nil),AMLocalizedString(@"North", nil), AMLocalizedString(@"Sai Kung", nil), AMLocalizedString(@"Sha Tin", nil), AMLocalizedString(@"Tai Po", nil), AMLocalizedString(@"Tsuen Wan", nil), AMLocalizedString(@"Tuen Mun", nil), AMLocalizedString(@"Yuen Long", nil), nil];
    
    if (isiPad)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.view.frame.size.height+120);
    else
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.view.frame.size.height+130);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
}
    
- (void)keyboardWillBeHidden:(NSNotification *)notification
{
}
    
-(void) loadNavigation
{
    if ([self.firstNameTextField.text isEqualToString:@""]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackPressed:)];
        [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
        self.navigationItem.leftBarButtonItem.isAccessibilityElement = YES;
        self.navigationItem.leftBarButtonItem.accessibilityLabel = AMLocalizedString(@"BackBtnText", nil);
        self.navigationItem.leftBarButtonItem.accessibilityHint = AMLocalizedString(@"BackBtnText", nil);
        self.navigationItem.leftBarButtonItem.tag = 0;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        [self.navigationItem setHidesBackButton:YES];
    }
    
    
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
}

//9E005D
- (void) viewWillAppear:(BOOL)animated
{
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 2;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self loadNavigation];
    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"RegisterSeminarTitle"];
    [self.navigationController setNavigationBarHidden:NO];
    
    self.descLbl.text = AMLocalizedString(@"Mandatory fields are indicated with an asterisk (*).", nil);
    self.descLbl.textColor = [UIColor pxColorWithHexValue:@"000000"];
    self.descLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.firstNameLbl.text = AMLocalizedString(@"* First Name", nil);
    self.firstNameLbl.textColor = [UIColor pxColorWithHexValue:@"000000"];
    self.firstNameLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.lastNameLbl.text = AMLocalizedString(@"* Last Name", nil);
    self.lastNameLbl.textColor = [UIColor pxColorWithHexValue:@"000000"];
    self.lastNameLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.addressLbl.text = AMLocalizedString(@"Address", nil);
    self.addressLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.addressLbl.textColor = [UIColor pxColorWithHexValue:@"000000"];
    self.districtLbl.text = AMLocalizedString(@"* District", nil);
    self.districtLbl.textColor = [UIColor pxColorWithHexValue:@"000000"];
    self.districtLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.phoneLbl.numberOfLines = 0;
    self.phoneLbl.lineBreakMode = NSLineBreakByWordWrapping;
    self.phoneLbl.text = AMLocalizedString(@"* Phone", nil);
    self.phoneLbl.textColor = [UIColor pxColorWithHexValue:@"000000"];
    self.phoneLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.timerLbl.text = AMLocalizedString(@"Remain Time: %d secs", nil);
    self.timerLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.timerLbl.textColor = [UIColor pxColorWithHexValue:@"000000"];
    
    self.firstNameTextField.placeholder = @"";
    self.lastNameTextField.placeholder = @"";
    self.addressTextField.placeholder = @"";
    self.phoneTextField.placeholder = @"";
    self.firstNameTextField.isAccessibilityElement = YES;
    self.firstNameTextField.accessibilityLabel = AMLocalizedString(@"firstNameInput", nil);
    self.lastNameTextField.isAccessibilityElement = YES;
    self.lastNameTextField.accessibilityLabel = AMLocalizedString(@"lastNameInput", nil);
    self.addressTextField.isAccessibilityElement = YES;
    self.addressTextField.accessibilityLabel = AMLocalizedString(@"addressInput", nil);

    self.phoneTextField.isAccessibilityElement = YES;
    self.phoneTextField.accessibilityLabel = AMLocalizedString(@"phoneInput", nil);
    
    self.firstNameTextField.tag = 100;
    self.lastNameTextField.tag = 101;
    self.addressTextField.tag = 102;
    self.phoneTextField.tag = 103;
    
    [self.firstNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.lastNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.addressTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.firstNameTextField setKeyboardType:UIKeyboardTypeDefault];
    [self.lastNameTextField setKeyboardType:UIKeyboardTypeDefault];
    [self.addressTextField setKeyboardType:UIKeyboardTypeDefault];
    [self.phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    if(self.districtOption == -1)
        [self.districtBtn setTitle:AMLocalizedString(@"Choose a District", nil) forState:UIControlStateNormal];
    else
        [self.districtBtn setTitle:AMLocalizedString(self.district, nil) forState:UIControlStateNormal];
    
    [self.districtBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.districtBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.districtBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    
    [self.registerBtn setTitle:AMLocalizedString(@"RegisterBtnText", nil) forState:UIControlStateNormal];
    [self.registerBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.registerBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    
    self.registerBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.registerBtn.clipsToBounds = YES;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(countDown)
                                                userInfo:nil
                                                 repeats:YES];
    self.counter = MAX_COUNT;
    self.timerLbl.text = [NSString stringWithFormat:AMLocalizedString(@"Remain Time: %d mins %d secs", nil),self.counter/60,self.counter%60];
    
    if (isiPad) {
        [[AppDelegate sharedAppDelegate] iPadTxtFrame:self.lastNameTextField];
        [[AppDelegate sharedAppDelegate] iPadTxtFrame:self.firstNameTextField];
        [[AppDelegate sharedAppDelegate] iPadTxtFrame:self.addressTextField];
        [[AppDelegate sharedAppDelegate] iPadTxtFrame:self.phoneTextField];
        CGRect tempFrame = self.districtBtn.frame;
        tempFrame.size.height = 60;
        self.districtBtn.frame = tempFrame;
    }
    
    CGSize expectedLabelSize = [[[NSAttributedString alloc] initWithString:self.phoneLbl.text attributes:@{NSFontAttributeName: self.phoneLbl.font}] boundingRectWithSize:CGSizeMake(self.phoneLbl.frame.size.width, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGRect newFrame = self.phoneLbl.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.phoneLbl.frame = newFrame;
    CGRect tempFrame = self.phoneTextField.frame;
    tempFrame.origin.y = newFrame.origin.y + newFrame.size.height + 20;
    self.phoneTextField.frame = tempFrame;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
    self.counter = 0;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    NSLog(@"textField tag=%ld", (long)textField.tag);
    
    if(textField.tag >= 100 && textField.tag <= 103)
        return YES;
    return NO;
}

-(void)textFieldDidChange :(UITextField *) textField{
    //your code
    if(textField.tag == 100)
    {
        self.firstName = textField.text;
    }
    else if(textField.tag == 101)
    {
        self.lastName = textField.text;
    }
    else if(textField.tag == 102)
    {
        self.address = textField.text;
    }

    else if(textField.tag == 103)
    {
        self.phone = textField.text;
    }
    NSLog(@"textFieldDidChange");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 103) {
        NSString *validRegEx =@"^[0-9]*$"; //change this regular expression as your requirement
        NSPredicate *regExPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEx];
        BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:string];
        if (myStringMatchesRegEx)
        {
            if(range.length + range.location > textField.text.length)
            {
                return NO;
            }
            
            NSUInteger newLength = [textField.text length] + [string length] - range.length;
            return newLength <= 8;
        }
        else
            return NO;
    } else if (textField.tag == 100) {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 40;
    } else if (textField.tag == 101) {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 40;
    } else if (textField.tag == 102) {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 100;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([[[[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settingDict"] mutableCopy] objectForKey:@"bgm"] isEqualToString:@"YES"])
        [[AppDelegate sharedAppDelegate] startMusic];
    NSLog(@"textFieldDidEndEditing");

}

-(BOOL)textViewShouldReturn:(UITextField *)textField
{
    return YES;
}

-(void)validation
{

    if(self.firstName == nil || ([self.firstName isEqualToString:@""]))
        self.isFirstNameEmpty = YES;
    else
    {
        self.firstName = self.firstNameTextField.text;
        self.isFirstNameEmpty = NO;
    }
    
    if(self.lastName == nil || ([self.lastName isEqualToString:@""]))
        self.isLastNameEmpty = YES;
    else
    {
        self.lastName = self.lastNameTextField.text;
        self.isLastNameEmpty = NO;
    
    }
    if(self.district == nil || ([self.district isEqualToString:@""]))
        self.isDistrictEmpty = YES;
    else
    {
        self.isDistrictEmpty = NO;
    }
    
    self.isNumericPhone = NO;
    self.is8DigitPhone = NO;
    
    if(self.phone == nil || ([self.phone isEqualToString:@""]))
        self.isPhoneEmpty = YES;
    else
    {
        self.isPhoneEmpty = NO;
        
        self.phone = self.phoneTextField.text;
        NSCharacterSet *areDigits = [NSCharacterSet decimalDigitCharacterSet];
        if ([self.phone rangeOfCharacterFromSet:areDigits].location != NSNotFound)
        {
            // newString consists only of the digits 0 through 9
            self.isNumericPhone = YES;
            if([self.phone length] == 8)
                self.is8DigitPhone = YES;
        }
        else
            self.isNumericPhone = NO;
    }
    
}

-(BOOL)checkValidationRules
{
    if(self.isFirstNameEmpty || self.isLastNameEmpty || self.isDistrictEmpty || self.isPhoneEmpty || self.isNumericPhone == NO|| self.is8DigitPhone == NO)
        return NO;
    else
        return YES;
    
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


-(IBAction)btnRegisterPressed:(id)sender
{
    [self.lastNameTextField resignFirstResponder];
    [self.firstNameTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self submitForm];
}

-(void)reset {
    self.firstNameTextField.text = @"";
    self.lastNameTextField.text = @"";
    self.addressTextField.text = @"";
    self.phoneTextField.text = @"";
    self.firstNameTextField.text = @"";
    self.firstName = @"";
    self.lastName = @"";
    self.address = @"";
    self.district = @"";
    [self.districtBtn setTitle:AMLocalizedString(@"Choose a District", nil) forState:UIControlStateNormal];
}

-(void)submitForm
{
    [self.timer invalidate];
    self.counter = 0;
    [PickerView dismissPicker];
    [self validation];
    if([self checkValidationRules])
    {
        Person *person = [[Person alloc] init];
        [person setFirstName:self.firstName];
        [person setLastName:self.lastName];
        [person setAddress:self.address];
        [person setDistrict:self.district];
        [person setPhone:self.phone];
        [person setDistrictOption:self.districtOption];
        
        UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
        ConfirmationViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"ConfirmationViewController"];
        ivc.person = person;
        ivc.seminar = self.seminar;
        [self.navigationController pushViewController:ivc animated:YES];
    }
    else
    {
        NSString *errMsg = [NSString stringWithFormat:@""];
        
        if(self.isFirstNameEmpty == YES)
            errMsg = [errMsg stringByAppendingFormat:@"%@%@", AMLocalizedString(@"Please input your first name.", nil),@"\r\n"];
        if(self.isLastNameEmpty == YES)
            errMsg = [errMsg stringByAppendingFormat:@"%@%@", AMLocalizedString(@"Please input your last name.", nil),@"\r\n"];
        if(self.isDistrictEmpty == YES)
            errMsg = [errMsg stringByAppendingFormat:@"%@%@", AMLocalizedString(@"Please choose the district you live.", nil),@"\r\n"];

        if(self.is8DigitPhone == NO || self.isNumericPhone == NO || self.isPhoneEmpty == YES)
            errMsg = [errMsg stringByAppendingFormat:@"%@%@", AMLocalizedString(@"Please input 8 digits phone number.", nil),@"\r\n"];
        
        self.alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:errMsg
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* closeButton = [UIAlertAction
                                      actionWithTitle:AMLocalizedString(@"CLOSE", nil)
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {
                                          //Handle your yes please button action here
                                          self.counter = MAX_COUNT;

                                          self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                                        target:self
                                                                                      selector:@selector(countDown)
                                                                                      userInfo:nil
                                                                                       repeats:YES];
                                          [self hightlightLbl];
                                      }];
        
        
        
        [self.alert addAction:closeButton];
        [self presentViewController:self.alert animated:YES completion:nil];
    }
}

-(void)hightlightLbl
{
    if(self.isFirstNameEmpty == YES)
        self.firstNameLbl.textColor = [UIColor pxColorWithHexValue:@"9E005D"];
    else
        self.firstNameLbl.textColor = [UIColor blackColor];
    
    if(self.isLastNameEmpty == YES)
        self.lastNameLbl.textColor = [UIColor pxColorWithHexValue:@"9E005D"];
    else
        self.lastNameLbl.textColor = [UIColor blackColor];
    
    if(self.isDistrictEmpty == YES)
        self.districtLbl.textColor = [UIColor pxColorWithHexValue:@"9E005D"];
    else
        self.districtLbl.textColor = [UIColor blackColor];
        
    if(self.isPhoneEmpty == YES || self.isNumericPhone == NO || self.is8DigitPhone == NO)
        self.phoneLbl.textColor = [UIColor pxColorWithHexValue:@"9E005D"];
    else
        self.phoneLbl.textColor = [UIColor blackColor];
    self.descLbl.text = AMLocalizedString(@"Mandatory fields are indicated with a red asterisk (*).", nil);
    self.descLbl.textColor = [UIColor pxColorWithHexValue:@"9E005D"];
    
    if(self.isFirstNameEmpty == YES)
        [self.firstNameTextField becomeFirstResponder];
    else if(self.isLastNameEmpty == YES)
        [self.lastNameTextField becomeFirstResponder];
    else if(self.isDistrictEmpty)
    {
        
    }
    else if(self.isPhoneEmpty == YES || self.isNumericPhone == NO || self.is8DigitPhone == NO)
        [self.phoneTextField becomeFirstResponder];
        
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");

    return YES;
}





-(void)textFieldDidBeginEditing:(UITextField *)textField { //Keyboard becomes visible
//
//    //perform actions.
    NSLog(@"textFieldDidBeginEditing");

}

-(void)countDown {
    --self.counter;
    self.timerLbl.text = [NSString stringWithFormat:AMLocalizedString(@"Remain Time: %d mins %d secs", nil),self.counter/60,self.counter%60];
    NSLog(@"every 1 sec, %d", self.counter);
    if (self.counter == 0) {
        [self.timer invalidate];
        [PickerView dismissPicker];
        self.alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:AMLocalizedString(@"Times up! Please submit your form.", nil)
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* extendButton = [UIAlertAction
                                    actionWithTitle:AMLocalizedString(@"EXTEND TIME LIMIT", nil)
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        self.counter = MAX_COUNT;
                                        self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                                      target:self
                                                                                    selector:@selector(countDown)
                                                                                    userInfo:nil
                                                                                     repeats:YES];

                                    }];
        
        UIAlertAction* closeButton = [UIAlertAction
                                   actionWithTitle:AMLocalizedString(@"RESET", nil)
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
//                                       [self submitForm];
                                       self.counter = MAX_COUNT;
                                       self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                                     target:self
                                                                                   selector:@selector(countDown)
                                                                                   userInfo:nil
                                                                                    repeats:YES];
                                       [self reset];
                                   }];
        
        [self.alert addAction:extendButton];
        [self.alert addAction:closeButton];
        
        [self presentViewController:self.alert animated:YES completion:nil];
        
    }
    
}

-(IBAction)btnDistrictPressed:(id)sender
{

    if(isiPad && self.districtOption == -1)
    {
        [self.lastNameTextField resignFirstResponder];
        [self.firstNameTextField resignFirstResponder];
        [self.addressTextField  resignFirstResponder];
        [self.phoneTextField resignFirstResponder];
        [PickerView showPickerWithOptionsIPad:self.districtArray defaultRow:0 title:AMLocalizedString(@"", nil) button:self.districtBtn selectionBlock:^(NSString *selectedOption) {
            NSLog(@"Select Option : %@",selectedOption);
            self.district = selectedOption;
            self.districtOption = (int)[self.districtArray indexOfObject:selectedOption];
            [self.districtBtn setTitle:selectedOption forState:UIControlStateNormal];
        }];
    }
    else if(isiPad && self.districtOption != -1)
    {
        [self.lastNameTextField resignFirstResponder];
        [self.firstNameTextField resignFirstResponder];
        [self.addressTextField  resignFirstResponder];
        [self.phoneTextField resignFirstResponder];
        [PickerView showPickerWithOptionsIPad:self.districtArray defaultRow:self.districtOption title:AMLocalizedString(@"", nil) button:self.districtBtn selectionBlock:^(NSString *selectedOption) {
            NSLog(@"Select Option : %@",selectedOption);
            self.district = selectedOption;
            self.districtOption = (int)[self.districtArray indexOfObject:selectedOption];
            [self.districtBtn setTitle:selectedOption forState:UIControlStateNormal];
        }];
    }
    else if((!isiPad) && (self.districtOption == -1))
        [PickerView showPickerWithOptions:self.districtArray defaultRow:0 title:AMLocalizedString(@"", nil) selectionBlock:^(NSString *selectedOption) {
            NSLog(@"Select Option : %@",selectedOption);
            self.district = selectedOption;
            self.districtOption = (int)[self.districtArray indexOfObject:selectedOption];
            [self.districtBtn setTitle:selectedOption forState:UIControlStateNormal];
        }];
    else
        [PickerView showPickerWithOptions:self.districtArray defaultRow:self.districtOption title:AMLocalizedString(@"", nil) selectionBlock:^(NSString *selectedOption) {
            NSLog(@"Select Option : %@",selectedOption);
            self.district = selectedOption;
            self.districtOption = (int)[self.districtArray indexOfObject:selectedOption];
            [self.districtBtn setTitle:selectedOption forState:UIControlStateNormal];
        }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendPersonDataToRegisterInfoiewController:(Person *)obj
{
    self.lastNameTextField.text = [obj getLastName];
    self.firstNameTextField.text = [obj getFirstName];
    self.addressTextField.text = [obj getAddress];
    self.district = [self.districtArray objectAtIndex:(int)[obj getDistrictOption]];
    [self.districtBtn setTitle:AMLocalizedString(self.district, nil) forState:UIControlStateNormal];
    self.phoneTextField.text = [obj getPhone];
}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end
