//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Craig Doran on 5/31/12.
//  Copyright (c) 2012 Rotary International. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property NSString* oldDisplay;
@end


@implementation CalculatorViewController

@synthesize display = _display;
@synthesize tape = _tape;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize oldDisplay = _oldDisplay;

- (CalculatorBrain *)brain 
{
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}


- (IBAction)digitPressed:(UIButton*)sender 
{
    NSString *digit = [sender currentTitle];
    
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if ([digit isEqualToString:@"⬅"]) {
            if (([self.display.text length] - 1) > 0) {
                self.display.text = [self.display.text substringToIndex:([self.display.text length] - 1)];
            } else {
                self.display.text = @"0";
                self.userIsInTheMiddleOfEnteringANumber = NO;
            }
        } else {
            self.display.text = [self.display.text stringByAppendingString:digit];
        }
    } else {
        if ([digit isEqualToString:@"."]) {
            self.display.text = @"0.";
            self.tape.text = [self.tape.text stringByAppendingString:@"0"];
        } else {
            self.display.text = digit;
        }
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    if ([digit isEqualToString:@"⬅"]) {
        self.tape.text = [self.tape.text substringToIndex:([self.tape.text length] - 1)];
    } else {
        self.tape.text = [self.tape.text stringByAppendingString:digit];
    }
}

- (IBAction)enterPressed {
    NSArray *imprecision = [self.display.text componentsSeparatedByString:@"."];
    if ([imprecision count] < 3) {
        [self.brain pushOperand:[self.display.text doubleValue]];
    } else {
        self.display.text = @"Invalid entry";
    }
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.tape.text = [self.tape.text stringByAppendingString:@" "];
    
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.tape.text = [self.tape.text stringByAppendingString:sender.currentTitle];
    if (!self.userIsInTheMiddleOfEnteringANumber) self.tape.text = [self.tape.text stringByAppendingString:@" = "];
}

- (IBAction)clearPressed:(UIButton *)sender {
    [self.brain clear];
    self.display.text = [NSString stringWithString:@""];
    self.tape.text = [NSString stringWithString:@""];
}

@end
