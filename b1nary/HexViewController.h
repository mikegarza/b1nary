//
//  HexViewController.h
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HexViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *hexLabel;
@property (weak, nonatomic) IBOutlet UILabel *binaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *decimalLabel;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)deletePressed:(UIButton *)sender;

@end
