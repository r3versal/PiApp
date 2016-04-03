//
//  ViewController.m
//  MemorizePi
//
//  Created by Carmen Ayala on 6/22/15.
//  Copyright (c) 2015 Contrarian Studios. All rights reserved.
//

#import "ViewController.h"

@import UIKit;

@interface ViewController ()

@end

@implementation ViewController

@synthesize background;


- (void)viewDidLoad {
    
    _numberOfAttempts = 0;
    _nextNumber = 1;
      
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) tryAgain {
    
    _numberOfAttempts = 0;
    _nextNumber = 1;
    _mainScreen.text = (@"3.");
    _nextNumberScreen.text = (@"1");
    _correctDigits.text = @"0";
    
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
        _nextNumberScreen.text = nextNumString;
        _correctDigits.text = [NSString stringWithFormat:@"%lu", (unsigned long)_numberOfAttempts];
        
        //Nested IF statement to Determine if characters fit label space
        if (_numberOfAttempts < 7) {
            _mainScreen.text = [_mainScreen.text stringByAppendingString:digit];
        }
        
        //If not switch to fabricated output list
        else {
            _mainScreen.text = reversedString;
            }
        }
        //Alert Controller is called if input does not match
        else {
            UIAlertController *shareController = [UIAlertController alertControllerWithTitle:@"Oops! Wrong Number!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *tryAgainButton = [UIAlertAction actionWithTitle:@"Try Again?" style:UIAlertActionStyleCancel handler:nil];
            [shareController addAction:tryAgainButton];
            [self presentViewController:shareController animated:YES completion:nil];
            
            //Call function to reset UI elements and counters
            [self tryAgain];
            
    }
  
    
}

@end