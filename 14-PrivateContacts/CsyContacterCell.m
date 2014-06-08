//
//  CsyContacterCell.m
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import "CsyContacterCell.h"
#import "CsyContacter.h"

@interface CsyContacterCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UIView *seprateLine;

@end

@implementation CsyContacterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CsyContacterCell *)contactrCellWithTableView:(UITableView *)tableView
{
    CsyContacterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contacter"];
    if (cell == nil) {
        NSLog(@"cell alloc");
    }
    
    return cell;
}

- (void)setContacter:(CsyContacter *)contacter
{
//    _contacter = nil;  
    _contacter = contacter;
    self.nameLabel.text = _contacter.name;
    self.phoneNumLabel.text = _contacter.phoneNum;
}

- (void)awakeFromNib
{
//    NSLog(@"awakeFromNib-contacterCell");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//cell的高度发生变化,子控件也进行调整
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tmp = self.nameLabel.frame;
    self.nameLabel.frame = CGRectMake(tmp.origin.x, tmp.origin.y, tmp.size.width, self.contentView.bounds.size.height);
    
    tmp = self.phoneNumLabel.frame;
    self.phoneNumLabel.frame = CGRectMake(tmp.origin.x, tmp.origin.y, tmp.size.width, self.contentView.bounds.size.height);
    
    tmp = self.seprateLine.frame;
    self.seprateLine.frame = CGRectMake(tmp.origin.x, self.contentView.bounds.size.height - 1, tmp.size.width, 1);
}

@end
