//
//  VesVC.m
//  MyEventApp
//
//  Created by Adam on 2/27/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "VesVC.h"
#import "AppDelegate.h"

@interface VesVC ()
@end

@implementation VesVC
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBak:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
}

- (IBAction)onCat:(id)sender
{
    [delegate showVesCat];
}

- (IBAction)onJas:(id)sender
{
    [delegate showVesJas];
}

@end
