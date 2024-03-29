//
//  BinaryMath.h
//  b1nary
//
//  Created by Michael Garza on 2/14/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryMath : NSObject

+ (NSString *) binaryAddition:(NSString *)firstNum withSecondNumber:(NSString *)secondNum;
+ (NSString *) twosComplement:(NSString *)binaryNum withWordSize:(int)wordSize;
+ (NSString *) twosComplementDecimalValue:(NSString *)binaryNum;
+ (BOOL) validUnsignedNumber:(NSString *)binaryNum withWordSize:(int)wordSize;


@end
