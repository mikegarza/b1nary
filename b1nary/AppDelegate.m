//
//  AppDelegate.m
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIImage *tabBarBackground = [UIImage imageNamed:@"tabBar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    
    //[[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"transparentSquare.png"]];
    
    UITabBarItem *tabBarBinary = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarDecimal = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarHex = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarComp = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarHelp = [tabBar.items objectAtIndex:4];
    
    tabBarBinary.title = nil;
    tabBarBinary.imageInsets = UIEdgeInsetsMake(4, 0, -8, 0);
    tabBarBinary.image = [[UIImage imageNamed:@"binaryTab.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarBinary.selectedImage = [[UIImage imageNamed:@"binaryTabSelected.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    //tabBarHome.title = @"Info";
    
    tabBarDecimal.title = nil;
    tabBarDecimal.imageInsets = UIEdgeInsetsMake(4, 0, -8, 0);
    tabBarDecimal.image = [[UIImage imageNamed:@"decimalTab.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarDecimal.selectedImage = [[UIImage imageNamed:@"decimalTabSelected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabBarHex.title = nil;
    tabBarHex.imageInsets = UIEdgeInsetsMake(4, 0, -8, 0);
    tabBarHex.image = [[UIImage imageNamed:@"hexTab.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarHex.selectedImage = [[UIImage imageNamed:@"hexTabSelected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabBarComp.title = nil;
    tabBarComp.imageInsets = UIEdgeInsetsMake(4, 0, -8, 0);
    tabBarComp.image = [[UIImage imageNamed:@"addTab.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarComp.selectedImage = [[UIImage imageNamed:@"addTabSelected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabBarHelp.title = nil;
    tabBarHelp.imageInsets = UIEdgeInsetsMake(4, 0, -8, 0);
    tabBarHelp.image = [[UIImage imageNamed:@"helpTab.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarHelp.selectedImage = [[UIImage imageNamed:@"helpTabSelected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
