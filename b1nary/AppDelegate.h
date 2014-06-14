//
//  AppDelegate.h
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
	NSArray *_products;
}

@property (strong, nonatomic) UIWindow *window;
- (SKProduct *)getProduct;

@end
