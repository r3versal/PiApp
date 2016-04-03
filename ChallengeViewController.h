//
//  ChallengeViewController.h
//  MemorizePi
//
//  Created by Carmen Ayala on 7/5/15.
//  Copyright (c) 2015 Contrarian Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *display;

@property (strong, nonatomic) IBOutlet UILabel *personalBest;

@property (strong, nonatomic) IBOutlet UILabel *personalBestLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentStreakLabel;

@property NSInteger bestScore;

@property (strong, nonatomic) IBOutlet UILabel *digitCount;

@property NSUInteger numberOfAttempts;

@property NSUInteger nextNumber;


-(void)ShowHighScore;
-(void)LoadHighScore;


- (IBAction)digitPressed:(id)sender;
@end
