//
//  VesCat.h
//  MyEventApp
//
//  Created by Adam on 3/2/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@protocol VesCatDelegate <NSObject>

@optional
- (void) showB;
- (void) showK;
- (void) showF;
- (void) showM;
@end

@interface VesCat : UIViewController
@property (nonatomic, retain)id<VesCatDelegate> delegate;
@end
