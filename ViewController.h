
//
//  ViewController.h
//  MemorizePi
//
//  Created by Carmen Ayala on 6/22/15.
//  Copyright (c) 2015 Contrarian Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *mainScreen;

@property (weak, nonatomic) IBOutlet UILabel *correctDigits;

@property (strong, nonatomic) IBOutlet UILabel *nextNumberScreen;

@property NSUInteger numberOfAttempts;

@property NSUInteger nextNumber;

@property(strong, nonatomic) UIImageView *background;

@property(nonatomic) NSLineBreakMode lineBreakMode;

- (IBAction)digitPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *numberView;


@end

