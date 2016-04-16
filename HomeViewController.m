//
//  HomeViewController.m
//  MemorizePi
//
//  Created by Carmen Ayala on 7/6/15.
//  Copyright (c) 2015 Contrarian Studios. All rights reserved.
//

#import "HomeViewController.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation HomeViewController

@synthesize practiceLabel;

@synthesize passedData;

-(void) viewDidLoad {
}

- (NSString *) platform{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        NSString *platform = [NSString stringWithUTF8String:machine];
        free(machine);
        return platform;
    }
    




    





@end
