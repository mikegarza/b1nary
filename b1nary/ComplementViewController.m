//
//  ComplementViewController.m
//  b1nary
//
//  Created by Michael Garza on 2/7/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "ComplementViewController.h"
#import "BinaryMath.h"

@interface ComplementViewController ()

@property (nonatomic) BOOL middleOfNumber;

@end

@implementation ComplementViewController

static NSString *enterBinNum = @"Enter An Unsigned Binary Num";
static NSString *emptyString = @"";
static int currentBitSize = 8;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.binaryLabel.adjustsFontSizeToFitWidth = YES;
	self.decimalLabel.adjustsFontSizeToFitWidth = YES;
	self.signedLabel.adjustsFontSizeToFitWidth = YES;
	self.numOfBits.adjustsFontSizeToFitWidth = YES;
	self.middleOfNumber = NO;
	
	[BinaryMath twosComplement:@"10010" withWordSize:8];
	[BinaryMath twosComplement:@"11111" withWordSize:8];
	[BinaryMath twosComplementDecimalValue:@"11010011"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender {
	NSString *digit = [sender currentTitle];
	if (self.middleOfNumber) {
		self.binaryLabel.text = [self.binaryLabel.text stringByAppendingString:digit];
		// check if number of digits is greater than word size, increment word size if so
		while ([self.binaryLabel.text length] > currentBitSize)
			currentBitSize += 8;
		if (currentBitSize == 16)
			self.numOfBits.text = @"16";
		else if (currentBitSize == 24)
			self.numOfBits.text = @"24";
		else if (currentBitSize == 32)
			self.numOfBits.text = @"32";
	}
	else {
		self.binaryLabel.text = digit;
		self.signedLabel.text = [BinaryMath twosComplement:self.binaryLabel.text withWordSize:currentBitSize];
		self.decimalLabel.text = [BinaryMath twosComplementDecimalValue:self.signedLabel.text];
		self.middleOfNumber = YES;
	}
	
//	if (self.middleOfNumber) {
//        self.binaryLabel.text = [self.binaryLabel.text stringByAppendingString:digit];
//        self.decimalLabel.text = [FromBinaryConversion binaryToDecimal:self.binaryLabel.text];
//        self.hexLabel.text = [FromBinaryConversion binaryToHex:self.binaryLabel.text];
//        [self.decimalLabel setNeedsDisplay];
//        [self.hexLabel setNeedsDisplay];
//    }

}

- (IBAction)clearPressed:(UIButton *)sender {
	self.binaryLabel.text = enterBinNum;
	self.decimalLabel.text = emptyString;
	self.signedLabel.text = emptyString;
	self.middleOfNumber = NO;
}

- (IBAction)deletePressed:(UIButton *)sender {
}

- (IBAction)incrementBits:(UIButton *)sender {
	if ([self.numOfBits.text isEqualToString:@"8"]) {
		currentBitSize += 8;
		self.numOfBits.text = @"16";
	}
	else if ([self.numOfBits.text isEqualToString:@"16"]) {
		currentBitSize += 8;
		self.numOfBits.text = @"24";
	}
	else if ([self.numOfBits.text isEqualToString:@"24"]){
		currentBitSize += 8;
		self.numOfBits.text = @"32";
	}
}

- (IBAction)decrementBits:(UIButton *)sender {
	if ([self.numOfBits.text isEqualToString:@"32"]) {
		currentBitSize -= 8;
		self.numOfBits.text = @"24";
	}
	else if ([self.numOfBits.text isEqualToString:@"24"]) {
		currentBitSize -= 8;
		self.numOfBits.text = @"16";
	}
	else if ([self.numOfBits.text isEqualToString:@"16"]) {
		currentBitSize -= 8;
		self.numOfBits.text = @"8";
	}
}
@end
