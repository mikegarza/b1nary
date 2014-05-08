//
//  HelpViewController.h
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface HelpViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIScrollView *savedScrollView;
@property (nonatomic,strong) UIScrollView *helpScrollView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *emailConversionButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)deletePressed:(UIButton *)sender;
- (IBAction)sendConversionPressed:(UIButton *)sender;
- (IBAction)emailSaved:(UIButton *)sender;


@end
