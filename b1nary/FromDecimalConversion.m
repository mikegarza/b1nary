//
//  FromDecimalConversion.m
//  b1nary
//
//  Created by Michael Garza on 1/31/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "FromDecimalConversion.h"

@implementation FromDecimalConversion

+ (NSString *) decimalToBinary:(NSString *) decimalNum {
    //int exponent = 0;
    //int count = (int)[decimalNum length];
    long long int temp = [decimalNum longLongValue];
    long long int remainder;
    NSMutableString *converted = [[NSMutableString alloc] init];
    NSMutableString *finalConverted = [[NSMutableString alloc] init];
    
    // returns 0 if just a string of 0's
    if (temp == 0) {
        [finalConverted appendString:@"0"];
        return finalConverted;
    }
    while (temp !=0) {
        remainder = temp % 2;
        temp = temp / 2;
        if (remainder == 0)
            [converted appendString:@"0"];
        else 
            [converted appendString:@"1"];
        
    }
    NSString *tempString = @"";             // string used during reversing the converted #
    unichar theChar;                        // used for creating a temp string
    for (int x = (int)[converted length]; x > 0; x--) {
        theChar = [converted characterAtIndex:x-1];
        tempString = [NSString stringWithCharacters:&theChar length:1];
        [finalConverted appendString:tempString];
    }
    NSLog(@"The backwards binary num: %@", converted);
    NSLog(@"The converted binary num: %@", finalConverted);
    return finalConverted;
}
+ (NSString *) decimalToHex:(NSString *) decimalNum {
    long long int temp = [decimalNum longLongValue];
    long long int remainder;
    NSMutableString *converted = [[NSMutableString alloc] init];
    NSMutableString *finalConverted = [[NSMutableString alloc] init];
    
    // returns 0 if just a string of 0's
    if (temp == 0) {
        [finalConverted appendString:@"0"];
        return finalConverted;
    }
    
    while (temp != 0) {
        remainder = temp % 16;
        temp = temp / 16;
        if (remainder < 10)
            [converted appendString:[NSString stringWithFormat:@"%lld", remainder]];
        else if (remainder == 10)
            [converted appendString:@"A"];
        else if (remainder == 11)
            [converted appendString:@"B"];
        else if (remainder == 12)
            [converted appendString:@"C"];
        else if (remainder == 13)
            [converted appendString:@"D"];
        else if (remainder == 14)
            [converted appendString:@"E"];
        else if (remainder == 15)
            [converted appendString:@"F"];
    }
    NSString *tempString = @"";             // string used during reversing the converted #
    unichar theChar;                        // used for creating a temp string
    for (int x = (int)[converted length]; x > 0; x--) {
        theChar = [converted characterAtIndex:x-1];
        tempString = [NSString stringWithCharacters:&theChar length:1];
        [finalConverted appendString:tempString];
    }
    
    return finalConverted;
}

@end

