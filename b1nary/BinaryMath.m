//
//  BinaryMath.m
//  b1nary
//
//  Created by Michael Garza on 2/14/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "BinaryMath.h"

@implementation BinaryMath

+ (NSString *) binaryAddition: (NSString *)firstNum withSecondNumber:(NSString *)secondNum {
    
    NSMutableString *firstNumber = [[NSMutableString alloc] initWithString:firstNum];
    NSMutableString *secondNumber = [[NSMutableString alloc] initWithString:secondNum];
    int firstCount = (int)[firstNumber length];
    int secondCount = (int)[secondNumber length];
    // check if first < second, add leading zeroes till ==
    if (firstCount < secondCount) {
        while (firstCount != secondCount) {
            [firstNumber insertString:@"0" atIndex:0];
            firstCount++;
        }
    }
    else if (firstCount > secondCount) {
        while (firstCount != secondCount) {
            [secondNumber insertString:@"0" atIndex:0];
            secondCount++;
        }
    }
    
    char remainder = '0';
    int count = firstCount;
    NSMutableString *sum = [[NSMutableString alloc] init];
    // while still digits to add
    while (count > 0) {
        // no remainder
        if (remainder == '0') {
            // insert 0, r=0
            if ([firstNumber characterAtIndex:(count-1)] == '0' &&
                [secondNumber characterAtIndex:(count-1)] == '0')
                [sum appendString:@"0"];
            // insert 1, r=0
            else if ([firstNumber characterAtIndex:(count-1)] == '0' &&
                     [secondNumber characterAtIndex:(count-1)] == '1')
                [sum appendString:@"1"];
            // insert 1, r=0
            else if ([firstNumber characterAtIndex:(count-1)] == '1' &&
                     [secondNumber characterAtIndex:(count-1)] == '0')
                [sum appendString:@"1"];
            // insert 0, r=1
            else {
                [sum appendString:@"0"];
                remainder = '1';
            }
                
        }
        // R=1
        else {
            // insert 1, r=0
            if ([firstNumber characterAtIndex:(count-1)] == '0' &&
                [secondNumber characterAtIndex:(count-1)] == '0') {
                [sum appendString:@"1"];
                remainder = '0';
            }
            // insert 0, r=1
            else if ([firstNumber characterAtIndex:(count-1)] == '0' &&
                     [secondNumber characterAtIndex:(count-1)] == '1') {
                [sum appendString:@"0"];
                remainder = '1';
            }
            // insert 0, r=1
            else if ([firstNumber characterAtIndex:(count-1)] == '1' &&
                     [secondNumber characterAtIndex:(count-1)] == '0') {
                [sum appendString:@"0"];
                remainder = '1';
            }
            // insert 1, r=1
            else {
                [sum appendString:@"1"];
                remainder = '1';
            }
            
        }
        count--;
    }
    if (remainder == '1')
        [sum appendString:@"1"];
    
    unichar theChar;
    NSString *tempString = @"";
    NSMutableString *finalSum = [[NSMutableString alloc]init];
    // reverse sum
    for (int x = (int)[sum length]; x > 0; x--) {
        theChar = [sum characterAtIndex:x-1];
        tempString = [NSString stringWithCharacters:&theChar length:1];
        [finalSum appendString:tempString];
    }
    return (NSString*)finalSum;
}

@end
