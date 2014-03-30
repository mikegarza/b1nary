//
//  ComplementViewController.m
//  b1nary
//
//  Created by Michael Garza on 2/7/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "ComplementViewController.h"

@interface ComplementViewController ()

@property (nonatomic) BOOL middleOfNumber;

@end

@implementation ComplementViewController

@synthesize binaryLabel, signedLabel, middleOfNumber;

static NSString *enterBinNum = @"Enter An Unsigned Binary Number";
static NSString *emptyString = @"";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    self.middleOfNumber = NO;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender {
}

- (IBAction)clearPressed:(UIButton *)sender {
}

- (IBAction)deletePressed:(UIButton *)sender {
}
@end
