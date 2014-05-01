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
	
	UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.savedScrollView.frame.size.width, 50)];
	leftLabel.textColor = [UIColor whiteColor];
	leftLabel.textAlignment = NSTextAlignmentCenter;
	leftLabel.text = @"Saved list!";
	
	self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0,50,self.savedScrollView.frame.size.width, 450)];
	self.textView.contentSize = CGSizeMake(self.savedScrollView.contentSize.width, self.savedScrollView.contentSize.height);
	self.textView.textColor = [UIColor whiteColor];
	self.textView.backgroundColor = [UIColor clearColor];
	self.textView.textAlignment = NSTextAlignmentLeft;
	self.textView.font = [UIFont fontWithName:@"Verdana" size:14];
	self.textView.scrollEnabled = NO;
	self.textView.userInteractionEnabled = NO;
	[self.savedScrollView addSubview:leftLabel];
	[self.savedScrollView addSubview:self.textView];
	
	UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.helpScrollView.frame.size.width, 50)];
	rightLabel.textColor = [UIColor whiteColor];
	rightLabel.textAlignment = NSTextAlignmentCenter;
	rightLabel.text = @"HELP & FAQ!";
	[self.helpScrollView addSubview:rightLabel];
	
	NSLog(@"Scrollview subviews = %@",self.mainScrollView.subviews);

	
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// Here you get access to the file in Documents directory of your application bundle.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [paths objectAtIndex:0];
	NSString *documentFile = [documentDir stringByAppendingPathComponent:@"saved.txt"];
	
	NSString *savedTextFromFile = [NSString stringWithContentsOfFile:documentFile encoding:NSUTF8StringEncoding error:nil];
	NSArray *array = [savedTextFromFile componentsSeparatedByString:@"\n"];
	NSLog(@"Array count = %d",[array count]);
	NSLog(@"Saved string = %@",savedTextFromFile);
	self.textView.text = savedTextFromFile;
	self.textView.frame = CGRectMake(0, 50, self.textView.frame.size.width, [array count]*17.5);
	self.savedScrollView.contentSize = CGSizeMake(self.savedScrollView.frame.size.width, [array count]*17.5);
	[self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
