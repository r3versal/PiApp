//
//  HomeViewController.m
//  MemorizePi
//
//  Created by Carmen Ayala on 7/6/15.
//  Copyright (c) 2015 Contrarian Studios. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

@synthesize practiceLabel;

@synthesize passedData;

-(void) viewDidLoad {
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
        return YES;
        
        
    }
    





@end
