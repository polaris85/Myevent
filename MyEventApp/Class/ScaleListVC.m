//
//  ScaleListVC.m
//  MyEventApp
//
//  Created by Adam on 3/1/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "ScaleListVC.h"
#import "GlobalVariable.h"

@interface ScaleListVC ()
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@end

@implementation ScaleListVC
@synthesize myTableView, isFirst;

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[GlobalVariable sharedInstance].tableArrayValue count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"eventCell"];
    cell.textLabel.text = [[GlobalVariable sharedInstance].tableArrayValue objectAtIndex:indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [GlobalVariable sharedInstance].returnKey = (int)indexPath.row;
    
    if (isFirst)[[NSNotificationCenter defaultCenter] postNotificationName:@"FirstViewControllerDismissed"
                                                        object:nil
                                                      userInfo:nil];
    else[[NSNotificationCenter defaultCenter] postNotificationName:@"SecondViewControllerDismissed"
                                                                    object:nil
                                                                  userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
