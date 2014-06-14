//
//  CompViewController.m
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "CompViewController.h"
#import "AppDelegate.h"
#import "B1naryIAPHelper.h"

@interface CompViewController ()

@end

@implementation CompViewController

@synthesize switchViewController, allViewControllers, currentViewController, containerView;

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
	
	self.view.backgroundColor = [UIColor colorWithRed:59/255.0f green:66/255.0f blue:65/255.0f alpha:1.0f];
	self.switchViewController.tintColor = defaultButtonColor;
//	
//	UIWindow* window = [[UIApplication sharedApplication] keyWindow];
//	UITabBarController *tabBarController = (UITabBarController *)window.rootViewController;
//	UITabBar *tabBar = tabBarController.tabBar;
//	tabBar.translucent = NO;
    
    // Create the score view controller
    AdditionViewController *additionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdditionViewController"];
    
    // Create the penalty view controller
    ComplementViewController *complementViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComplementViewController"];
    
    SignedViewController *signedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignedViewController"];
    
    // Add A and B view controllers to the array
    self.allViewControllers = [[NSArray alloc] initWithObjects:additionViewController, complementViewController, signedViewController, nil];
    
    // Ensure a view controller is loaded
    self.switchViewController.selectedSegmentIndex = 0;
    [self cycleFromViewController:self.currentViewController toViewController:[self.allViewControllers objectAtIndex:self.switchViewController.selectedSegmentIndex]];
	
	[self addIAPCover];
	//self.coverIAP.layer.zPosition = 1000;
	//self.coverIAP.alpha = 0.85;
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productNotPurchased:) name:IAPHelperProductFailedNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productRestoreFailed:) name:IAPHelperRestoreFailedNotification object:nil];
	
	[self checkForIAP];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
	NSLog(@"Purchased!");
	[self removePurchaseCover];
	[self checkForIAP];
	UIAlertView *success = [[UIAlertView alloc] initWithTitle:kPurchasedProTitle
													  message:kPurchasedProText
													 delegate:self
											cancelButtonTitle:kPurchasedProButton
											otherButtonTitles:nil];
	[success show];
}

- (void)productNotPurchased:(NSNotification *)notifcation {
	NSLog(@"Failed trans");
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

- (void)productRestoreFailed:(NSNotification *)notification {
	[self removePurchaseCover];
	NSError *error = notification.object;
	NSLog(@"failed with %@",error);
	if (error.code != SKErrorPaymentCancelled) {
		UIAlertView *failed = [[UIAlertView alloc] initWithTitle:@"Restore Failed"
														 message:[NSString stringWithFormat:@"Could not restore your past purchase(s). Received error: %@",error.localizedDescription]
														delegate:self
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil];
		[failed show];
	}
}

- (void)addPurchaseCover:(NSString *)type {
	UITabBarController *tabBar = self.tabBarController;
	CGRect rect = tabBar.view.frame;
	UIView *darkView = [[UIView alloc] initWithFrame:rect];
	darkView.backgroundColor = [UIColor blackColor];
	darkView.alpha = 0.85;
	darkView.tag = 99;
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, darkView.frame.size.height/2 -100, 200, 90)];
	[label setFont:[UIFont fontWithName:@"Verdana-Bold" size:26]];
	label.text = type;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addIAPCover {
	CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
	CGRect rect;
	if (iOSDeviceScreenSize.height == 480) {
		rect = CGRectMake(0, 0, 320, 431);
	} else {
		rect = CGRectMake(0, 0, 320, 519);
	}
	
	UIView *darkView = [[UIView alloc] initWithFrame:rect];
	darkView.backgroundColor = [UIColor blackColor];
	darkView.tag = 9999;
	darkView.alpha = 0.85;
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(40, 300, 240, 40);
	//button.backgroundColor = [UIColor clearColor];
//	[button setTitle:@"Purchase Upgrade" forState:UIControlStateNormal];
//	button.titleLabel.font = [UIFont fontWithName:@"Verdana" size:20];
//	button.titleLabel.textColor = defaultButtonColor;
	[button setImage:[UIImage imageNamed:@"upgrade"] forState:UIControlStateNormal];
	[button setImage:[UIImage imageNamed:@"upgradeSelected"] forState:UIControlStateHighlighted];
	[button addTarget:self action:@selector(purchaseTapped:) forControlEvents:UIControlEventTouchUpInside];
	//[button.titleLabel setTextColor:defaultButtonColor];
	button.alpha = 1.0;
	[darkView addSubview:button];
	
	UIButton *restore = [UIButton buttonWithType:UIButtonTypeCustom];
	restore.frame = CGRectMake(40, 350, 240, 40);
	//restore.backgroundColor = [UIColor clearColor];
//	[restore setTitle:@"Restore Past Purchase" forState:UIControlStateNormal];
//	restore.titleLabel.font = [UIFont fontWithName:@"Verdana" size:20];
//	restore.titleLabel.textColor = defaultButtonColor;
	[restore setImage:[UIImage imageNamed:@"restore"] forState:UIControlStateNormal];
	[restore setImage:[UIImage imageNamed:@"restoreSelected"] forState:UIControlStateHighlighted];
	[restore addTarget:self action:@selector(restoreTapped:) forControlEvents:UIControlEventTouchUpInside];
	//[button.titleLabel setTextColor:defaultButtonColor];
	restore.alpha = 1.0;
	[darkView addSubview:restore];
	
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 104, 280, 40)];
	title.text = [NSString stringWithFormat:@"Upgrade to pro for %@!",[B1naryIAPHelper getLocalizedPrice]];
	title.numberOfLines = 2;
	title.adjustsFontSizeToFitWidth = YES;
	title.font = [UIFont fontWithName:@"Verdana-Bold" size:19];
	title.backgroundColor = [UIColor clearColor];
	title.textColor = [UIColor whiteColor];
	title.textAlignment = NSTextAlignmentCenter;
	[darkView addSubview:title];
	
	UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(20, 152, 280, 106)];
	description.text = @"The pro upgrade unlocks binary addition, two's complement, the ability to save conversions, and the ability to email saved conversions as a text file.";
	description.font = [UIFont fontWithName:@"Verdana" size:17];
	description.backgroundColor = [UIColor clearColor];
	description.numberOfLines = 5;
	description.textColor = [UIColor whiteColor];
	description.textAlignment = NSTextAlignmentCenter;
	[darkView addSubview:description];
	
	[self.view addSubview:darkView];
}

