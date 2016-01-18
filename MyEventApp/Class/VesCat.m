//
//  VesCat.m
//  MyEventApp
//
//  Created by Adam on 3/2/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "VesCat.h"
@interface VesCat ()
@end

@implementation VesCat
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

- (IBAction)onVesB:(id)sender
{
    [delegate showB];
}

- (IBAction)onVesK:(id)sender
{
    [delegate showK];
}

- (IBAction)onVesF:(id)sender
{
    [delegate showF];
}

- (IBAction)onVesM:(id)sender
{
    [delegate showM];
}

@end
