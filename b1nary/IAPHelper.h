//
//  IAPHelper.h
//  b1nary
//
//  Created by Michael Garza on 6/9/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;
UIKIT_EXTERN NSString *const IAPHelperProductFailedNotification;
UIKIT_EXTERN NSString *const IAPHelperRestoreFailedNotification;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
// Add two new method declarations
- (void)buyProduct:(SKProduct *)product;
- (BOOL)productPurchased:(NSString *)productIdentifier;
+ (NSString *)getLocalizedPrice;
- (void)restoreCompletedTransactions;


@end
