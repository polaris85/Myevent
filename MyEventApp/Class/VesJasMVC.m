//
//  VesJasMVC.m
//  MyEventApp
//
//  Created by Adam on 3/2/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "VesJasMVC.h"
#import "AppDelegate.h"
#import "GlobalVariable.h"

@interface VesJasMVC ()
@property (nonatomic, retain) NSMutableDictionary *specialDict;

@property (nonatomic, retain) IBOutlet UILabel     *lblOutput;
@property (nonatomic, retain) IBOutlet UIButton    *firstButton;
@property (nonatomic, retain) IBOutlet UIButton    *secondButton;
@property (nonatomic, retain) IBOutlet UIButton    *thirdButtton;
@end

@implementation VesJasMVC
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
    NSArray *arrValue = @[@"38",@"40",@"42",@"44",@"46",@"48",@"50"];
    [specialDict setObject:arrValue forKey:@"Brasil"];
    arrValue = @[@"30",@"32",@"33",@"34",@"36",@"38",@"40"];
    [specialDict setObject:arrValue forKey:@"EUA"];
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
    [GlobalVariable sharedInstance].tableArrayValue = @[@"Brasil",@"EUA"];
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
    [GlobalVariable sharedInstance].tableArrayValue = @[@"Brasil",@"EUA"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDismissThirdViewController)
                                                 name:@"ThridViewControllerDismissed"
                                               object:nil];
    [self presentViewController:scaleListVC animated:YES completion:nil];
}

- (void)didDismissFirstViewController
{
    firstButton.titleLabel.text = [@[@"Brasil",@"EUA"] objectAtIndex:[GlobalVariable sharedInstance].returnKey];
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
    thirdButtton.titleLabel.text = [@[@"Brasil",@"EUA"] objectAtIndex:[GlobalVariable sharedInstance].returnKey];
    index_third = [GlobalVariable sharedInstance].returnKey;
    NSArray *resultArray = [specialDict objectForKey:thirdButtton.titleLabel.text];
    lblOutput.text = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:index_second]];
}

@end
