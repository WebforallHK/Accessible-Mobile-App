//
//  Person.h
//  mobile.wcag
//
//

#ifndef Person_h
#define Person_h

@import UIKit;
@class Person;

@interface Person : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *district;
@property (nonatomic) int districtOption;
@property (nonatomic, strong) NSString *phone;

-(void)setFirstName:(NSString *)str;
-(void)setLastName:(NSString *)str;
-(void)setAddress:(NSString *)str;
-(void)setDistrict:(NSString *)str;
-(void)setDistrictOption:(int)val;
-(void)setPhone:(NSString *)str;

-(NSString *)getFirstName;
-(NSString *)getLastName;
-(NSString *)getAddress;
-(NSString *)getDistrict;
-(NSString *)getPhone;
-(int)getDistrictOption;

@end
#endif /* Person_h */
