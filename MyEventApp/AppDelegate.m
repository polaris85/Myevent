//
//  AppDelegate.m
//  MyEventApp
//
//  Created by Adam on 10/15/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "FrontMainVC.h"
#import "RearMainVC.h"
#import "CommonClass.h"
#import "Define.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard  *mainStoryBoard = [[UIStoryboard alloc] init];
    mainStoryBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    FrontMainVC *mainMenuVC = [[CommonClass shareInstance] getAudioPlayerVC];
    RearMainVC *controlMenuVC = [[CommonClass shareInstance] getAudioListVC];
    controlMenuVC.delegate = mainMenuVC;
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:mainMenuVC];
    navigationController.navigationBarHidden = YES;
    
    ZUUIRevealController *zuuiRevealController = [[ZUUIRevealController alloc]initWithFrontViewController:navigationController rearViewController:controlMenuVC];
    self.viewController = zuuiRevealController;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {

}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
   
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

@end
