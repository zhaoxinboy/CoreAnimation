//
//  AppDelegate.m
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/2.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "AppDelegate.h"
#import "OCStartApp.h"    // 引入此头文件，自动调用其load方法
#import "ZXViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabBarController;      //

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIViewController *vc1 = [[FirstViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    vc1.tabBarItem.image = [UIImage imageNamed:@"11-1"];
    
    vc1.tabBarItem.title = @"地图";
    
    vc1.view.backgroundColor = [UIColor orangeColor];
    UIViewController *vc2 = [[SecondViewController alloc] init];
    vc2.tabBarItem.image = [UIImage imageNamed:@"11-1"];
    
    vc2.tabBarItem.title = @"运动";
    
    vc2.view.backgroundColor = [UIColor greenColor];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[vc1, vc2];
    self.tabBarController.delegate = self;
    
    
    ZXViewController *vc = [[ZXViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = self.tabBarController;
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
