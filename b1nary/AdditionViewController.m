//
//  AdditionViewController.m
//  b1nary
//
//  Created by Michael Garza on 2/7/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "AdditionViewController.h"
#import "BinaryMath.h"

@interface AdditionViewController ()

@property (nonatomic) BOOL middleOfFirstNumber;
@property (nonatomic) BOOL middleOfSecondNumber;
@property (nonatomic) BOOL onFirstNumber;
//@property (nonatomic) BOOL twoValidNumbers;

@end

@implementation AdditionViewController

@synthesize firstBinaryLabel, secondBinaryLabel, middleOfFirstNumber, middleOfSecondNumber, totalLabel, onFirstNumber;

static NSString *enterFirstBinNum = @"Enter First Binary Number";
static NSString *enterSecondBinNum = @"Enter Second Binary Number";
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
	// Do any additional setup after loading the view.
    self.middleOfFirstNumber = NO;
    self.middleOfSecondNumber = NO;
    self.onFirstNumber = YES;
    //self.twoValidNumbers = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    // if inserting the first binary number
    if (self.onFirstNumber) {
        // if currently entering a number
        if (self.middleOfFirstNumber) {
            self.firstBinaryLabel.text = [self.firstBinaryLabel.text stringByAppendingString:digit];
            // if there are two valid numbers, do the addition
            if ([self twoValidNumbers]) {
                self.totalLabel.text = [BinaryMath binaryAddition:self.firstBinaryLabel.text withSecondNumber:self.secondBinaryLabel.text];
                [self.totalLabel setNeedsDisplay];
            }
        }
        // else first digit
        else {
            self.firstBinaryLabel.text = digit;
            // if two valid numbers, do the addition
            if ([self twoValidNumbers]) {
                self.totalLabel.text = [BinaryMath binaryAddition:self.firstBinaryLabel.text withSecondNumber:self.secondBinaryLabel.text];
                [self.totalLabel setNeedsDisplay];
            }
            self.middleOfFirstNumber = YES;
        }
    }
    // else on second binary number
    else {
        // if currently entering a number
        if (self.middleOfSecondNumber) {
            self.secondBinaryLabel.text = [self.secondBinaryLabel.text stringByAppendingString:digit];
            // if two valid numbers, do the addition
            if ([self twoValidNumbers]) {
                self.totalLabel.text = [BinaryMath binaryAddition:self.firstBinaryLabel.text withSecondNumber:self.secondBinaryLabel.text];
                [self.totalLabel setNeedsDisplay];
            }
        }
        // else first digit
        else {
            self.secondBinaryLabel.text = digit;
            // if two valid numbers, do the addition
            if ([self twoValidNumbers]) {
                self.totalLabel.text = [BinaryMath binaryAddition:self.firstBinaryLabel.text withSecondNumber:self.secondBinaryLabel.text];
                [self.totalLabel setNeedsDisplay];
            }
            self.middleOfSecondNumber = YES;
        }
    }
}

- (IBAction)clearPressed:(UIButton *)sender {
    if (self.onFirstNumber) {
        self.middleOfFirstNumber = NO;
        self.firstBinaryLabel.text = enterFirstBinNum;
        self.totalLabel.text = emptyString;
    }
    else {
        self.middleOfSecondNumber = NO;
        self.secondBinaryLabel.text = enterSecondBinNum;
        self.totalLabel.text = emptyString;
    }
}

