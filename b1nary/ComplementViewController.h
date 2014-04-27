//
//  ComplementViewController.h
//  b1nary
//
//  Created by Michael Garza on 2/7/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplementViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *binaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *signedLabel;
@property (strong, nonatomic) IBOutlet UILabel *decimalLabel;
@property (strong, nonatomic) IBOutlet UILabel *numOfBits;


- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)deletePressed:(UIButton *)sender;
- (IBAction)incrementBits:(UIButton *)sender;
- (IBAction)decrementBits:(UIButton *)sender;

@end
