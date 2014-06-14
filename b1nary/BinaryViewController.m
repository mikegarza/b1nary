//
//  BinaryViewController.m
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "BinaryViewController.h"
#import "FromBinaryConversion.h"
#import "B1naryIAPHelper.h"
#import "AppDelegate.h"

@interface BinaryViewController () <UIAlertViewDelegate> {
	NSArray *_products;
}

@property (nonatomic) BOOL middleOfNumber;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;


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
	
//	_products = nil;
//    [[B1naryIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
//        if (success) {
//            _products = products;
//			NSLog(@"products = %@",_products);
//        }
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	BOOL purchased = [[NSUserDefaults standardUserDefaults] boolForKey:proID];
	if (purchased) {
		self.saveButton.alpha = 1.0;
	} else {
		self.saveButton.alpha = 0.3;
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productNotPurchased:) name:IAPHelperProductFailedNotification object:nil];
	
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
	NSLog(@"Purchased!");
	[self removePurchaseCover];
	UIAlertView *success = [[UIAlertView alloc] initWithTitle:kPurchasedProTitle
													  message:kPurchasedProText
													 delegate:self
											cancelButtonTitle:kPurchasedProButton
											otherButtonTitles:nil];
	[success show];
	
	self.saveButton.alpha = 1.0;
	
}

- (void)productNotPurchased:(NSNotification *)notifcation {
	SKPaymentTransaction *trans = notifcation.object;
	[self removePurchaseCover];
	if (trans.error.code != SKErrorPaymentCancelled) {
		UIAlertView *failed = [[UIAlertView alloc] initWithTitle:kFailedProTitle
														 message:[NSString stringWithFormat:kFailedProText,trans.error.localizedDescription]
														delegate:self
											   cancelButtonTitle:kFailedProButton
											   otherButtonTitles:nil];
		[failed show];
	}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// 0 or 1 is pressed
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
		if (self.middleOfNumber) {
			if (!([self.binaryLabel.text length] >= 32)) {
				self.binaryLabel.text = [self.binaryLabel.text stringByAppendingString:digit];
				self.decimalLabel.text = [FromBinaryConversion binaryToDecimal:self.binaryLabel.text];
				self.hexLabel.text = [FromBinaryConversion binaryToHex:self.binaryLabel.text];
				[self.decimalLabel setNeedsDisplay];
				[self.hexLabel setNeedsDisplay];
			}
			else {
				UIAlertView *capacity = [[UIAlertView alloc] initWithTitle:@"At Capacity" message:@"Number is already at the maximum number of bits : 32" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[capacity show];

			}
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
	BOOL purchased = [[NSUserDefaults standardUserDefaults] boolForKey:proID];
	
	if (purchased) {
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
	} else {
		UIAlertView *requiresPro = [[UIAlertView alloc] initWithTitle:kRequiresProTitle
															  message:[NSString stringWithFormat:kRequiresProText,[B1naryIAPHelper getLocalizedPrice]]
															 delegate:self
													cancelButtonTitle:kRequiresProPurchaseCancel
													otherButtonTitles:kRequiresProPurchaseButton, nil];
		[requiresPro show];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([alertView.title isEqualToString:kRequiresProTitle]) {
		if (buttonIndex == 1) {
			// purchase code here
			[self addPurchaseCover];
			[[B1naryIAPHelper sharedInstance] buyProduct:[(AppDelegate *)[[UIApplication sharedApplication] delegate] getProduct]];
		}
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

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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

- (void)addPurchaseCover {
	UITabBarController *tabBar = self.tabBarController;
	CGRect rect = tabBar.view.frame;
	UIView *darkView = [[UIView alloc] initWithFrame:rect];
	darkView.backgroundColor = [UIColor blackColor];
	darkView.alpha = 0.85;
	darkView.tag = 99;
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, darkView.frame.size.height/2 -100, 200, 90)];
	[label setFont:[UIFont fontWithName:@"Verdana-Bold" size:26]];
	label.text = @"Purchasing...";
	label.textColor = [UIColor whiteColor];
	label.textAlignment = NSTextAlignmentCenter;
	[darkView addSubview:label];
	
	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	spinner.frame = CGRectMake(135, darkView.frame.size.height/2 + 10, 50, 50);
	[darkView addSubview:spinner];
	[spinner startAnimating];
	
	[tabBar.view addSubview:darkView];
	
	tabBar.view.userInteractionEnabled = NO;
}

- (void)removePurchaseCover {
	UITabBarController *tabBar = self.tabBarController;
	[[tabBar.view viewWithTag:99] removeFromSuperview];
	tabBar.view.userInteractionEnabled = YES;
}

@end
