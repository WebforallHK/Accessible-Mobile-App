//
//  SeminarTableViewCell.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "SeminarTableViewCell.h"

@implementation SeminarTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if(self.newsImageView.isHidden == YES)
    {
        self.accessibilityElements = @[self.seminarDateLabel, self.pastEventLabel, self.seminarTitleLabel];
        self.newsImageView.isAccessibilityElement = NO;
        self.newsImageView.accessibilityLabel = @"";
    }
    else
    {
        self.accessibilityElements = @[self.seminarDateLabel, self.newsImageView ,self.pastEventLabel, self.seminarTitleLabel];
        self.newsImageView.isAccessibilityElement = YES;
        self.newsImageView.accessibilityLabel = AMLocalizedString(@"News", nil);
        self.newsImageView.accessibilityHint = AMLocalizedString(@"News", nil);
    }
    
    // Configure the view for the selected state
}

- (void)clearAllData {
    self.seminarDateLabel.text = nil;
    self.pastEventLabel.text = nil;
    self.seminarTitleLabel.text = nil;
}


@end
