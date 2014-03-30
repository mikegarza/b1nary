//
//  ComplementViewController.h
//  b1nary
//
//  Created by Michael Garza on 2/7/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplementViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *binaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *signedLabel;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)deletePressed:(UIButton *)sender;
@end
