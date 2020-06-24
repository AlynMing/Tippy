//
//  SettingsViewController.m
//  Tippy
//
//  Created by meganyu on 6/23/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UISlider *customTipSlider;
@property (weak, nonatomic) IBOutlet UILabel *customTipLabel;
@property (weak, nonatomic) IBOutlet UISwitch *darkMode;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // load key from NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double doubleValue = [defaults doubleForKey:@"default_tip_percentage"];
    int defaultIndex = (int) [defaults integerForKey:@"default_tip_control_segment"];
    
    [self.defaultTipControl setSelectedSegmentIndex:defaultIndex];
    
    if (defaultIndex == 3) {
        self.customTipSlider.alpha = 1;
        self.customTipLabel.alpha = 1;
        self.customTipSlider.value = doubleValue * 100;
        self.customTipLabel.text = [NSString stringWithFormat:@"%.1f%%", doubleValue * 100];
    } else {
        self.customTipSlider.alpha = 0;
        self.customTipLabel.alpha = 0;
    }
    
    NSLog(@"View will appear");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onEdit:(id)sender {
    int defaultTipControlSegment = (int) self.defaultTipControl.selectedSegmentIndex;
    double defaultTipPercentage;
    
    if (defaultTipControlSegment < 3) {
        self.customTipSlider.alpha = 0;
        self.customTipLabel.alpha = 0;
        NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
        defaultTipPercentage = [percentages[defaultTipControlSegment] doubleValue];
    } else {
        self.customTipSlider.alpha = 1;
        self.customTipLabel.alpha = 1;
        self.customTipLabel.text = [NSString stringWithFormat:@"%.1f%%", self.customTipSlider.value];
        defaultTipPercentage = self.customTipSlider.value / 100.0;
    }
    
    
    // save keys to NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:defaultTipPercentage forKey:@"default_tip_percentage"];
    [defaults setInteger:defaultTipControlSegment forKey:@"default_tip_control_segment"];
    [defaults synchronize];
}


@end
