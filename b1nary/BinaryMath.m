//
//  BinaryMath.m
//  b1nary
//
//  Created by Michael Garza on 2/14/14.
//  Copyright (c) 2014 Mike Garza. All rights reserved.
//

#import "BinaryMath.h"
#import "FromBinaryConversion.h"

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

+ (NSString *) twosComplement:(NSString*)binaryNum withWordSize:(int)wordSize{
	// insert 0's up to word size
	NSLog(@"Passed string = %@",binaryNum);
	if ([binaryNum intValue] == 0)
		return @"0";
	
	NSMutableString *stringIn = [[NSMutableString alloc] initWithString:binaryNum];
	while ([stringIn length] < wordSize) {
		[stringIn insertString:@"0" atIndex:0];
	}
	
	NSLog(@"Bufferred string = %@",stringIn);
	// iterate through number and switch digits
	for (int x = 0; x < [stringIn length]; x++) {
		if ([stringIn characterAtIndex:x] == '0')
			[stringIn replaceCharactersInRange:NSMakeRange(x, 1) withString:@"1"];
		else
			[stringIn replaceCharactersInRange:NSMakeRange(x, 1) withString:@"0"];
	}
	
	NSLog(@"Switched = %@",stringIn);
	NSMutableString *converted =  [[NSMutableString alloc] initWithString:[BinaryMath binaryAddition:stringIn withSecondNumber:@"1"]];
	
	NSLog(@"Converted before = %@",converted);
	while ([converted length] > wordSize) {
		[converted deleteCharactersInRange:NSMakeRange(0, 1)];
	}
	NSLog(@"Converted = %@",converted);
	if ([converted characterAtIndex:0] == '0')
		[converted replaceCharactersInRange:NSMakeRange(0,1) withString:@"1"];
	return converted;
}

+ (NSString *) twosComplementDecimalValue:(NSString *)binaryNum {
	if ([binaryNum intValue] == 0)
		return @"0";
	
	int negativeMSB = (int)[binaryNum length] - 1;
	long long int negativeStart = (int)pow(2,negativeMSB) * -1;
	long long int currentPlaceValue = negativeStart * -1;
	currentPlaceValue /= 2;
	NSLog(@"Negative start = %lld", negativeStart);
	
	for (int x = 1; x < [binaryNum length]; x++) {
		if ([binaryNum characterAtIndex:x] == '1')
			negativeStart += currentPlaceValue;
		currentPlaceValue /= 2;
	}
	NSLog(@"Decimal value = %lld",negativeStart);
	return [NSString stringWithFormat:@"%lld",negativeStart];
}

+ (BOOL) validUnsignedNumber:(NSString *)binaryNum withWordSize:(int)wordSize {
	if (wordSize == 8 && [[FromBinaryConversion binaryToDecimal:binaryNum] intValue] > 128)
		return false;
	else if (wordSize == 16 && [[FromBinaryConversion binaryToDecimal:binaryNum] intValue] > 32768)
		return false;
	else if (wordSize == 24 && [[FromBinaryConversion binaryToDecimal:binaryNum] intValue] > 8388608)
		return false;
	else if (wordSize == 32 && [[FromBinaryConversion binaryToDecimal:binaryNum] longLongValue] > 2147483648)
		return false;
	else
		return true;
}


@end
