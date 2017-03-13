//
//  AppDelegate.m
//  Uepp-0307
//
//  Created by 严素 on 2017/3/7.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "AppDelegate.h"
#import "QRcodeViewController.h"
#import "billViewController.h"
#import "informationViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window  = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //创建tablebar
    UITabBarController *tabBarVc = [[UITabBarController alloc]init];
    self.window.rootViewController = tabBarVc;
    
    //控制器添加到tablebar
    QRcodeViewController *qrVc =[[QRcodeViewController alloc]init];
    billViewController *billVc = [[billViewController alloc]init];
    informationViewController *infromationVc = [[informationViewController alloc]init];
    //添加控制导航器
    UINavigationController *qrNavVc = [[UINavigationController alloc] initWithRootViewController:qrVc];
    UINavigationController *billNavVc = [[UINavigationController alloc] initWithRootViewController:billVc];
    UINavigationController *informationNavVc = [[UINavigationController alloc] initWithRootViewController:infromationVc];
    //设置tabbar
    [tabBarVc addChildViewController:qrNavVc];
    [tabBarVc addChildViewController:billNavVc];
    [tabBarVc addChildViewController:informationNavVc];
    //设置tabBar title
    qrVc.tabBarItem.title = @"收款";
    qrVc.tabBarItem.image =[UIImage imageNamed:@"icon_tab_collection_choose_27x27_"];
    billVc.tabBarItem.title = @"账单";
    billVc.tabBarItem.image =[UIImage imageNamed:@"icon_tab_collection_choose_27x27_"];
    infromationVc.tabBarItem.title = @"我的";
    infromationVc.tabBarItem.image =[UIImage imageNamed:@"icon_tab_me_choose_27x27_"];
    //设置UINavigationController title
    

    [self.window makeKeyAndVisible];
    
    return YES;
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
