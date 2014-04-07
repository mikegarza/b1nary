//
//  HexViewController.m
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "HexViewController.h"
#import "FromHexConversion.h"

@interface HexViewController ()

@property (nonatomic) BOOL middleOfNumber;

@end

@implementation HexViewController

@synthesize middleOfNumber, binaryLabel, decimalLabel, hexLabel;

static NSString *enterHexNum = @"Enter A Hexadecimal Number";
static NSString *emptyString = @"";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.binaryLabel.adjustsFontSizeToFitWidth = YES;
    self.decimalLabel.adjustsFontSizeToFitWidth = YES;
    self.hexLabel.adjustsFontSizeToFitWidth = YES;
	// Do any additional setup after loading the view.
    [FromHexConversion hexToBinary:@"B5F"];
    [FromHexConversion hexToDecimal:@"B5F"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.middleOfNumber) {
        self.hexLabel.text = [self.hexLabel.text stringByAppendingString:digit];
        self.binaryLabel.text = [FromHexConversion hexToBinary:self.hexLabel.text];
        self.decimalLabel.text = [FromHexConversion hexToDecimal:self.hexLabel.text];
        [self.binaryLabel setNeedsDisplay];
        [self.decimalLabel setNeedsDisplay];
    }
    else {
        self.hexLabel.text = digit;
        self.binaryLabel.text = [FromHexConversion hexToBinary:self.hexLabel.text];
        self.decimalLabel.text = [FromHexConversion hexToDecimal:self.hexLabel.text];
        [self.binaryLabel setNeedsDisplay];
        [self.decimalLabel setNeedsDisplay];
        self.middleOfNumber = YES;
    }
}

- (IBAction)clearPressed:(UIButton *)sender {
    self.middleOfNumber = NO;
    self.hexLabel.text = enterHexNum;
    self.binaryLabel.text = emptyString;
    self.decimalLabel.text = emptyString;
}

- (IBAction)deletePressed:(UIButton *)sender {
    // if the hex # actually exists
    if ([self.hexLabel.text length] != 0) {
        if (![self.hexLabel.text  isEqual: enterHexNum]) {
            NSMutableString *temp = [[NSMutableString alloc] initWithString:self.hexLabel.text];
            [temp deleteCharactersInRange:NSMakeRange([temp length]-1, 1)];
            NSString *finished = temp;
            self.hexLabel.text = finished;
            self.binaryLabel.text = [FromHexConversion hexToBinary:self.hexLabel.text];
            self.decimalLabel.text = [FromHexConversion hexToDecimal:self.hexLabel.text];
            //self.middleOfNumber = YES;
            [self.decimalLabel setNeedsDisplay];
            [self.binaryLabel setNeedsDisplay];
            [self.hexLabel setNeedsDisplay];
        }
    }
    // else deleting from an empty hex #
    else {
        self.hexLabel.text = enterHexNum;
        self.binaryLabel.text = emptyString;
        self.decimalLabel.text = emptyString;
        [self.decimalLabel setNeedsDisplay];
        [self.binaryLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
        self.middleOfNumber = NO;
    }
    // if the hex # is now empty after delete
    if ([self.hexLabel.text length] == 0) {
        self.hexLabel.text = enterHexNum;
        self.binaryLabel.text = emptyString;
        self.decimalLabel.text = emptyString;
        [self.binaryLabel setNeedsDisplay];
        [self.decimalLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
        self.middleOfNumber = NO;
    }

}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
