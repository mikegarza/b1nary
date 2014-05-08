//
//  BinaryViewController.m
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "BinaryViewController.h"
#import "FromBinaryConversion.h"

@interface BinaryViewController () //<UITextViewDelegate>

@property (nonatomic) BOOL middleOfNumber;


@end

@implementation BinaryViewController

static NSString *enterBinNum = @"Enter A Binary Number";
static NSString *emptyString = @"";

@synthesize binaryLabel, decimalLabel, hexLabel, middleOfNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [FromBinaryConversion binaryToHex:@"1100010011100"];
    self.binaryLabel.adjustsFontSizeToFitWidth = YES;
    self.decimalLabel.adjustsFontSizeToFitWidth = YES;
    self.hexLabel.adjustsFontSizeToFitWidth = YES;
	
	UITapGestureRecognizer *tapGestureDecimal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyDecimal)];
	tapGestureDecimal.numberOfTapsRequired = 1;
	[self.decimalLabel addGestureRecognizer:tapGestureDecimal];
	
	UITapGestureRecognizer *tapGestureHex = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyHex)];
	tapGestureHex.numberOfTapsRequired = 1;
	[self.hexLabel addGestureRecognizer:tapGestureHex];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// 0 or 1 is pressed
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.middleOfNumber) {
        self.binaryLabel.text = [self.binaryLabel.text stringByAppendingString:digit];
        self.decimalLabel.text = [FromBinaryConversion binaryToDecimal:self.binaryLabel.text];
        self.hexLabel.text = [FromBinaryConversion binaryToHex:self.binaryLabel.text];
        [self.decimalLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
    }
    else {
        self.binaryLabel.text = digit;
        self.decimalLabel.text = [FromBinaryConversion binaryToDecimal:self.binaryLabel.text];
        self.hexLabel.text = [FromBinaryConversion binaryToHex:self.binaryLabel.text];
        [self.decimalLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
        self.middleOfNumber = YES;
    }
}

// clear button pressed
- (IBAction)clearPressed:(UIButton *)sender {
    self.middleOfNumber = NO;
    self.binaryLabel.text = enterBinNum;
    self.decimalLabel.text = emptyString;
    self.hexLabel.text = emptyString;
}

// delete pressed
- (IBAction)deletePressed:(UIButton *)sender {
    // if the binary # actually exists
    if ([self.binaryLabel.text length] != 0) {
        if (![self.binaryLabel.text  isEqual: enterBinNum]) {
            NSMutableString *temp = [[NSMutableString alloc] initWithString:self.binaryLabel.text];
            [temp deleteCharactersInRange:NSMakeRange([temp length]-1, 1)];
            NSString *finished = temp;
            self.binaryLabel.text = finished;
            self.decimalLabel.text = [FromBinaryConversion binaryToDecimal:self.binaryLabel.text];
            self.hexLabel.text = [FromBinaryConversion binaryToHex:self.binaryLabel.text];
            //self.middleOfNumber = YES;
            [self.binaryLabel setNeedsDisplay];
            [self.decimalLabel setNeedsDisplay];
            [self.hexLabel setNeedsDisplay];
        }
    }
    // else deleting from an empty binary #
    else {
        self.binaryLabel.text = enterBinNum;
        self.decimalLabel.text = emptyString;
        self.hexLabel.text = emptyString;
        [self.binaryLabel setNeedsDisplay];
        [self.decimalLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
        self.middleOfNumber = NO;
    }
    // if the binary # is now empty after delete
    if ([self.binaryLabel.text length] == 0) {
        self.binaryLabel.text = enterBinNum;
        self.decimalLabel.text = emptyString;
        self.hexLabel.text = emptyString;
        [self.binaryLabel setNeedsDisplay];
        [self.decimalLabel setNeedsDisplay];
        [self.hexLabel setNeedsDisplay];
        self.middleOfNumber = NO;
    }
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
	if ([self.binaryLabel.text isEqualToString:enterBinNum]) {
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
	
	if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
		NSLog(@"Writable");
	}else {
		NSLog(@"Not Writable");
	}
		
	
//	// Here you append new text to the existing one
//	NSString *textToFile = [textFromFile stringByAppendingString:savedString];
//	// Here you save the updated text to that file
//	[textToFile writeToFile:documentFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
//	if (error)
//		NSLog(@"Write to file error = %@",error);
//	
//	NSString *savedTextFromFile = [NSString stringWithContentsOfFile:documentFile encoding:NSUTF8StringEncoding error:nil];
//	NSLog(@"Text file = %@",savedTextFromFile);
	
}

//- (void)copy {
//	
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = @"String";
//}




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
		UIButton *temp = [[UIButton alloc] init];
		[temp setTitle:fixedString forState:UIControlStateNormal];
		[self clearPressed:nil];
		[self digitPressed:temp];
	}
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) copyDecimal {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.decimalLabel.text;
	NSLog(@"Copied %@",pasteboard.string);
}

- (void) copyHex {
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.hexLabel.text;
	NSLog(@"Copied %@",pasteboard.string);
}

@end
