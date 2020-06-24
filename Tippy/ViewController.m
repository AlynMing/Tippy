//
//  ViewController.m
//  Tippy
//
//  Created by meganyu on 6/23/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel1;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel2;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel3;
@property (weak, nonatomic) IBOutlet UILabel *totalLabelCustom;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UITextField *customPersonsField;

@property (weak, nonatomic) IBOutlet UIView *billView;
@property (weak, nonatomic) IBOutlet UIView *totalsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //TODO: set up initial screen so that you only see billsView

    
    self.title = @"Tips";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // load key from NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double doubleValue = [defaults doubleForKey:@"default_tip_percentage"];
    NSLog(@"Current default tip: %f", doubleValue);
    //TODO: find a way to modify UISegmentedControl to reflect new defaults
    
    NSLog(@"View will appear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"View did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    NSLog(@"View will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    NSLog(@"View did disappear");
}

- (IBAction)onTap:(id)sender {
    NSLog(@"Hello");
    [self.view endEditing:YES];
}

- (IBAction)onEdit:(id)sender {
    double bill = [self.billField.text doubleValue];
    
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = tipPercentage * bill;
    double total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel1.text = [NSString stringWithFormat:@"$%.2f", total];
    self.totalLabel2.text = [NSString stringWithFormat:@"$%.2f", total / 2];
    self.totalLabel3.text = [NSString stringWithFormat:@"$%.2f", total / 3];
    
    if (self.customPersonsField.text.length > 0) {
        int numberOfPersons = [self.customPersonsField.text intValue];
        self.totalLabelCustom.text = [NSString stringWithFormat:@"$%.2f", total / numberOfPersons];
    } else {
        self.totalLabelCustom.text = [NSString stringWithFormat:@"$%.2f", 0.00];
    }
    
}

- (IBAction)onEditingBegin:(id)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.billField.frame = CGRectMake(self.billField.frame.origin.x, self.billField.frame.origin.y + 30, self.billField.frame.size.width, self.billField.frame.size.height);
    }];
    
    [UIView animateWithDuration:1 animations:^{
        self.tipLabel.alpha = 0;
    }];
    
    // TODO: add animation for billView and totalsView
    
}

- (IBAction)onEditingDidEnd:(id)sender {
    CGRect newFrame = self.billField.frame;
    newFrame.origin.y -= 30;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.billField.frame = newFrame;
    }];
    
    [UIView animateWithDuration:1 animations:^{
        self.tipLabel.alpha = 1;
    }];
    
}

@end
