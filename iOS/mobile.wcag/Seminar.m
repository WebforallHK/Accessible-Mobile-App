//
//  Seminar.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "Seminar.h"

@interface Seminar()

@end

@implementation Seminar
@synthesize dateShort, dateLong, title, time, venue, detail, mapLong, mapLat, isPastEvent, isBookingByDate, startDateStr, endDateStr;

-(id)init
{
    if(self = [super init] ) {
        dateShort = @"Mar 2018";
        dateLong = @"13/3/2018";
        title = @"Seminar1";
        time = @"15:00 - 18:00";
        venue = @"GovOffice";
        detail = @"";
        mapLong = 22.280768;
        mapLat = 114.165425;
        isBookingByDate = NO;
        startDateStr = @"";
        endDateStr = @"";
        return self;
    } else
        return nil;
}

//-(id)initWithShortDate:(NSString *)sDate initWithLongDate:(NSString *)lDate initWithTitle:(NSString *)strTitle initWithTime:(NSSting *)strTime initWithVenue:(NSSting *)strVenue initWithDetail:(NSString *)strDetail initWithMapLong:(double)longitude initWithMapLat:(double)latitude
//{
//    if(self = [super init] ) {
//        dateShort = sDate;
//        dateLong = lDate;
//        title = strTitle;
//        time = strTime;
//        venue = strVenue;
//        detail = strDetail;
//        mapLong = longitude;
//        mapLat = latitude;
//        return self;
//    }
//    else
//        return nil;
//
//    
//}

-(void)setLongDate:(NSString *)val
{
    dateLong = val;
}

-(void)setShortDate:(NSString *)val
{
    dateLong = val;
}

-(void)setTitle:(NSString *)val
{
    title = val;
}

-(void)setVenue:(NSString *)val
{
    venue = val;
}

-(void)setDetail:(NSString *)val
{
    detail = val;
}

-(void)setMapLong:(double)val
{
    mapLong = val;
}

-(void)setMapLat:(double)val
{
    mapLat = val;
}

-(void)setIsPastEvent:(BOOL)val
{
    isPastEvent = val;
}

-(void)setIsBookingByDate:(BOOL)val
{
    isBookingByDate = val;
}

-(void)setStartDateStr:(NSString *)val
{
    startDateStr = val;
}

-(void)setEndDateStr:(NSString *)val
{
    endDateStr = val;
}

-(NSString *)getSdate
{
    return dateShort;
}

-(NSString *)getLdate
{
    return dateLong;
}

-(NSString *)getTitle
{
    return title;
}

-(NSString *)getTime
{
    return time;
}

-(NSString *)getVenue
{
    return venue;
}

-(NSString *)getDetail
{
    return detail;
}

-(double)getMapLong
{
    return mapLong;
}

-(double)getMapLat
{
    return mapLat;
}

-(BOOL)getIsPastEvent
{
    return isPastEvent;
}

-(BOOL)getIsBookingByDate
{
    return isBookingByDate;
}

-(NSString *)getStartDateStr
{
    return startDateStr;
}

-(NSString *)getEndDateStr
{
    return endDateStr;
}

@end
