//
//  VesJasVC.h
//  MyEventApp
//
//  Created by Adam on 3/2/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@protocol VesJasDelegate <NSObject>

@optional
- (void) showJasF;
- (void) showJasM;
@end

@interface VesJasVC : UIViewController
@property (nonatomic, retain)id<VesJasDelegate> delegate;
@end
