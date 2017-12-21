//
//  Person.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Person()

@end

@implementation Person
@synthesize firstName, lastName, address, district, districtOption, phone;
-(id)init
{
    if(self = [super init] ) {
        firstName = @"";
        lastName = @"";
        address = @"";;
        district = @"";
        districtOption = -1;
        phone = @"";
        return self;
    } else
        return nil;
}

-(void)setFirstName:(NSString *)str
{
    firstName = str;
}

-(void)setLastName:(NSString *)str
{
    lastName = str;
}

-(void)setAddress:(NSString *)str
{
    address = str;
}

-(void)setDistrict:(NSString *)str
{
    district = str;
}

-(void)setDistrictOption:(int)val
{
    districtOption = val;
}

-(void)setPhone:(NSString *)str
{
    phone = str;
}


-(NSString *)getFirstName
{
    return firstName;
}

-(NSString *)getLastName
{
    return lastName;
}

-(NSString *)getAddress
{
    return address;
}

-(NSString *)getDistrict
{
    return district;
}

-(NSString *)getPhone
{
    return phone;
}

-(int)getDistrictOption
{
    return districtOption;
}
@end
