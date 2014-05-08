//
//  ComplementViewController.m
//  b1nary
//
//  Created by Michael Garza on 2/7/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "ComplementViewController.h"
#import "BinaryMath.h"
#import "FromBinaryConversion.h"

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
	
	//[BinaryMath twosComplement:@"10010" withWordSize:8];
	//[BinaryMath twosComplement:@"11111" withWordSize:8];
	//[BinaryMath twosComplementDecimalValue:@"00000000"];
	
	UITapGestureRecognizer *tapGestureBinary = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyBinary)];
	tapGestureBinary.numberOfTapsRequired = 1;
	[self.signedLabel addGestureRecognizer:tapGestureBinary];
	
	UITapGestureRecognizer *tapGestureDecimal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyDecimal)];
	tapGestureDecimal.numberOfTapsRequired = 1;
	[self.decimalLabel addGestureRecognizer:tapGestureDecimal];
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

- (IBAction)saveButtonPressed:(UIButton *)sender {
	if ([self.binaryLabel.text isEqualToString:enterBinNum]) {
		UIAlertView *nothingToSave = [[UIAlertView alloc] initWithTitle:@"Nothing To Save" message:@"No conversion to save." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[nothingToSave show];
		return;
		
	}
	NSString *savedString = [NSString stringWithFormat:@"B: %@\n-: %@\nD: %@\n\n",self.binaryLabel.text,self.signedLabel.text,self.decimalLabel.text];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"saved.txt"];
	NSLog(@"filePath %@", filePath);
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) { // if file is not exist, create it.
		NSError *error;
		[savedString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
	}
	else {
		NSError *error;
		NSString *textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
		NSString *newString = [textFromFile stringByAppendingString:savedString];
		[newString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
	}
}

- (IBAction)pasteButtonPressed:(UIButton *)sender {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	NSString *string = pasteboard.string;
	NSLog(@"%@",string);
	NSString *fixedString = [FromBinaryConversion binaryDigits:string];
	
	if ([fixedString length] > 32 || [fixedString isEqualToString:@""]) {
		UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Pasted number is not a valid binary number or is larger than 32 bits." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[invalid show];
	}
	else {
		if ([BinaryMath validUnsignedNumber:fixedString withWordSize:currentBitSize]) {
			UIButton *temp = [[UIButton alloc] init];
			[temp setTitle:fixedString forState:UIControlStateNormal];
			[self clearPressed:nil];
			[self digitPressed:temp];
		}
		else {
			UIAlertView *tooLarge = [[UIAlertView alloc] initWithTitle:@"Number too large!" message:@"The number pasted is too large for the current word size. Please try a smaller number or a larger word size." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[tooLarge show];
		}
	}
}

- (void) copyBinary {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.signedLabel.text;
	NSLog(@"Copied %@",pasteboard.string);
}

- (void) copyDecimal {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.decimalLabel.text;
	NSLog(@"Copied %@",pasteboard.string);
}
@end
