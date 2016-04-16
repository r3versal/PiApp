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

@property NSInteger bestScore;

@property (strong, nonatomic) IBOutlet UILabel *digitCount;

@property NSUInteger numberOfAttempts;

@property NSUInteger nextNumber;
@property (weak, nonatomic) IBOutlet UIView *numberView;



-(void)ShowHighScore;
-(void)LoadHighScore;


- (IBAction)digitPressed:(id)sender;
@end
