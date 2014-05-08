//
//  HelpViewController.m
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor colorWithRed:28/255.0f green:191/255.0f blue:170/255.0f alpha:1.0f];
	CGRect rect = CGRectMake(0, 69, 320, 450);
	self.mainScrollView = [[UIScrollView alloc] initWithFrame:rect];
	self.mainScrollView.contentSize = CGSizeMake(640,self.mainScrollView.frame.size.height);
	self.mainScrollView.pagingEnabled = YES;
	self.mainScrollView.userInteractionEnabled = YES;
	
	self.savedScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 450)];
	self.savedScrollView.contentSize = CGSizeMake(self.savedScrollView.frame.size.width, 450);
	[self.mainScrollView addSubview:self.savedScrollView];
	
//	UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, 450)];
//	rightView.backgroundColor = [UIColor blackColor];
//	[self.scrollView addSubview:rightView];
	
	self.helpScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(320, 0, 320, 450)];
	self.helpScrollView.contentSize = CGSizeMake(self.helpScrollView.frame.size.width, 100);
	[self.mainScrollView addSubview:self.helpScrollView];
	
	[self.view addSubview:self.mainScrollView];
	
//	UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.savedScrollView.frame.size.width, 50)];
//	leftLabel.textColor = [UIColor whiteColor];
//	leftLabel.textAlignment = NSTextAlignmentCenter;
//	leftLabel.text = @"Saved list!";
	
	self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0,0,self.savedScrollView.frame.size.width, 450)];
	self.textView.contentSize = CGSizeMake(self.savedScrollView.contentSize.width, self.savedScrollView.contentSize.height);
	self.textView.textColor = [UIColor whiteColor];
	self.textView.backgroundColor = [UIColor clearColor];
	self.textView.textAlignment = NSTextAlignmentLeft;
	self.textView.font = [UIFont fontWithName:@"Verdana" size:14];
	self.textView.scrollEnabled = NO;
	self.textView.userInteractionEnabled = YES;
	self.textView.editable = NO;
	//[self.savedScrollView addSubview:leftLabel];
	[self.savedScrollView addSubview:self.textView];
	
//	UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.helpScrollView.frame.size.width, 50)];
//	rightLabel.textColor = [UIColor whiteColor];
//	rightLabel.textAlignment = NSTextAlignmentCenter;
//	rightLabel.text = @"HELP & FAQ!";
//	[self.helpScrollView addSubview:rightLabel];
	
	NSLog(@"Scrollview subviews = %@",self.mainScrollView.subviews);

	
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// Here you get access to the file in Documents directory of your application bundle.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [paths objectAtIndex:0];
	NSString *documentFile = [documentDir stringByAppendingPathComponent:@"saved.txt"];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:documentFile]) {
		NSLog(@"Document found");
		NSString *savedTextFromFile = [NSString stringWithContentsOfFile:documentFile encoding:NSUTF8StringEncoding error:nil];
		NSArray *array = [savedTextFromFile componentsSeparatedByString:@"\n"];
		NSLog(@"Array count = %d",[array count]);
		NSLog(@"Saved string = %@",savedTextFromFile);
		self.textView.text = savedTextFromFile;
		self.textView.frame = CGRectMake(0, 0, self.textView.frame.size.width, [array count]*18);
		self.savedScrollView.contentSize = CGSizeMake(self.savedScrollView.frame.size.width, [array count]*18);
	}
	else
		self.textView.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
	if (action == @selector(paste:))
		return NO;
	return [super canPerformAction:action withSender:sender];
}

- (IBAction)deletePressed:(UIButton *)sender {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"saved.txt"];
	NSLog(@"filePath %@", filePath);
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) { // if file is not exist, create it.
		NSError *error;
		[[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
		NSLog(@"Error deleting = %@", error);
		//[self.textView setNeedsDisplay];
		[self viewWillAppear:YES];
	}
	else {
		UIAlertView *noFile = [[UIAlertView alloc] initWithTitle:@"Nothing To Delete" message:@"No conversion history saved. Nothing was deleted." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[noFile show];
	}
}

- (IBAction)sendConversionPressed:(UIButton *)sender {
}

- (IBAction)emailSaved:(UIButton *)sender {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [paths objectAtIndex:0];
	NSString *documentFile = [documentDir stringByAppendingPathComponent:@"saved.txt"];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:documentFile]) {
		UIAlertView *noFile = [[UIAlertView alloc] initWithTitle:@"Nothing To Email" message:@"No conversion history saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[noFile show];
	}
	else {
		if ([MFMailComposeViewController canSendMail]) {
			//NSArray *toRecipents = [NSArray arrayWithObject:@"stem@csusm.edu"];
			
			MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
			mc.mailComposeDelegate = self;
			[mc setSubject:@"b1nary conversions"];
			//[mc setMessageBody:messageBody isHTML:NO];
			//[mc setToRecipients:toRecipents];
			
			NSData *data = [NSData dataWithContentsOfFile:documentFile];
			[mc addAttachmentData:data mimeType:@"text/plain" fileName:@"b1nary"];
			
			// Present mail view controller on screen
			[self presentViewController:mc animated:YES completion:NULL];
		}
		else {
			UIAlertView *connectionFailed = [[UIAlertView alloc] initWithTitle:@"E-mail Error" message:@"No functioning e-mail account found." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[connectionFailed show];
		}
	}
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
