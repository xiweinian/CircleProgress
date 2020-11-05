//
//  AppDelegate.m
//  CircleProgressDemo
//
//  Created by ZHHL on 2020/3/26.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    NSLog(@"123");
    self.window.rootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    [self.window makeKeyAndVisible];
    return YES;
}




@end
