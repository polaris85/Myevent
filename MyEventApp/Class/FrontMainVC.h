//
//  FrontMainVC.h
//  MCM
//
//  Created by Adam on 2/13/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RearMainVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GlobalVariable.h"
#import "VesVC.h"
#import "VesCat.h"
#import "VesJasVC.h"
#import "BSYahooFinance.h"
@class YFCurrencyConverter;

@interface FrontMainVC : UIViewController<RearMainVCDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate,CLLocationManagerDelegate,VesDelegate, VesCatDelegate,VesJasDelegate>
{
    int index_first, index_second;
}

- (IBAction)popMenuShow:(id)sender;

@end
