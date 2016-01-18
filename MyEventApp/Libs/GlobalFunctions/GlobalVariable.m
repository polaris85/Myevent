//
//  GlobalVariable.m
//  TCM
//
//  Created by zao928 on 12/27/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "GlobalVariable.h"
#import <CoreText/CTStringAttributes.h>

@implementation GlobalVariable
@synthesize tableArrayValue;

+(GlobalVariable *)sharedInstance {
    static GlobalVariable *myGlobal = nil;
    
    if (myGlobal == nil) {
        myGlobal = [[[self class] alloc] init];
    }
    return myGlobal;
}

@end
