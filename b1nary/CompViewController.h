//
//  CompViewController.h
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdditionViewController.h"
#import "ComplementViewController.h"
#import "SignedViewController.h"

@interface CompViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchViewController;
@property (nonatomic, copy) NSArray *allViewControllers;
@property (strong, nonatomic) IBOutlet UIView *coverIAP;

// Currently selected view controller
@property (nonatomic, strong) UIViewController *currentViewController;
- (IBAction)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender;
- (IBAction)purchaseTapped:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
