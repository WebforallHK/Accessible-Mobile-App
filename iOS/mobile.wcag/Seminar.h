//
//  Seminar.h
//  mobile.wcag
//
//

#ifndef Seminar_h
#define Seminar_h

@import UIKit;
@class Seminar;

@interface Seminar : NSObject

@property (nonatomic, strong) NSString *dateShort;
@property (nonatomic, strong) NSString *dateLong;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *venue;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic) double mapLong;
@property (nonatomic) double mapLat;
@property (nonatomic) BOOL isPastEvent;
@property (nonatomic) BOOL isBookingByDate;
@property (nonatomic, strong) NSString *startDateStr;
@property (nonatomic, strong) NSString *endDateStr;

-(NSString *)getSdate;
-(NSString *)getLdate;
-(NSString *)getTitle;
-(NSString *)getTime;
-(NSString *)getVenue;
-(NSString *)getDetail;
-(double)getMapLong;
-(double)getMapLat;
-(BOOL)getIsPastEvent;
-(BOOL)getIsBookingByDate;
-(NSString *)getStartDateStr;
-(NSString *)getEndDateStr;

@end

#endif /* Seminar_h */
