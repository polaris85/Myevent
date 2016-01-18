//
//  VesVC.h
//  MyEventApp
//
//  Created by Adam on 2/27/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VesDelegate <NSObject>

@optional
- (void) showVesCat;
- (void) showVesJas;
@end

@interface VesVC : UIViewController
@property (nonatomic, retain)id<VesDelegate> delegate;
@end
