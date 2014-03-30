//
//  BinaryViewController.h
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BinaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *binaryLabel;  // display of inputted binary #
@property (weak, nonatomic) IBOutlet UILabel *decimalLabel; // display of converted decimal #
@property (weak, nonatomic) IBOutlet UILabel *hexLabel;

- (IBAction)digitPressed:(UIButton *)sender;   
- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)deletePressed:(UIButton *)sender;

@end
