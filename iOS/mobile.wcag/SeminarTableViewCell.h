//
//  SeminarTableViewCell.h
//  mobile.wcag
//
//

#ifndef SeminarTableViewCell_h
#define SeminarTableViewCell_h

#import <UIKit/UIKit.h>

@interface SeminarTableViewCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *seminarDateLabel;
@property (nonatomic,strong) IBOutlet UILabel *pastEventLabel;
@property (nonatomic,strong) IBOutlet UIImageView *newsImageView;
@property (nonatomic,strong) IBOutlet UILabel *seminarTitleLabel;
- (void)clearAllData;
@end
#endif /* SeminarTableViewCell_h */
