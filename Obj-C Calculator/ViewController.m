//
//  ViewController.m
//  Lab7
//
//  Created by Akilesh Bapu on 4/16/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *calculationView;
@property CalculatorBrain *Cbrain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _Cbrain = [[CalculatorBrain alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatecalculationView {
    [_calculationView setText:[_Cbrain calculationString]];
}

- (IBAction)numberPressed:(id)sender {
    UIButton *pressedButton = (UIButton *)sender;
    [_Cbrain updateCalculationStringFromButtonTag:(int)pressedButton.tag];
    [self updatecalculationView];
}
- (IBAction)clearPressed:(id)sender {
    [_Cbrain clearCalculationString];
    [self updatecalculationView];
}
- (IBAction)plusMinusPressed:(id)sender {
    [_Cbrain negateCalculationString];
    [self updatecalculationView];
}

- (IBAction)tangent:(id)sender {
    [_Cbrain setCalculationStringToTangent];
    [self updatecalculationView];
}
- (IBAction)actionPressed:(id)sender {
    UIButton *pressedButton = (UIButton *)sender;
    if ([_Cbrain recognizeAction:(int)pressedButton.tag]) {
        [self updatecalculationView];
    };
}

@end
