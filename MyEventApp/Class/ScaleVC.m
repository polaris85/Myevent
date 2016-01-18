//
//  ScaleVC.m
//  MyEventApp
//
//  Created by Adam on 3/2/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "ScaleVC.h"
#import "GlobalVariable.h"

@interface ScaleVC ()

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@end

@implementation ScaleVC
@synthesize myTableView, index;

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
    switch (index) {
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FirstViewControllerDismissed"
                                                                object:nil
                                                              userInfo:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SecondViewControllerDismissed"
                                                                object:nil
                                                              userInfo:nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ThridViewControllerDismissed"
                                                                object:nil
                                                              userInfo:nil];
            break;
    }
   
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
