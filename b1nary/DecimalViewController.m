//
//  DecimalViewController.m
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "DecimalViewController.h"
#import "FromDecimalConversion.h"

@interface DecimalViewController ()

@property (nonatomic) BOOL middleOfNumber;

@end

@implementation DecimalViewController

@synthesize middleOfNumber, binaryLabel, decimalLabel, hexLabel;

static NSString *enterDecNum = @"Enter A Decimal Number";
static NSString *emptyString = @"";

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [FromDecimalConversion decimalToBinary:@"164"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.middleOfNumber) {
        self.decimalLabel.text = [self.decimalLabel.text stringByAppendingString:digit];
        self.binaryLabel.text = [FromDecimalConversion decimalToBinary:self.decimalLabel.text];
        self.hexLabel.text = [FromDecimalConversion decimalToHex:self.decimalLabel.text];
        [self.binaryLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
    }
    else {
        self.decimalLabel.text = digit;
        self.binaryLabel.text = [FromDecimalConversion decimalToBinary:self.decimalLabel.text];
        self.hexLabel.text = [FromDecimalConversion decimalToHex:self.decimalLabel.text];
        [self.binaryLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
        self.middleOfNumber = YES;
    } 
}

- (IBAction)clearPressed:(UIButton *)sender {
    self.middleOfNumber = NO;
    self.decimalLabel.text = enterDecNum;
    self.binaryLabel.text = emptyString;
    self.hexLabel.text = emptyString;
}

- (IBAction)deletePressed:(UIButton *)sender {
    // if the decimal # actually exists
    if ([self.decimalLabel.text length] != 0) {
        if (![self.decimalLabel.text  isEqual: enterDecNum]) {
            NSMutableString *temp = [[NSMutableString alloc] initWithString:self.decimalLabel.text];
            [temp deleteCharactersInRange:NSMakeRange([temp length]-1, 1)];
            NSString *finished = temp;
            self.decimalLabel.text = finished;
            self.binaryLabel.text = [FromDecimalConversion decimalToBinary:self.decimalLabel.text];
            self.hexLabel.text = [FromDecimalConversion decimalToHex:self.decimalLabel.text];
            //self.middleOfNumber = YES;
            [self.decimalLabel setNeedsDisplay];
            [self.binaryLabel setNeedsDisplay];
            [self.hexLabel setNeedsDisplay];
        }
    }
    // else deleting from an empty decimal #
    else {
        self.decimalLabel.text = enterDecNum;
        self.binaryLabel.text = emptyString;
        self.hexLabel.text = emptyString;
        [self.decimalLabel setNeedsDisplay];
        [self.binaryLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
        self.middleOfNumber = NO;
    }
    // if the decimal # is now empty after delete
    if ([self.decimalLabel.text length] == 0) {
        self.decimalLabel.text = enterDecNum;
        self.binaryLabel.text = emptyString;
        self.hexLabel.text = emptyString;
        [self.binaryLabel setNeedsDisplay];
        [self.decimalLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
        self.middleOfNumber = NO;
    }

}
@end
