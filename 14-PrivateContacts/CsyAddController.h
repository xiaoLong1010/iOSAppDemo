//
//  CsyAddControllerV.h
//  iOSAppDemo
//
//  Created by csy on 6/8/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CsyContacter;

@protocol CsyAddControllerDelegete <NSObject>

@required
- (void)addControllerWithContacter:(CsyContacter *)contacter;

@end

@interface CsyAddController : UIViewController

@property (strong,nonatomic) id<CsyAddControllerDelegete> delegate;

@end
