//
//  UIColor+PXExtensions.h
//  Creates UIColor from hex string. "#" prefix is optional. Supports 3 and 6 hex digits.
//  Originally from http://pixelchild.com.au/post/12785987198/how-to-convert-a-html-hex-string-into-uicolor-with
//  But that link seems to be broken.
//  Revived by Thongchai Kolyutsakul (21 May 2015).
//
//  USAGE:  UIColor *mycolor = [UIColor pxColorWithHexValue:@"#BADA55"];
//          UIColor *mycolor = [UIColor pxColorWithHexValue:@"FFFFFF"];
//          UIColor *mycolor = [UIColor pxColorWithHexValue:@"1AD"];
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColor_PXExtensions)

+ (UIColor*)pxColorWithHexValue:(NSString*)hexValue;

@end
