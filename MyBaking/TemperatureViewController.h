//
//  TemperatureViewController.h
//  MyBaking
//
//  Created by lei on 11/30/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TemperatureViewDelegate <NSObject>

@optional
-(void) didTemperatureSeted:(NSInteger ) temp withUserData:(NSDictionary *) userData;

@end

@class SSRollingButtonScrollView;
@interface TemperatureViewController : UIViewController

@property (weak, nonatomic) IBOutlet SSRollingButtonScrollView *phoneticSelector01;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (strong, nonatomic) NSMutableDictionary *userData;
@property (strong, nonatomic) IBOutlet UISegmentedControl *titleSegment;
@property (strong, nonatomic) IBOutlet UILabel *foodNameLabel;

@property (weak, nonatomic) id<TemperatureViewDelegate> delegate;

- (IBAction)onConfirmed:(id)sender;
- (void) customeTemperature: (NSInteger) temp;
- (IBAction)onSegmentChanged:(id)sender;

@end
