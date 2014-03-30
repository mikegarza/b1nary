//
//  FromBinaryConversion.m
//  b1nary
//
//  Created by Michael Garza on 1/26/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "FromBinaryConversion.h"

@implementation FromBinaryConversion

+ (NSString *) binaryToDecimal:(NSString *) binaryNum {
    int count = (int)[binaryNum length];     // length of binary number
    double exponent = 0.0;
    long long int total = 0;      // converted decimal number
    int digit;      // current digit in binary number
    double base = 2.0;   // binary base
    long long temp;
    //NSMutableString *converted = [[NSMutableString alloc] init ];
    
    while (count > 0) {
        digit = ((int)[binaryNum characterAtIndex: (count - 1)] - 48);
        NSLog(@"Digit is %i", digit);
        
        if (digit == 1) {
            temp = (long long int)pow(base,exponent);
            total += temp;
        }
        exponent += 1.0;
        count--;
    }
    NSLog(@"Converted = %lld",total);
    NSString *converted = [NSString stringWithFormat:@"%lld",total];
    return converted;
}

+ (NSString *) binaryToHex:(NSString *) binaryNum {
    NSMutableString *stringIn = [[NSMutableString alloc] initWithString:binaryNum];
    NSString *tempString = [[NSString alloc] init];
    NSMutableString *convertedString = [[NSMutableString alloc] init];
    
    // returns 0 if just a string of 0's
    long long int num = [binaryNum intValue];
    if (num == 0) {
        [convertedString appendString:@"0"];
        return convertedString;
    }
    
    // add leading zeroes for easier conversion
    while ((int)[stringIn length] % 4 != 0) {
        [stringIn insertString:@"0" atIndex:0];
    }
    // size of binary # passed
    int count = (int)[stringIn length];
    NSLog(@"Buffered hex = %@",stringIn);
    
    int strCounter = 4;                 // used to get groups of 4 binary #s
    NSRange range = NSMakeRange(0,4);   // range for the first 4 digits
    
    while (count > 0) {
        tempString = [stringIn substringToIndex:strCounter];
        [stringIn deleteCharactersInRange:range];
        
        if ([tempString isEqualToString:@"0000"]) {
            [convertedString appendString:@"0"];
        }
        else if ([tempString isEqualToString:@"0001"]) {
            [convertedString appendString:@"1"];
        }
        else if ([tempString isEqualToString:@"0010"]) {
            [convertedString appendString:@"2"];
        }
        else if ([tempString isEqualToString:@"0011"]) {
            [convertedString appendString:@"3"];
        }
        else if ([tempString isEqualToString:@"0100"]) {
            [convertedString appendString:@"4"];
        }
        else if ([tempString isEqualToString:@"0101"]) {
            [convertedString appendString:@"5"];
        }
        else if ([tempString isEqualToString:@"0110"]) {
            [convertedString appendString:@"6"];
        }
        else if ([tempString isEqualToString:@"0111"]) {
            [convertedString appendString:@"7"];
        }
        else if ([tempString isEqualToString:@"1000"]) {
            [convertedString appendString:@"8"];
        }
        else if ([tempString isEqualToString:@"1001"]) {
            [convertedString appendString:@"9"];
        }
        else if ([tempString isEqualToString:@"1010"]) {
            [convertedString appendString:@"A"];
        }
        else if ([tempString isEqualToString:@"1011"]) {
            [convertedString appendString:@"B"];
        }
        else if ([tempString isEqualToString:@"1100"]) {
            [convertedString appendString:@"C"];
        }
        else if ([tempString isEqualToString:@"1101"]) {
            [convertedString appendString:@"D"];
        }
        else if ([tempString isEqualToString:@"1110"]) {
            [convertedString appendString:@"E"];
        }
        else if ([tempString isEqualToString:@"1111"]) {
            [convertedString appendString:@"F"];
        }
        
        count -= 4;
    }
    NSLog(@"Hex = %@",convertedString);
    return (NSString*)convertedString;
}

@end
