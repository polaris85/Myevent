//
//  ComVC.m
//  MyEventApp
//
//  Created by Adam on 2/27/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "ComVC.h"
#import "AppDelegate.h"
#import "ScaleListVC.h"
#import "GlobalVariable.h"

@interface ComVC ()
@property (nonatomic, retain) NSArray *scaleArray;
@property (nonatomic, retain) NSArray *scaleNameArray;
@property (nonatomic, retain) IBOutlet UITextField *txtInput;
@property (nonatomic, retain) IBOutlet UILabel     *lblOutput;
@property (nonatomic, retain) IBOutlet UIButton    *firstButton;
@property (nonatomic, retain) IBOutlet UIButton    *secondButton;
@end

@implementation ComVC
@synthesize scaleArray,scaleNameArray;
@synthesize lblOutput, txtInput, firstButton, secondButton;

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
    scaleNameArray = @[@"mm", @"cm", @"m", @"km",@"mi(mile ou milha)",@"in (inch ou polegada)",@"ft (feet ou pé)",@"yd (yard ou jarda)",@"sea mile (milha marítima)",@"fathom (braça)"];
    scaleArray = @[@"0.001", @"0.01", @"1.0", @"1000",@"1609.344",@"0.0254",@"0.3048",@"0.9144",@"1852",@"18288"];
    [GlobalVariable sharedInstance].tableArrayValue = [NSArray arrayWithArray:scaleNameArray];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [txtInput resignFirstResponder] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)onBak:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
}

- (double)onCalculateScale:(int)index1 nextScale:(int)index2
{
    return [[scaleArray objectAtIndex:index1] doubleValue]/[[scaleArray objectAtIndex:index2] doubleValue];
}

- (IBAction)onFirst:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    ScaleListVC *scaleListVC = (ScaleListVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ScaleListVC"];
    scaleListVC.isFirst= YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDismissFirstViewController)
                                                 name:@"FirstViewControllerDismissed"
                                               object:nil];
    [self presentViewController:scaleListVC animated:YES completion:nil];
}

- (IBAction)onSecond:(id)sender
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    ScaleListVC *scaleListVC = (ScaleListVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ScaleListVC"];
    scaleListVC.isFirst= NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDismissSecondViewController)
                                                 name:@"SecondViewControllerDismissed"
                                               object:nil];
    [self presentViewController:scaleListVC animated:YES completion:nil];
}

- (void)didDismissFirstViewController
{
    firstButton.titleLabel.text = [scaleNameArray objectAtIndex:[GlobalVariable sharedInstance].returnKey];
    index_first = [GlobalVariable sharedInstance].returnKey;
}

- (void)didDismissSecondViewController
{
    secondButton.titleLabel.text = [scaleNameArray objectAtIndex:[GlobalVariable sharedInstance].returnKey];
    index_second = [GlobalVariable sharedInstance].returnKey;
    lblOutput.text = [self cutOff:[NSString stringWithFormat:@"%f",[[txtInput.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue]*[self onCalculateScale:index_first nextScale:index_second]]];
}

- (NSString*)cutOff:(NSString*)NewString
{
    NSArray *arrString = [NewString componentsSeparatedByString:@"."];
    NSString *highValue = [arrString objectAtIndex:0];
    return [NewString substringToIndex:[highValue length] + 3];
}

@end
