//
//  RearMainVC.m
//  MCM
//
//  Created by Adam on 2/13/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import "RearMainVC.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RearMainVC () <CLLocationManagerDelegate>
@end

@implementation RearMainVC

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
}

-(void)viewDidAppear:(BOOL)animated {
   
    [super viewDidAppear:YES];
}

- (void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMode:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
    [self.delegate showHome];
}

- (IBAction)onTemp:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
    [self.delegate showTemp];
}

- (IBAction)onVes:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
    [self.delegate showVes];
}

- (IBAction)onComp:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
    [self.delegate showComp];
}

- (IBAction)onMas:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
    [self.delegate showMas];
}

- (IBAction)onVolum:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
    [self.delegate showVolum];
}

- (IBAction)onVel:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
    [self.delegate showVel];
}

@end