- (void)checkForIAP {
	BOOL purchased = [[NSUserDefaults standardUserDefaults] boolForKey:proID];
	if (purchased) {
		[[self.view viewWithTag:9999] removeFromSuperview];
	}
}


#pragma mark - View controller switching and saving

- (void)cycleFromViewController:(UIViewController*)oldVC toViewController:(UIViewController*)newVC {
    
    // Do nothing if we are attempting to swap to the same view controller
    if (newVC == oldVC) return;
    
    // Check the newVC is non-nil otherwise expect a crash: NSInvalidArgumentException
    if (newVC) {
        
        // Set the new view controller frame (in this case to be the size of the available screen bounds)
        // Calulate any other frame animations here (e.g. for the oldVC)
        //newVC.view.frame = CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMinY(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
		CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
		if (iOSDeviceScreenSize.height == 480)
			newVC.view.frame = CGRectMake(0, 59, 320, 372); //480 old height, 241
		else
			newVC.view.frame = CGRectMake(0, 59, 320, 460); // 460
        // Check the oldVC is non-nil otherwise expect a crash: NSInvalidArgumentException
        if (oldVC) {
            
            // Start both the view controller transitions
            [oldVC willMoveToParentViewController:nil];
            [self addChildViewController:newVC];
            
            // Swap the view controllers
            // No frame animations in this code but these would go in the animations block
            [self transitionFromViewController:oldVC
                              toViewController:newVC
                                      duration:0.25
                                       options:UIViewAnimationOptionLayoutSubviews
                                    animations:^{}
                                    completion:^(BOOL finished) {
                                        // Finish both the view controller transitions
                                        [oldVC removeFromParentViewController];
                                        [newVC didMoveToParentViewController:self];
                                        // Store a reference to the current controller
                                        self.currentViewController = newVC;
                                    }];
            
        } else {
            
            // Otherwise we are adding a view controller for the first time
            // Start the view controller transition
            [self addChildViewController:newVC];
            
            // Add the new view controller view to the ciew hierarchy
            [self.view addSubview:newVC.view];
            
            // End the view controller transition
            [newVC didMoveToParentViewController:self];
            
            // Store a reference to the current controller
            self.currentViewController = newVC;
        }
    }
}

- (IBAction)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    
    NSUInteger index = sender.selectedSegmentIndex;
    
    if (UISegmentedControlNoSegment != index) {
        UIViewController *incomingViewController = [self.allViewControllers objectAtIndex:index];
        [self cycleFromViewController:self.currentViewController toViewController:incomingViewController];
    }
    
}

- (void)purchaseTapped:(UIButton *)sender {
	NSLog(@"Purchase tapped");
	[self addPurchaseCover:@"Purchasing..."];
	[[B1naryIAPHelper sharedInstance] buyProduct:[(AppDelegate *)[[UIApplication sharedApplication] delegate] getProduct]];
}

- (void)restoreTapped:(UIButton *)sender {
	NSLog(@"Restore tapped");
	[self addPurchaseCover:@"Restoring..."];
	[[B1naryIAPHelper sharedInstance] restoreCompletedTransactions];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
