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

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double defaultTipPercentage = [percentages[self.defaultTipControl.selectedSegmentIndex] doubleValue];
    
    // save a key to NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:defaultTipPercentage forKey:@"default_tip_percentage"];
    [defaults synchronize];
}


@end
