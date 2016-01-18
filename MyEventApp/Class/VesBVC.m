//
//  VesBVC.m
//  MyEventApp
//
//  Created by Adam on 2/27/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "VesBVC.h"
#import "AppDelegate.h"
#import "ScaleListVC.h"
#import "GlobalVariable.h"

@interface VesBVC ()
@property (nonatomic, retain) NSMutableDictionary *specialDict;

@property (nonatomic, retain) IBOutlet UILabel     *lblOutput;
@property (nonatomic, retain) IBOutlet UIButton    *firstButton;
@property (nonatomic, retain) IBOutlet UIButton    *secondButton;
@property (nonatomic, retain) IBOutlet UIButton    *thirdButtton;
@end

@implementation VesBVC
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
    NSArray *arrValue = @[@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26"];
    [specialDict setObject:arrValue forKey:@"Brasil"];
    arrValue = @[@"1C",@"2C",@"2 1/2C",@"3 1/2C",@"4 1/2C",@"5C",@"6C",@"6 1/2C",@"7 1/2C",@"8C",@"9C",@"10C"];
    [specialDict setObject:arrValue forKey:@"EUA"];
    arrValue = @[@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28"];
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
