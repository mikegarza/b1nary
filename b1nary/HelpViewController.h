//
//  HelpViewController.h
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface HelpViewController : UIViewController <MFMailComposeViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIScrollView *savedScrollView;
@property (nonatomic,strong) UIScrollView *helpScrollView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *emailConversionButton;
@property (strong, nonatomic) IBOutlet UIButton *emailMeButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIView *faqView;
@property (strong, nonatomic) IBOutlet UILabel *contactMeLabel;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)deletePressed:(UIButton *)sender;
- (IBAction)emailSaved:(UIButton *)sender;
- (IBAction)emailSupport:(UIButton *)sender;


@end
