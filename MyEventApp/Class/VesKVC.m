//
//  VesKVC.m
//  MyEventApp
//
//  Created by Adam on 2/27/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "VesKVC.h"
#import "AppDelegate.h"
#import "ScaleListVC.h"
#import "GlobalVariable.h"

@interface VesKVC ()
@property (nonatomic, retain) NSMutableDictionary *specialDict;

@property (nonatomic, retain) IBOutlet UILabel     *lblOutput;
@property (nonatomic, retain) IBOutlet UIButton    *firstButton;
@property (nonatomic, retain) IBOutlet UIButton    *secondButton;
@property (nonatomic, retain) IBOutlet UIButton    *thirdButtton;
@end

@implementation VesKVC
@synthesize specialDict;
@synthesize lblOutput, thirdButtton, firstButton, secondButton;

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
    specialDict = [NSMutableDictionary dictionary];
    NSArray *arrValue = @[@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36"];
    [specialDict setObject:arrValue forKey:@"Brasil"];
    arrValue = @[@"8C",@"9C",@"10C",@"11C",@"11 1/2C",@"12C 1/2C",@"13C",@"1Y",@"1 1/2Y",@"2 1/2Y",@"3 1/2Y",@"4 1/2Y",@"5 1/2Y"];
    [specialDict setObject:arrValue forKey:@"EUA"];
    arrValue = @[@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38"];
    [specialDict setObject:arrValue forKey:@"Europa"];
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

- (IBAction)onFirst:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    ScaleVC *scaleListVC = (ScaleVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ScaleVC"];
    scaleListVC.index= 1;
    [GlobalVariable sharedInstance].tableArrayValue = @[@"Brasil",@"EUA",@"Europa"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDismissFirstViewController)
                                                 name:@"FirstViewControllerDismissed"
                                               object:nil];
    [self presentViewController:scaleListVC animated:YES completion:nil];
}

- (IBAction)onSecond:(id)sender
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    ScaleVC *scaleListVC = (ScaleVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ScaleVC"];
    scaleListVC.index= 2;
    [GlobalVariable sharedInstance].tableArrayValue = [specialDict objectForKey:firstButton.titleLabel.text];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDismissSecondViewController)
                                                 name:@"SecondViewControllerDismissed"
                                               object:nil];
    [self presentViewController:scaleListVC animated:YES completion:nil];
}

- (IBAction)onThird:(id)sender
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    ScaleVC *scaleListVC = (ScaleVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ScaleVC"];
    scaleListVC.index= 3;
    [GlobalVariable sharedInstance].tableArrayValue = @[@"Brasil",@"EUA",@"Europa"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDismissThirdViewController)
                                                 name:@"ThridViewControllerDismissed"
                                               object:nil];
    [self presentViewController:scaleListVC animated:YES completion:nil];
}

- (void)didDismissFirstViewController
{
    firstButton.titleLabel.text = [@[@"Brasil",@"EUA",@"Europa"] objectAtIndex:[GlobalVariable sharedInstance].returnKey];
    index_first = [GlobalVariable sharedInstance].returnKey;
}

- (void)didDismissSecondViewController
{
    secondButton.titleLabel.text = [[specialDict objectForKey:firstButton.titleLabel.text] objectAtIndex:[GlobalVariable sharedInstance].returnKey];
    index_second = [GlobalVariable sharedInstance].returnKey;
}

- (void)didDismissThirdViewController
{
    NSLog(@"this is %d",[GlobalVariable sharedInstance].returnKey);
    thirdButtton.titleLabel.text = [@[@"Brasil",@"EUA",@"Europa"] objectAtIndex:[GlobalVariable sharedInstance].returnKey];
    index_third = [GlobalVariable sharedInstance].returnKey;
    NSArray *resultArray = [specialDict objectForKey:thirdButtton.titleLabel.text];
    lblOutput.text = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:index_second]];
}

@end