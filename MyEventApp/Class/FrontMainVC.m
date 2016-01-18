//
//  FrontMainVC.m
//  MCM
//
//  Created by Adam on 2/13/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import "FrontMainVC.h"
#import "AppDelegate.h"
#import "DejalActivityView.h"
#import "GlobalVariable.h"

#import "TempVC.h"
#import "ComVC.h"
#import "VesVC.h"
#import "MassaVC.h"
#import "VolumVC.h"
#import "VelocVC.h"

#import "VesBVC.h"
#import "VesFVC.h"
#import "VesKVC.h"
#import "VesMVC.h"

#import "VesJasFVC.h"
#import "VesJasMVC.h"

#import "AppDelegate.h"
#import "ScaleListVC.h"
#import "GlobalVariable.h"

@interface FrontMainVC ()

//@property (nonatomic, retain) NSArray *scaleArray;
//@property (nonatomic, retain) NSArray *scaleNameArray;
@property (nonatomic, retain) IBOutlet UITextField *txtInput;
@property (nonatomic, retain) IBOutlet UILabel     *lblOutput;
@property (nonatomic, retain) IBOutlet UIButton    *firstButton;
@property (nonatomic, retain) IBOutlet UIButton    *secondButton;

@property (nonatomic, retain) NSArray *currencyList;
@property (nonatomic, retain) NSDictionary *currencyRateMatrix;
@property (nonatomic, retain) YFCurrencyConverter *currencyConversion;

- (NSArray *)loadCurrencies;
- (void)updateResult;

@end

@implementation FrontMainVC
//@synthesize scaleArray,scaleNameArray;
@synthesize lblOutput, txtInput, firstButton, secondButton,currencyConversion,currencyList, currencyRateMatrix;

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
    
    NSArray *allCurrencies = [self loadCurrencies];
    self.currencyConversion = [YFCurrencyConverter currencyConverterWithDelegate:self];
    self.currencyConversion.didFailSelector = @selector(currencyConversionDidFail:);
    self.currencyConversion.didFinishSelector = @selector(currencyConversionDidFinish:);
    [self.currencyConversion convertFromCurrencies:allCurrencies toCurrencies:allCurrencies asychronous:YES];
    [DejalBezelActivityView activityViewForView:self.view].showNetworkActivityIndicator = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)currencyConversionDidFinish:(YFCurrencyConverter *)converter
{
    self.currencyRateMatrix = converter.batchConversionRates;
    self.currencyList = [self loadCurrencies];
    self.currencyConversion = nil;
    [DejalBezelActivityView removeView];
}

- (void)currencyConversionDidFail:(YFCurrencyConverter *)converter
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Details failed"
                                                    message:[converter.error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Private methods
- (NSArray *)loadCurrencies
{
    // Load a whole bunch of currencies used for Yahoo stocks. It should be around 20 currencies
    NSDictionary *stockCurrency = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StockExchangeCurrency" ofType:@"plist"]];
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    [tempDict setValue:@"" forKey:@"USD"];
    
    // Filter out so there's only one of each currency
    for (NSString *key in stockCurrency)
    {
        if ([tempDict valueForKey:[stockCurrency valueForKey:key]] == nil)
            [tempDict setValue:@"" forKey:[stockCurrency valueForKey:key]];
    }
    
    // Returns sorted array
    return [[tempDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)updateResult
{
    if (self.currencyList) {
        NSString *from = [self.currencyList objectAtIndex:index_first];
        NSString *to = [self.currencyList objectAtIndex:index_second];
        
        float rate = [[[self.currencyRateMatrix valueForKey:from] valueForKey:to] floatValue];
        lblOutput.text = [self cutOff:[NSString stringWithFormat:@"%f",[[txtInput.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]*rate]];
    }
}

- (NSString*)cutOff:(NSString*)NewString
{
    NSArray *arrString = [NewString componentsSeparatedByString:@"."];
    NSString *highValue = [arrString objectAtIndex:0];
    return [NewString substringToIndex:[highValue length] + 3];
}

- (void)dismissKeyboard {
    [txtInput resignFirstResponder] ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)onFirst:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    ScaleListVC *scaleListVC = (ScaleListVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ScaleListVC"];
    scaleListVC.isFirst= YES;
    [GlobalVariable sharedInstance].tableArrayValue = self.currencyList;
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
    [GlobalVariable sharedInstance].tableArrayValue = self.currencyList;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDismissSecondViewController)
                                                 name:@"SecondViewControllerDismissed"
                                               object:nil];
    [self presentViewController:scaleListVC animated:YES completion:nil];
}

- (void)didDismissFirstViewController
{
    firstButton.titleLabel.text = [self.currencyList objectAtIndex:[GlobalVariable sharedInstance].returnKey];
    index_first = [GlobalVariable sharedInstance].returnKey;
}

- (void)didDismissSecondViewController
{
    secondButton.titleLabel.text = [self.currencyList objectAtIndex:[GlobalVariable sharedInstance].returnKey];
    index_second = [GlobalVariable sharedInstance].returnKey;
    [self  updateResult];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popMenuShow:(id)sender{
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.viewController revealToggle:self.navigationController.parentViewController];
}

- (void) showHome{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    FrontMainVC*dashBoardVC = (FrontMainVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"frontMainVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showTemp{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    TempVC *dashBoardVC = (TempVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"TempVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showVes{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VesVC *dashBoardVC = (VesVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VesVC"];
    dashBoardVC.delegate = self;
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showComp{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    ComVC *dashBoardVC = (ComVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ComVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showMas{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    MassaVC *dashBoardVC = (MassaVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"MassaVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showVolum{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VolumVC *dashBoardVC = (VolumVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VolumVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showVel{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VelocVC *dashBoardVC = (VelocVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VelocVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showVesCat{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VesCat *dashBoardVC = (VesCat*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VesCat"];
    dashBoardVC.delegate = self;
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showVesJas{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VesJasVC *dashBoardVC = (VesJasVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VesJasVC"];
    dashBoardVC.delegate = self;
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showB
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VesBVC *dashBoardVC = (VesBVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VesBVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showK
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VesKVC *dashBoardVC = (VesKVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VesKVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showF
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VesFVC *dashBoardVC = (VesFVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VesFVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showM
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VesMVC *dashBoardVC = (VesMVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VesMVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showJasF
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VesJasFVC *dashBoardVC = (VesJasFVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VesJasFVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

- (void) showJasM
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    VesJasMVC *dashBoardVC = (VesJasMVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VesJasMVC"];
    [self.navigationController pushViewController:dashBoardVC animated:NO];
}

@end
