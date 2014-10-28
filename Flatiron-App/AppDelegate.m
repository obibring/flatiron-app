//
//  AppDelegate.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "OnboardingViewController.h"
#import "Constants.h"
#import <FAKFontAwesome.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window.tintColor = flatironBlueLight;

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    //Setup Parse application
    [Parse setApplicationId:@"rHT2ppWvtYGMh4LQoF3C2yd0imLqtlr8ekXx7tho"
                  clientKey:@"4h32PZf2F3f6XkcnDPsUWMkagID8QdRiVE6yWeCB"];

    // Track statistics around application opens
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    // Check if the user is logged in
    if ([PFUser currentUser]) {
        self.window.rootViewController = [self firstLoggedInViewController];
    } else {
        self.window.rootViewController = [[OnboardingViewController alloc] init];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogin:) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogout:) name:@"logout" object:nil];

    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

-(UIViewController *)firstLoggedInViewController {
    UITabBarController *tabCtrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabBarViewController"];
    
//    tabCtrl.tabBar.backgroundColor = flatironBlueDark;
    tabCtrl.tabBar.tintColor = flatironBlueDark;
    
    // Set up the tab bar icons
    FAKFontAwesome *usersIcon = [FAKFontAwesome usersIconWithSize:20];
    ((UIViewController *)tabCtrl.viewControllers[0]).tabBarItem.image = [usersIcon imageWithSize:CGSizeMake(20, 20)];
    
    FAKFontAwesome *calendarIcon = [FAKFontAwesome calendarIconWithSize:20];
    ((UIViewController *)tabCtrl.viewControllers[1]).tabBarItem.image = [calendarIcon imageWithSize:CGSizeMake(20, 20)];

    FAKFontAwesome *userIcon = [FAKFontAwesome userIconWithSize:20];
    ((UIViewController *)tabCtrl.viewControllers[2]).tabBarItem.image = [userIcon imageWithSize:CGSizeMake(20, 20)];
    
    return tabCtrl;
}

-(void)didLogin:(NSNotification *)notification {
    NSLog(@"didLogin: called");
    self.window.rootViewController = [self firstLoggedInViewController];
}


-(void)didLogout:(NSNotification *)notification {
    self.window.rootViewController = [[OnboardingViewController alloc] init];
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
