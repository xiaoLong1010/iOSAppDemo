//
//  CsyUpdateController.h
//  iOSAppDemo
//
//  Created by csy on 6/8/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CsyContacter;

@protocol CsyUpdateControllerDelegate <NSObject>

- (void)updateControllerRefreshTableViewWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface CsyUpdateController : UIViewController

@property (strong,nonatomic) id<CsyUpdateControllerDelegate> delegate;

@property (strong,nonatomic) CsyContacter *contacter;
@property (strong,nonatomic) NSIndexPath *indexPath;

@end
