//
//  CsyContacterCell.h
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CsyContacter;

@interface CsyContacterCell : UITableViewCell

+ (CsyContacterCell *)contactrCellWithTableView:(UITableView *)tableView;

@property (strong,nonatomic) CsyContacter *contacter;

@end
