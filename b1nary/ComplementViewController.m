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

static NSString *enterBinNum = @"Enter Unsigned Binary Num";
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
	[BinaryMath twosComplementDecimalValue:@"00000000"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender {
	NSString *digit = [sender currentTitle];
	if (self.middleOfNumber) {
		if ([BinaryMath validUnsignedNumber:[self.binaryLabel.text stringByAppendingString:digit] withWordSize:currentBitSize]) {
			self.binaryLabel.text = [self.binaryLabel.text stringByAppendingString:digit];
			self.signedLabel.text = [BinaryMath twosComplement:self.binaryLabel.text withWordSize:currentBitSize];
			self.decimalLabel.text = [BinaryMath twosComplementDecimalValue:self.signedLabel.text];
		}
		else {
			UIAlertView *tooLarge = [[UIAlertView alloc] initWithTitle:@"Number too large!" message:@"The number entered is too large for the current word size. Please try a smaller number or a larger word size." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[tooLarge show];
		}
	}
	else {
		self.binaryLabel.text = digit;
		self.signedLabel.text = [BinaryMath twosComplement:self.binaryLabel.text withWordSize:currentBitSize];
		self.decimalLabel.text = [BinaryMath twosComplementDecimalValue:self.signedLabel.text];
		self.middleOfNumber = YES;
	}
}

- (IBAction)clearPressed:(UIButton *)sender {
	self.binaryLabel.text = enterBinNum;
	self.decimalLabel.text = emptyString;
	self.signedLabel.text = emptyString;
	self.middleOfNumber = NO;
}

- (IBAction)deletePressed:(UIButton *)sender {
	// if the binary # actually exists
    if ([self.binaryLabel.text length] != 0) {
        if (![self.binaryLabel.text  isEqual: enterBinNum]) {
            NSMutableString *temp = [[NSMutableString alloc] initWithString:self.binaryLabel.text];
            [temp deleteCharactersInRange:NSMakeRange([temp length]-1, 1)];
            self.binaryLabel.text = temp;
			if ([BinaryMath validUnsignedNumber:self.binaryLabel.text withWordSize:currentBitSize]) {
				self.signedLabel.text = [BinaryMath twosComplement:self.binaryLabel.text withWordSize:currentBitSize];
				self.decimalLabel.text = [BinaryMath twosComplementDecimalValue:self.signedLabel.text];
			}
			else {
				UIAlertView *tooLarge = [[UIAlertView alloc] initWithTitle:@"Number too large!" message:@"The number entered is too large for the current word size. Please try a smaller number or a larger word size." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
				[tooLarge show];
			}
        }
    }
    // else deleting from an empty binary #
    else {
        self.binaryLabel.text = enterBinNum;
		self.signedLabel.text = emptyString;
		self.decimalLabel.text = emptyString;
        self.middleOfNumber = NO;
    }
    // if the binary # is now empty after delete
    if ([self.binaryLabel.text length] == 0) {
        self.binaryLabel.text = enterBinNum;
        self.decimalLabel.text = emptyString;
        self.signedLabel.text = emptyString;
        self.middleOfNumber = NO;
    }
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
	if (!self.middleOfNumber) {
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
	else {
		int testBitSize;
		if (currentBitSize == 8)
			testBitSize = 8;
		else
			testBitSize = currentBitSize - 8;
		
		NSLog(@"Valid? = %hhd",[BinaryMath validUnsignedNumber:self.binaryLabel.text withWordSize:testBitSize]);
		if ([self.binaryLabel.text length] > testBitSize || ![BinaryMath validUnsignedNumber:self.binaryLabel.text withWordSize:testBitSize]) {
			UIAlertView *tooManyDigits = [[UIAlertView alloc] initWithTitle:@"Too Many Digits" message:@"Currently entered unsigned binary number will be too large for a smaller word size. " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[tooManyDigits show];
		}
		else {
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
			self.signedLabel.text = [BinaryMath twosComplement:self.binaryLabel.text withWordSize:currentBitSize];
			self.decimalLabel.text = [BinaryMath twosComplementDecimalValue:self.signedLabel.text];
		}
	}
//	UIAlertView *tooLarge = [[UIAlertView alloc] initWithTitle:@"Number too large!" message:@"The number entered is too large for the current word size. Please try a smaller number or a larger word size." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//	[tooLarge show];

}
@end
