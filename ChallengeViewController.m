//
//  ChallengeViewController.m
//  MemorizePi
//
//  Created by Carmen Ayala on 7/5/15.
//  Copyright (c) 2015 Contrarian Studios. All rights reserved.
//

#import "ChallengeViewController.h"

@implementation ChallengeViewController

- (void)viewDidLoad {
    
   // Load and display saved score
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"savedstring"];
    NSString *loadString = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [_personalBest setText:loadString];
    
    _numberView.clipsToBounds = YES;
    
    [_numberView addSubview:_display];
    [self.view addSubview:_numberView];
    
    _numberOfAttempts = 0;
    _nextNumber = 1;
    
    [super viewDidLoad];
    
   }

-(void)NewHighScore {
    
    if (_numberOfAttempts > [_personalBest.text intValue]) {
        [self shareStuff];
        
    }
}

-(void)ShowHighScore {
    
    if (_numberOfAttempts > [_personalBest.text intValue]) {
        _bestScore = _numberOfAttempts;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *saveString = _personalBest.text = [NSString stringWithFormat:@"%ld", (long)_bestScore];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:saveString];
        [defaults setObject:data forKey:@"savedstring"];
        [self NewHighScore];
    }
    
}
-(void)LoadHighScore {

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [defaults objectForKey:@"savedstring"];
        NSString *loadString = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [_personalBest setText:loadString];
    }

-(void)tryAgain{
    _display.text = (@"3.");
    _digitCount.text = @"0";
    _numberOfAttempts = 0;
    _nextNumber = 1;
    
}

- (IBAction)digitPressed:(id)sender {
    
    //Strings & Ints for Pi characters
    NSString *digit = [sender currentTitle];
    NSString *piPath = [[NSBundle mainBundle] pathForResource:@"piMillion" ofType:@"txt"];
    NSString *piString = [[NSString alloc] initWithContentsOfFile:piPath encoding:NSUTF8StringEncoding error:nil];
    
      //Does the input match Pi txt?
    if ([[sender currentTitle] characterAtIndex:0] == [piString characterAtIndex:_numberOfAttempts]) {
        _numberOfAttempts++;
        _nextNumber++;
        _digitCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)_numberOfAttempts];

            _display.text = [_display.text stringByAppendingString:digit];
        
    }
    else if ([[sender currentTitle] characterAtIndex:0] != [piString characterAtIndex:_numberOfAttempts] && _numberOfAttempts > [_personalBest.text intValue]) {
        [self ShowHighScore];
        [self shareStuff];
        [self tryAgain];
        
    }
    
    else if ([[sender currentTitle] characterAtIndex:0] != [piString characterAtIndex:_numberOfAttempts]) {
        
        UIAlertController *shareController = [UIAlertController alertControllerWithTitle:@"Oops! Wrong Number!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *tryAgainButton = [UIAlertAction actionWithTitle:@"Try Again?" style:UIAlertActionStyleCancel handler:nil];
        [shareController addAction:tryAgainButton];
        [self presentViewController:shareController animated:YES completion:nil];
        
        //Call function to reset UI elements and counters
        [self tryAgain];
        [self ShowHighScore];
        [self tryAgain];
        
    }
}


//Alert controller for sharing score to social media
- (void) shareStuff {
    
    UIAlertController *shareController = [UIAlertController alertControllerWithTitle:@"New High Score!" message:_personalBest.text preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *shareButton = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:
                                  ^(UIAlertAction *sharingStuff) {
                                            NSString *highScore = @"I memorized";
                                            NSString *end = @"digits of Pi!";
                                          NSString *share = _personalBest.text;
                                          NSArray *itemsToShare = @[highScore, share, end];
                                          UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        
           
                                          activityVC.excludedActivityTypes = @[];
                                          [self presentViewController:activityVC animated:YES completion:nil];
                                      
    
                                    }];
  
    
    [shareController addAction:cancelButton];
    
   [shareController addAction:shareButton];
    
    [self presentViewController:shareController animated:YES completion:nil];
    

    
}

@end
