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
@property (weak, nonatomic) IBOutlet UISlider *customTipSlider;
@property (weak, nonatomic) IBOutlet UILabel *customTipLabel;

@property (weak, nonatomic) IBOutlet UIView *billView;
@property (weak, nonatomic) IBOutlet UIView *totalsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //TODO: set up initial screen so that you only see billsView
    self.totalsView.alpha = 0;
    
    self.title = @"Tips";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.billField.placeholder = @"$";
    // load key from NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double doubleValue = [defaults doubleForKey:@"default_tip_percentage"];
    int defaultIndex = (int) [defaults integerForKey:@"default_tip_control_segment"];
    
    //TODO: find a way to modify UISegmentedControl to reflect new defaults
    [self.tipControl setSelectedSegmentIndex:defaultIndex];
    
    if (defaultIndex == 3) {
        self.customTipSlider.alpha = 1;
        self.customTipLabel.alpha = 1;
        self.customTipSlider.value = doubleValue * 100;
        self.customTipLabel.text = [NSString stringWithFormat:@"%.1f%%", doubleValue * 100];
    } else {
        self.customTipSlider.alpha = 0;
        self.customTipLabel.alpha = 0;
    }
    
    [self.billField becomeFirstResponder];
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
    int selectedTipControlSegment = (int) self.tipControl.selectedSegmentIndex;
    double tipPercentage;
    
    if (selectedTipControlSegment < 3) {
        self.customTipSlider.alpha = 0;
        self.customTipLabel.alpha = 0;
        NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
        tipPercentage = [percentages[selectedTipControlSegment] doubleValue];
    } else {
        self.customTipSlider.alpha = 1;
        self.customTipLabel.alpha = 1;
        self.customTipLabel.text = [NSString stringWithFormat:@"%.1f%%", self.customTipSlider.value];
        tipPercentage = self.customTipSlider.value / 100.0;
    }
    
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
        self.billView.frame = CGRectMake(self.billView.frame.origin.x, self.billView.frame.origin.y + 50, self.billView.frame.size.width, self.billView.frame.size.height);
        self.totalsView.frame = CGRectMake(self.totalsView.frame.origin.x, self.totalsView.frame.origin.y + 50, self.totalsView.frame.size.width, self.totalsView.frame.size.height);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.totalsView.alpha = 0.3;
    }];
    
}

- (IBAction)onEditingDidEnd:(id)sender {
    CGRect newBillFrame = self.billView.frame;
    newBillFrame.origin.y -= 50;
    CGRect newTotalsFrame = self.totalsView.frame;
    newTotalsFrame.origin.y -= 50;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.billView.frame = newBillFrame;
        self.totalsView.frame = newTotalsFrame;
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.totalsView.alpha = 1;
    }];
    
}

@end
