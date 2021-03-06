//
//  AppDelegate.m
//  Voice
//
//  Created by Shalin Shah on 7/26/14.
//  Copyright (c) 2014 Shalin Shah. All rights reserved.
//
#import "AppDelegate.h"
#import "ViewController.h"
#import "Mixpanel.h"
#import "Appirater.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"ImportantEvent"];
    
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    [Appirater setAppId:@"903772588"];
    
    [Fabric with:@[CrashlyticsKit]];
    
    // Set image capture mode to manual
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IsAuto"];
    
    ViewController *mainView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainView"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainView];
    self.window.rootViewController = navController;
    
    NSError *error = NULL;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if(error) {
        // Do some error handling
    }
    [session setActive:YES error:&error];
    if (error) {
        // Do some error handling
    }
    
    // Clear NSUserDefaults
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"en-US"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"en"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"languageForTTS"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"languageForOCR"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ImagesArray"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ImageText"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"App Opened"];
    
    [Appirater setDaysUntilPrompt:2];
    [Appirater setUsesUntilPrompt:5];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
    
    
    // Override point for customization after application launch.
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
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
