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
    _numberView.clipsToBounds = YES;
    
    [_numberView addSubview:_mainScreen];
    [self.view addSubview:_numberView];
    
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
   
    //Next number in Pi
    NSString *nextNumString = [NSString stringWithFormat:@"%c",[piString characterAtIndex:_nextNumber]];
    
    //Does the input match Pi txt?
    if ([[sender currentTitle] characterAtIndex:0] == [piString characterAtIndex:_numberOfAttempts]) {
        _numberOfAttempts++;
        _nextNumber++;
        _nextNumberScreen.text = nextNumString;
        _correctDigits.text = [NSString stringWithFormat:@"%lu", (unsigned long)_numberOfAttempts];

            _mainScreen.text = [_mainScreen.text stringByAppendingString:digit];
        

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
