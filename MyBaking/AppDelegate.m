//
//  AppDelegate.m
//  MyBaking
//
//  Created by lei on 11/11/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "AppDelegate.h"
#import "ProbelConnector.h"
#import "GraphViewDetailController.h"
#import "LocalizeHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ProbelConnector *connect = [ProbelConnector sharedProelConnector];
    [connect startConnector];
    
    BakingViewController *bakingVC = [[BakingViewController alloc] init];
    GraphViewDetailController *graphVC = [[GraphViewDetailController alloc] init];
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    
//    LocalizationSetLanguage(@"zh-Hans");
    bakingVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Cooking", @"烧烤") image:[UIImage imageNamed: @"tab0U.png"] selectedImage:[UIImage imageNamed: @"tab0S.png"]];
    graphVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Graph", @"图表") image:[UIImage imageNamed: @"tab1U.png"] selectedImage:[UIImage imageNamed: @"tab1S.png"]];
    infoVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Info", @"信息") image:[UIImage imageNamed: @"tab2U.png"] selectedImage:[UIImage imageNamed: @"tab2S.png"]];
    settingVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Settings", @"设置") image:[UIImage imageNamed: @"tab3U.png"] selectedImage:[UIImage imageNamed: @"tab3S.png"]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:bakingVC, graphVC, infoVC, settingVC, nil];

    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
