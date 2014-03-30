//
//  FromHexConversion.m
//  b1nary
//
//  Created by Michael Garza on 2/4/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "FromHexConversion.h"

@implementation FromHexConversion

+ (NSString *) hexToBinary:(NSString *) hexNum {
    int count = (int)[hexNum length];   // length of #
    NSString * tempString = [[NSString alloc] init]; // holds an indiv hex digit
    NSMutableString *stringIn = [[NSMutableString alloc] initWithString:hexNum]; // copy of the hex # param
    NSMutableString *converted = [[NSMutableString alloc] init]; // will hold final converted decimal #
    NSRange range = NSMakeRange(0, 1); // range for deleting the first digit
    
    // while still digits in hex #
    while (count > 0) {
        tempString = [stringIn substringToIndex:1];
        [stringIn deleteCharactersInRange:range];
        
        // chain compares hex digit and appends binary equiv
        if ([tempString isEqualToString:@"0"])
            [converted appendString:@"0000"];
        else if([tempString isEqualToString:@"1"])
            [converted appendString:@"0001"];
        else if([tempString isEqualToString:@"2"])
            [converted appendString:@"0010"];
        else if([tempString isEqualToString:@"3"])
            [converted appendString:@"0011"];
        else if([tempString isEqualToString:@"4"])
            [converted appendString:@"0100"];
        else if([tempString isEqualToString:@"5"])
            [converted appendString:@"0101"];
        else if([tempString isEqualToString:@"6"])
            [converted appendString:@"0110"];
        else if([tempString isEqualToString:@"7"])
            [converted appendString:@"0111"];
        else if([tempString isEqualToString:@"8"])
            [converted appendString:@"1000"];
        else if([tempString isEqualToString:@"9"])
            [converted appendString:@"1001"];
        else if([tempString isEqualToString:@"A"])
            [converted appendString:@"1010"];
        else if([tempString isEqualToString:@"B"])
            [converted appendString:@"1011"];
        else if([tempString isEqualToString:@"C"])
            [converted appendString:@"1100"];
        else if([tempString isEqualToString:@"D"])
            [converted appendString:@"1101"];
        else if([tempString isEqualToString:@"E"])
            [converted appendString:@"1110"];
        else if([tempString isEqualToString:@"F"])
            [converted appendString:@"1111"];
        
        count--;
    }
    NSLog(@"Bin = %@",converted);
    return (NSString*)converted;
}
+ (NSString *) hexToDecimal:(NSString *) hexNum {
    int length = (int)[hexNum length]; // length of hex# param
    NSString *letter = [[NSString alloc] init]; // single hex digit
    NSMutableString *stringIn = [[NSMutableString alloc] initWithString:hexNum]; // holds copy of hexNum as each digit is deleted
    double digit = 0.0; // if hex letter is a num, will be held here
    double base = 16;   // base of hex
    double exponent = (double)([hexNum length] - 1); // dependent on position of letter
    double temp = 0.0;  // holds value of pow()
    long long int multiplier = 0; // holds the decimal equiv of a single hex letter
    long long int total = 0; // running total of conversion
    NSRange range = NSMakeRange(0, 1);
    
    // while not at end of hex #
    while (length > 0) {
        letter = [stringIn substringToIndex:1];
        [stringIn deleteCharactersInRange:range];
        temp = pow(base, exponent);
        
        // chain takes the hex letter and multiplies times temp value
        if ([letter isEqualToString:@"A"])
            multiplier = (long long int)(temp * 10);
        else if ([letter isEqualToString:@"B"])
            multiplier = (long long int)(temp * 11);
        else if ([letter isEqualToString:@"C"])
            multiplier = (long long int)(temp * 12);
        else if ([letter isEqualToString:@"D"])
            multiplier = (long long int)(temp * 13);
        else if ([letter isEqualToString:@"E"])
            multiplier = (long long int)(temp * 14);
        else if ([letter isEqualToString:@"F"])
            multiplier = (long long int)(temp * 15);
        else {
            digit = ((double)[letter characterAtIndex:0] - 48);
            multiplier = (long long int)(temp * digit);
        }
        total += multiplier;
        length--;
        exponent--;
    }
    
    NSLog(@"Converted = %lld", total);
    NSString *converted = [NSString stringWithFormat:@"%lld",total];
    return converted;
}

@end
