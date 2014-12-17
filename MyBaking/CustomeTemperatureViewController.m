//
//  CustomeTemperatureViewController.m
//  MyBaking
//
//  Created by lei on 12/2/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "CustomeTemperatureViewController.h"
#import "TempUtil.h"


@interface CustomeTemperatureViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger selectedRow;
}
@end

@implementation CustomeTemperatureViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
 
    if ((self = [super initWithCoder:aDecoder])) {
        selectedRow = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.presentTopBar.rightBarButtonItem.title = NSLocalizedString(@"OK", @"确定");
    self.presentTopBar.leftBarButtonItem.title = NSLocalizedString(@"Cancel", @"取消");
    self.presentTopBar.title = NSLocalizedString(@"Custom", @"自定义");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark ---------- data picker delegate ---------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[TempUtil sharedTempUtil] localizedTemp:200] + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d", row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedRow = row;
}

# pragma mark ------------ end ------------

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirm:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.temperatureCtrl customeTemperature:[[TempUtil sharedTempUtil] tempToC:selectedRow]];
}
@end
