//
//  DateUtil.h
//  mobile.wcag
//
//

#ifndef DateUtil_h
#define DateUtil_h

@interface DateUtil : NSObject

+(NSString *)stringFromDate:(NSDate *)date;
+(NSDate *)dateFromString:(NSString *)string;
+(int)compareDateStart:(NSDate *)dateStart compareDateEnd:(NSDate *)dateEnd;
+(NSString *)formattedDate:(NSString *)string language:(NSString *)lang isLongDate:(BOOL)isLong;

@end

#endif /* DateUtil_h */
