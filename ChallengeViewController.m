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
    
    //Load and display saved score
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"savedstring"];
    NSString *loadString = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [_personalBest setText:loadString];
    
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
    NSRange range1 = NSMakeRange(0, 7);
    NSUInteger minusOne = 1;
    NSInteger prevNumList = _nextNumber - minusOne;
    NSString *piShort = [piString substringFromIndex:prevNumList];
    NSString *piShortRange = [piShort substringWithRange:range1];
    
    //Reverses String to show character output
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [piShortRange length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[piShortRange substringWithRange:subStrRange]];
        NSLog(@"%@", piShortRange);
        NSLog(@"%@", reversedString);
    }
    
    //Next number in Pi
    NSString *nextNumString = [NSString stringWithFormat:@"%c",[piString characterAtIndex:_nextNumber]];
    
    //Does the input match Pi txt?
    if ([[sender currentTitle] characterAtIndex:0] == [piString characterAtIndex:_numberOfAttempts]) {
        _numberOfAttempts++;
        _nextNumber++;
        _digitCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)_numberOfAttempts];
       // _nextNumberScreen.text = nextNumString;
       // _correctDigits.text = [NSString stringWithFormat:@"%lu", (unsigned long)_numberOfAttempts];
        
        //Nested IF statement to Determine if characters fit label space
        if (_numberOfAttempts < 7) {
            _display.text = [_display.text stringByAppendingString:digit];
        }
        
        //If not switch to fabricated output list
        else {
            _display.text = reversedString;
        }
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
    
    




/*- (IBAction)digitPressed:(id)sender {
 
    
    if ([[sender currentTitle] characterAtIndex:0] == [piString characterAtIndex:_numberOfAttempts]) {
        _numberOfAttempts++;
        _digitCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)_numberOfAttempts];
        
            //Nested IF statement to Determine if characters fit label space
            if (_numberOfAttempts < 7) {
                _display.text = [_display.text stringByAppendingString:digit];
            }
        
                //If not switch to fabricated output list
                else {
                _display.text = piShortRange;
                }
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
}*/



//Alert controller for sharing score to social media
- (void) shareStuff {
 
    NSString *someText = @"My high score is:";
    NSString *share = _personalBest.text;
    NSArray *itemsToShare = @[someText, share];
    
    UIAlertController *shareController = [UIAlertController alertControllerWithTitle:@"New High Score!" message:_personalBest.text preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *shareButton = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:
                                  ^(UIAlertAction *sharingStuff) {
                                
                                          NSString *someText = @"My high score is:";
                                          NSString *share = _personalBest.text;
                                          NSArray *itemsToShare = @[someText, share];
                                          UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        
           
                                          activityVC.excludedActivityTypes = @[];
                                          [self presentViewController:activityVC animated:YES completion:nil];
    
                                    }];
    
    
    [shareController addAction:cancelButton];
    
    [shareController addAction:shareButton];
    
    [self presentViewController:shareController animated:YES completion:nil];

    
    
}

@end