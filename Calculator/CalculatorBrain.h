//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Craig Doran on 5/31/12.
//  Copyright (c) 2012 Microwork.net. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject
- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clear;

@end
