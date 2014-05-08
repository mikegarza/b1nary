//
//  FromDecimalConversion.h
//  b1nary
//
//  Created by Michael Garza on 1/31/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FromDecimalConversion : NSObject

+ (NSString *) decimalToBinary:(NSString *) decimalNum;
+ (NSString *) decimalToHex:(NSString *) decimalNum;
+ (NSString *) decimalDigits:(NSString *) decimalNum;


@end
