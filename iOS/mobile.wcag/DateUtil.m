//
//  DateUtil.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "DateUtil.h"

@implementation DateUtil


//NSDate To NSString
+(NSString *)stringFromDate:(NSDate *)date
{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
   
    
    return dateString;
}

//NSString To NSDate
+(NSDate *)dateFromString:(NSString *)string
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *date=[formatter dateFromString:string];
    return date;
}

+(int)compareDateStart:(NSDate *)dateStart compareDateEnd:(NSDate *)dateEnd
{
    if ([dateStart compare:dateEnd] == NSOrderedDescending) {
        //NSLog(@"date1 is later than date2");
        return 1;
    } else if ([dateStart compare:dateEnd] == NSOrderedAscending) {
        //NSLog(@"date1 is earlier than date2");
        return -1;
    } else {
        //NSLog(@"dates are the same");
        return 0;
    }
}

+(NSString *)formattedDate:(NSString *)string language:(NSString *)lang isLongDate:(BOOL)isLong
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    //[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //[dateFormatter setLocale:[NSLocale currentLocale]];
    //[dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    NSDate *date = [dateFormatter dateFromString:string];
    NSString *stringFromDate;
    if([lang hasPrefix:@"en"] && isLong == YES )
    {
        [dateFormatter setDateFormat:@"dd MMM yyyy"];
        NSLocale *locale = [[NSLocale alloc]
                            initWithLocaleIdentifier:@"en"];
        [dateFormatter setLocale:locale];
    }
    else if([lang hasPrefix:@"en"] && isLong == NO )
    {
        [dateFormatter setDateFormat:@"MMM yyyy"];
        NSLocale *locale = [[NSLocale alloc]
                            initWithLocaleIdentifier:@"en"];
        [dateFormatter setLocale:locale];
        
    }
    else if([lang hasPrefix:@"zh-Hant"] && isLong == YES)
    {
        [dateFormatter setDateFormat:@"yyyy 年 M 月 dd 日"];
        NSLocale *locale = [[NSLocale alloc]
                            initWithLocaleIdentifier:@"zh-Hant"];
        [dateFormatter setLocale:locale];
    }
    else if([lang hasPrefix:@"zh-Hant"] && isLong == NO)
    {
        [dateFormatter setDateFormat:@"yyyy 年 M 月"];
        NSLocale *locale = [[NSLocale alloc]
                            initWithLocaleIdentifier:@"zh-Hant"];
        [dateFormatter setLocale:locale];
    }
    else if([lang hasPrefix:@"zh-Hans"] && isLong == YES)
    {
       [dateFormatter setDateFormat:@"yyyy 年 M 月 dd 日"];
        NSLocale *locale = [[NSLocale alloc]
                            initWithLocaleIdentifier:@"zh-Hans"];
        [dateFormatter setLocale:locale];
    }
    else if([lang hasPrefix:@"zh-Hans"] && isLong == NO)
    {
        [dateFormatter setDateFormat:@"yyyy 年 M 月"];
        NSLocale *locale = [[NSLocale alloc]
                            initWithLocaleIdentifier:@"zh-Hans"];
        [dateFormatter setLocale:locale];
    }
    stringFromDate = [dateFormatter stringFromDate:date];
    return stringFromDate;
}
@end
