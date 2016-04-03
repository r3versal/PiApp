//
//  HomeViewController.h
//  MemorizePi
//
//  Created by Carmen Ayala on 7/6/15.
//  Copyright (c) 2015 Contrarian Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChallengeViewController.h"

@interface HomeViewController : UIViewController {
    
    ChallengeViewController *passedData;
}
@property (strong, nonatomic) IBOutlet UIButton *practiceLabel;

@property (strong, nonatomic) ChallengeViewController *passedData;


@end
