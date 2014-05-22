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
    //[FromHexConversion hexToBinary:@"B5F"];
    //[FromHexConversion hexToDecimal:@"B5F"];
	UITapGestureRecognizer *tapGestureBinary = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyBinary)];
	tapGestureBinary.numberOfTapsRequired = 1;
	[self.binaryLabel addGestureRecognizer:tapGestureBinary];
	
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
		if (!([self.hexLabel.text length] >= 8)) {
			self.hexLabel.text = [self.hexLabel.text stringByAppendingString:digit];
			self.binaryLabel.text = [FromHexConversion hexToBinary:self.hexLabel.text];
			self.decimalLabel.text = [FromHexConversion hexToDecimal:self.hexLabel.text];
			[self.binaryLabel setNeedsDisplay];
			[self.decimalLabel setNeedsDisplay];
		}
		else {
			UIAlertView *capacity = [[UIAlertView alloc] initWithTitle:@"At Capacity" message:@"The number is already at the maximum number of hexadecimal digits: 8" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[capacity show];
		}
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

- (IBAction)saveButtonPressed:(UIButton *)sender {
	if ([self.hexLabel.text isEqualToString:enterHexNum]) {
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
	NSString *fixedString = [FromHexConversion hexDigits:string];
	if (!fixedString) {
		UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Pasted number is not a valid hexdecimal number or is too large." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[invalid show];
	}
	else {
		NSString *intFixedString = [FromHexConversion hexToDecimal:fixedString];
	
		if ([intFixedString longLongValue] > 4294967295 || [fixedString isEqualToString:@""]) {
			UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Pasted number is not a valid hexdecimal number or is too large." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
			[invalid show];
		}
		else {
			UIButton *temp = [[UIButton alloc] init];
			[temp setTitle:fixedString forState:UIControlStateNormal];
			[self clearPressed:nil];
			[self digitPressed:temp];
		}
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

- (void) copyDecimal {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.decimalLabel.text;
	NSLog(@"Copied %@",pasteboard.string);
	
	[UIView animateWithDuration:0.3 animations:^{
		self.decimalLabel.alpha = 0.0;
	} completion:^(BOOL finished) {
		self.decimalLabel.alpha = 1.0;
	}];
}

@end
