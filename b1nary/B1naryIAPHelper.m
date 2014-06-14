//
//  B1naryIAPHelper.m
//  b1nary
//
//  Created by Michael Garza on 6/9/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "B1naryIAPHelper.h"

@implementation B1naryIAPHelper

+ (B1naryIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static B1naryIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"edu.self.garza.b1nary.pro",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
