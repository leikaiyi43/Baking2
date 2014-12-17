//
//  CustomeTemperatureViewController.h
//  MyBaking
//
//  Created by lei on 12/2/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemperatureViewController.h"

@interface CustomeTemperatureViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIPickerView *dataPicker;
@property (strong, nonatomic) IBOutlet UINavigationItem *presentTopBar;
@property (weak, nonatomic) TemperatureViewController *temperatureCtrl;

- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;

@end