- (IBAction)deletePressed:(UIButton *)sender {
    if (self.onFirstNumber) {
        // if the number exists
        if ([self.firstBinaryLabel.text length] != 0) {
            if (![self.firstBinaryLabel.text isEqual:enterFirstBinNum]) {
                NSMutableString *temp = [[NSMutableString alloc] initWithString:self.firstBinaryLabel.text];
                [temp deleteCharactersInRange:NSMakeRange([temp length]-1,1)];
                NSString *finished = temp;
                self.firstBinaryLabel.text = finished;
                // if two valid numbers, do the addition
                if ([self twoValidNumbers]) {
                    self.totalLabel.text = [BinaryMath binaryAddition:self.firstBinaryLabel.text withSecondNumber:self.secondBinaryLabel.text];
                    [self.firstBinaryLabel setNeedsDisplay];
                    [self.secondBinaryLabel setNeedsDisplay];
                    [self.totalLabel setNeedsDisplay];
                }
            }
        }
        // else deleting from an empty first number
        else {
            self.firstBinaryLabel.text = enterFirstBinNum;
            self.totalLabel.text = emptyString;
            [self.firstBinaryLabel setNeedsDisplay];
            [self.secondBinaryLabel setNeedsDisplay];
            [self.totalLabel setNeedsDisplay];
            self.middleOfFirstNumber = NO;
        }
        // if the first number is now empty
        if ([self.firstBinaryLabel.text length] == 0) {
            self.firstBinaryLabel.text = enterFirstBinNum;
            self.totalLabel.text = emptyString;
            [self.firstBinaryLabel setNeedsDisplay];
            [self.totalLabel setNeedsDisplay];
            self.middleOfFirstNumber = NO;
        }
    }
    // else on second number
    else {
        if ([self.secondBinaryLabel.text length] != 0) {
            if (![self.secondBinaryLabel.text isEqual:enterSecondBinNum]) {
                NSMutableString *temp = [[NSMutableString alloc] initWithString:self.secondBinaryLabel.text];
                [temp deleteCharactersInRange:NSMakeRange([temp length]-1,1)];
                NSString *finished = temp;
                self.secondBinaryLabel.text = finished;
                // if two valid numbers, do the addition
                if ([self twoValidNumbers]) {
                    self.totalLabel.text = [BinaryMath binaryAddition:self.firstBinaryLabel.text withSecondNumber:self.secondBinaryLabel.text];
                    [self.firstBinaryLabel setNeedsDisplay];
                    [self.secondBinaryLabel setNeedsDisplay];
                    [self.totalLabel setNeedsDisplay];
                }
            }
        }
        // else deleting from an empty first number
        else {
            self.secondBinaryLabel.text = enterFirstBinNum;
            self.totalLabel.text = emptyString;
            [self.firstBinaryLabel setNeedsDisplay];
            [self.secondBinaryLabel setNeedsDisplay];
            [self.totalLabel setNeedsDisplay];
            self.middleOfSecondNumber = NO;
        }
        // if the first number is now empty
        if ([self.secondBinaryLabel.text length] == 0) {
            self.secondBinaryLabel.text = enterSecondBinNum;
            self.totalLabel.text = emptyString;
            [self.secondBinaryLabel setNeedsDisplay];
            [self.totalLabel setNeedsDisplay];
            self.middleOfSecondNumber = NO;
        }
    }
}

- (IBAction)switchPressed:(UIButton *)sender {
    if (self.onFirstNumber)
        self.onFirstNumber = NO;
    else
        self.onFirstNumber = YES;
}

- (IBAction)clearAllPressed:(UIButton *)sender {
    self.middleOfFirstNumber = NO;
    self.middleOfSecondNumber = NO;
    self.onFirstNumber = YES;
    self.firstBinaryLabel.text = enterFirstBinNum;
    self.secondBinaryLabel.text = enterSecondBinNum;
    self.totalLabel.text = emptyString;
}

- (BOOL) twoValidNumbers {
    NSString *firstNum = [[NSString alloc] initWithString:self.firstBinaryLabel.text];
    NSString *secondNum = [[NSString alloc] initWithString:self.secondBinaryLabel.text];
    if (([firstNum isEqualToString:enterFirstBinNum]) || ([secondNum isEqualToString:enterSecondBinNum])) {
        return NO;
    }
    else
        return YES;
}
@end
