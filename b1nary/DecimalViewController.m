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
    self.binaryLabel.adjustsFontSizeToFitWidth = YES;
    self.decimalLabel.adjustsFontSizeToFitWidth = YES;
    self.hexLabel.adjustsFontSizeToFitWidth = YES;
	// Do any additional setup after loading the view, typically from a nib.
    //[FromDecimalConversion decimalToBinary:@"164"];
	UITapGestureRecognizer *tapGestureBinary = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyBinary)];
	tapGestureBinary.numberOfTapsRequired = 1;
	[self.binaryLabel addGestureRecognizer:tapGestureBinary];
	
	UITapGestureRecognizer *tapGestureHex = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyHex)];
	tapGestureHex.numberOfTapsRequired = 1;
	[self.hexLabel addGestureRecognizer:tapGestureHex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
	NSString *check = [self.decimalLabel.text stringByAppendingString:digit];
	if (!([check longLongValue] > 4294967295)) {
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
	else {
		UIAlertView *capacity = [[UIAlertView alloc] initWithTitle:@"Too Large" message:@"The converted number will be larger than the maximum decimal number: 4294967295" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[capacity show];
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

- (IBAction)saveButtonPressed:(UIButton *)sender {
	if ([self.decimalLabel.text isEqualToString:enterDecNum]) {
		UIAlertView *nothingToSave = [[UIAlertView alloc] initWithTitle:@"Nothing To Save" message:@"No conversion to save." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[nothingToSave show];
		return;
		
	}
	NSString *savedString = [NSString stringWithFormat:@"B: %@\nD: %@\nH: %@\n\n",self.binaryLabel.text,self.decimalLabel.text,self.hexLabel.text];
	
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
		fixedString = [FromDecimalConversion decimalDigits:string];
	else
		fixedString = @"";
	
	if ([fixedString longLongValue] > 4294967295 || [fixedString isEqualToString:@""]) {
		UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Pasted number is not a valid decimal number or is too large." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[invalid show];
	}
	else {
		UIButton *temp = [[UIButton alloc] init];
		[temp setTitle:fixedString forState:UIControlStateNormal];
		[self clearPressed:nil];
		[self digitPressed:temp];
	}
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) copyBinary {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.binaryLabel.text;
	NSLog(@"Copied %@",pasteboard.string);
	[UIView animateWithDuration:0.3 animations:^{
		self.binaryLabel.alpha = 0.0;
	} completion:^(BOOL finished) {
		self.binaryLabel.alpha = 1.0;
	}];
}

- (void) copyHex {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.hexLabel.text;
	NSLog(@"Copied %@",pasteboard.string);
	[UIView animateWithDuration:0.3 animations:^{
		self.hexLabel.alpha = 0.0;
	} completion:^(BOOL finished) {
		self.hexLabel.alpha = 1.0;
	}];
}

@end
