//
//  AdditionViewController.m
//  b1nary
//
//  Created by Michael Garza on 2/7/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "AdditionViewController.h"
#import "BinaryMath.h"
#import "FromBinaryConversion.h"

@interface AdditionViewController ()

@property (nonatomic) BOOL middleOfFirstNumber;
@property (nonatomic) BOOL middleOfSecondNumber;
@property (nonatomic) BOOL onFirstNumber;
@property (nonatomic) BOOL iPhone4;

@property (nonatomic) UIView *selectedNumberBorder;

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
	
	CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
	if (iOSDeviceScreenSize.height == 480)
		self.iPhone4 = YES;
	else
		self.iPhone4 = NO;
	
	// Do any additional setup after loading the view.
    self.middleOfFirstNumber = NO;
    self.middleOfSecondNumber = NO;
    self.onFirstNumber = YES;
	
	self.firstBinaryLabel.adjustsFontSizeToFitWidth = YES;
	self.secondBinaryLabel.adjustsFontSizeToFitWidth = YES;
	self.totalLabel.adjustsFontSizeToFitWidth = YES;
	
	CGRect rect;
	if (self.iPhone4)
		rect = CGRectMake(30, 18, 284, 26);
	else
		rect = CGRectMake(30, 20, 284, 36);
	self.selectedNumberBorder = [[UIView alloc] initWithFrame:rect];
	self.selectedNumberBorder.backgroundColor = [UIColor clearColor];
	self.selectedNumberBorder.layer.borderWidth = 0.5;
	self.selectedNumberBorder.layer.cornerRadius = 5.0;
	self.selectedNumberBorder.layer.borderColor = [UIColor whiteColor].CGColor;
	[self.view addSubview:self.selectedNumberBorder];
	
	UITapGestureRecognizer *tapGestureBinary = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyBinary)];
	tapGestureBinary.numberOfTapsRequired = 1;
	[self.totalLabel addGestureRecognizer:tapGestureBinary];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    // if inserting the first binary number
    if (self.onFirstNumber) {
        // if currently entering a number
        if (self.middleOfFirstNumber) {
			if (!([self.firstBinaryLabel.text length] >= 32)) {
				self.firstBinaryLabel.text = [self.firstBinaryLabel.text stringByAppendingString:digit];
				// if there are two valid numbers, do the addition
				if ([self twoValidNumbers]) {
					self.totalLabel.text = [BinaryMath binaryAddition:self.firstBinaryLabel.text withSecondNumber:self.secondBinaryLabel.text];
					[self.totalLabel setNeedsDisplay];
				}
			}
			else {
				UIAlertView *capacity = [[UIAlertView alloc] initWithTitle:@"At Capacity" message:@"Number is already at the maximum number of bits : 32" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[capacity show];
				
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
			if (!([self.secondBinaryLabel.text length] >= 32)) {
				self.secondBinaryLabel.text = [self.secondBinaryLabel.text stringByAppendingString:digit];
				// if two valid numbers, do the addition
				if ([self twoValidNumbers]) {
					self.totalLabel.text = [BinaryMath binaryAddition:self.firstBinaryLabel.text withSecondNumber:self.secondBinaryLabel.text];
					[self.totalLabel setNeedsDisplay];
				}
			}
			else {
				UIAlertView *capacity = [[UIAlertView alloc] initWithTitle:@"At Capacity" message:@"Number is already at the maximum number of bits : 32" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[capacity show];
				
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
    if (self.onFirstNumber) {
        self.onFirstNumber = NO;
		[UIView animateWithDuration:0.3 animations:^{
			if (self.iPhone4)
				self.selectedNumberBorder.frame = CGRectMake(self.selectedNumberBorder.frame.origin.x, self.selectedNumberBorder.frame.origin.y+29,self.selectedNumberBorder.frame.size.width, self.selectedNumberBorder.frame.size.height);
			else
				self.selectedNumberBorder.frame = CGRectMake(self.selectedNumberBorder.frame.origin.x, self.selectedNumberBorder.frame.origin.y+40, self.selectedNumberBorder.frame.size.width, self.selectedNumberBorder.frame.size.height);
		}];
	}
    else {
        self.onFirstNumber = YES;
		[UIView animateWithDuration:0.3 animations:^{
			if (self.iPhone4)
				self.selectedNumberBorder.frame = CGRectMake(self.selectedNumberBorder.frame.origin.x, self.selectedNumberBorder.frame.origin.y-29, self.selectedNumberBorder.frame.size.width, self.selectedNumberBorder.frame.size.height);
			else
				self.selectedNumberBorder.frame = CGRectMake(self.selectedNumberBorder.frame.origin.x, self.selectedNumberBorder.frame.origin.y-40, self.selectedNumberBorder.frame.size.width, self.selectedNumberBorder.frame.size.height);
		}];
	}
}

- (IBAction)clearAllPressed:(UIButton *)sender {
    self.middleOfFirstNumber = NO;
    self.middleOfSecondNumber = NO;
    self.onFirstNumber = YES;
    self.firstBinaryLabel.text = enterFirstBinNum;
    self.secondBinaryLabel.text = enterSecondBinNum;
    self.totalLabel.text = emptyString;
	
	CGRect borderOrigin;
	
	if (self.iPhone4)
		borderOrigin = CGRectMake(30, 18, 284, 26);
	else
		borderOrigin = CGRectMake(30, 20, 284, 36);
	self.selectedNumberBorder.frame = borderOrigin;
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
	if ([self.firstBinaryLabel.text isEqualToString:enterFirstBinNum] || [self.secondBinaryLabel.text isEqualToString:enterSecondBinNum]) {
		UIAlertView *nothingToSave = [[UIAlertView alloc] initWithTitle:@"Nothing To Save" message:@"There is no sum to save." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[nothingToSave show];
		return;
		
	}
	NSString *savedString = [NSString stringWithFormat:@"  %@\n+ %@\n  %@\n\n",self.firstBinaryLabel.text,self.secondBinaryLabel.text,self.totalLabel.text];
	
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
	NSString *fixedString;
	if (string)
		fixedString = [FromBinaryConversion binaryDigits:string];
	else
		fixedString = @"";
	
	if ([fixedString length] > 32 || [fixedString isEqualToString:@""]) {
		UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Pasted number is not a valid binary number or is larger than 32 bits." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[invalid show];
	}
	else {
		UIButton *temp = [[UIButton alloc] init];
		[temp setTitle:fixedString forState:UIControlStateNormal];
		[self clearPressed:nil];
		[self digitPressed:temp];
	}
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

- (void) copyBinary {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.totalLabel.text;
	NSLog(@"Copied %@",pasteboard.string);
	
	[UIView animateWithDuration:0.3 animations:^{
		self.totalLabel.alpha = 0.0;
	} completion:^(BOOL finished) {
		self.totalLabel.alpha = 1.0;
	}];
}
@end
