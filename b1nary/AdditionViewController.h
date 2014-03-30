//
//  AdditionViewController.h
//  b1nary
//
//  Created by Michael Garza on 2/7/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdditionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *firstBinaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondBinaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)deletePressed:(UIButton *)sender;
- (IBAction)switchPressed:(UIButton *)sender;
- (IBAction)clearAllPressed:(UIButton *)sender;

@end
