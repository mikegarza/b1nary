//
//  FromBinaryConversion.h
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FromBinaryConversion : NSObject

+ (NSString *) binaryToDecimal:(NSString *) binaryNum;
+ (NSString *) binaryToHex:(NSString *) binaryNum;

@end
