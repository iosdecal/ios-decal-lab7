//
//  CalculatorBrain.m
//  Lab7
//
//  Created by Akilesh Bapu on 4/16/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

- (instancetype)init
{
    self = [super init];
    if (self) {
        _calculationString = @"0.0";
        _savedOperand = @"0.0";
        _currentAction = multiply;
    }
    return self;
}
- (void)saveOperand {
    _savedOperand = _calculationString;
    _calculationString = @"0.0";
}

- (void)updateCalculationStringFromButtonTag: (int)tag {
    if (tag == 11) {
        if ([_calculationString containsString:@"."] && !([_calculationString doubleValue] == 0)) {
            return;
        }
        if ([_calculationString intValue] == 0) {
            _calculationString = @"0.";
        } else {
            _calculationString = [_calculationString stringByAppendingString:@"."];
        }
    } else {
        if ([_calculationString doubleValue] == 0 && ![_calculationString isEqualToString:@"0."]) {
            if (tag == 0) {
                
            } else {
                _calculationString = [NSString stringWithFormat:@"%d",tag];
            }
            
        } else {
            _calculationString = [_calculationString stringByAppendingString:[NSString stringWithFormat:@"%d",tag]];
        }
    }
}

- (void)clearCalculationString {
    [self setCalculationString:@"0.0"];
}

- (void)negateCalculationString {
    if([_calculationString hasPrefix:@"-"]) {
        _calculationString = [_calculationString substringFromIndex:1];
    } else {
        _calculationString = [@"-" stringByAppendingString:_calculationString];
    }
}

- (BOOL)hasDecimalPlaces: (double)operand1 _:(double)operand2 {
    if ((int)operand1 != operand1) {
        return true;
    }
    if ((int)operand2 != operand2) {
        return true;
    }
    return false;
}

- (void)setCalculationStringToTangent {
    double input = [_calculationString doubleValue];
    _calculationString = [NSString stringWithFormat:@"%.02f",tan(input)];
}

- (void)commitAction {
    double operand1 = [_savedOperand doubleValue];
    double operand2 = [_calculationString doubleValue];
    double total = 0;
    switch (_currentAction) {
        case multiply: {
            total = operand1 * operand2;
            break;
        }
        case add:
            total = operand1 + operand2;
            break;
        default:
            break;
    }
    if ([self hasDecimalPlaces:operand1 _:operand2]) {
        _calculationString = [NSString stringWithFormat:@"%.02f", total];
    } else {
        _calculationString = [NSString stringWithFormat:@"%d", (int)total];
    }
}

- (BOOL)recognizeAction: (int)tag {
    switch (tag) {
        case equal:
            [self commitAction];
            return true;
        default:
            [self saveOperand];
            _currentAction = tag;
            return false;
    }
}
@end
