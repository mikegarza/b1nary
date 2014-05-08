//
//  FromHexConversion.h
//  b1nary
//
//  Created by Michael Garza on 2/4/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FromHexConversion : NSObject

+ (NSString *) hexToBinary:(NSString *) hexNum;
+ (NSString *) hexToDecimal:(NSString *) hexNum;
+ (NSString *) hexDigits:(NSString *) hexNum;


@end
