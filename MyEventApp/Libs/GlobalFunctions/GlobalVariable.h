//
//  GlobalVariable.h
//  TCM
//
//  Created by zao928 on 12/27/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad


@interface GlobalVariable : NSObject
@property (nonatomic, retain) NSArray *tableArrayValue;
@property int returnKey;

+ (GlobalVariable*) sharedInstance ;

@end