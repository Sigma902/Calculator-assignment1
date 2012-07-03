//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Craig Doran on 5/31/12.
//  Copyright (c) 2012 Microwork.net. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil) {
     _operandStack = [[NSMutableArray alloc] init];   
    }
    return _operandStack;
}


- (void)pushOperand:(double)operand {
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}


- (double)performOperation:(NSString *)operation {
    double result = 0;
    // calculate result
    if ([self.operandStack count] < 2) {
        [self pushOperand:result];
    }
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([@"-" isEqualToString:operation]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([@"/" isEqualToString:operation]) {
        double divisor = [self popOperand];
        result = [self popOperand] / divisor;
    } else if ([@"sin" isEqualToString:operation]) {
        result = sin([self popOperand]);
    } else if ([@"cos" isEqualToString:operation]) {
        result = cos([self popOperand]);
    } else if ([@"sqrt" isEqualToString:operation]) {
        result = sqrt([self popOperand]);
    } else if ([@"π" isEqualToString:operation]) {
        result = 22.000/7.000;
    }
    
    [self pushOperand:result];
    
    return result; 
}

- (void)clear {
    [self.operandStack removeAllObjects];
}

@end
