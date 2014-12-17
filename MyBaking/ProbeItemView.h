//
//  ProbeDetailView.h
//  MyBaking
//
//  Created by lei on 11/17/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TemperatureView;
@class ProbeItemView;
@protocol ProbeItemDelegate <NSObject>

@optional
-(void) probeItemViewDidTimerSelected:(ProbeItemView *)probeItemView;
-(void) probeItemViewDidTemperatureSelected: (ProbeItemView *)probeItemView;
@end


@interface ProbeItemView : UITableViewCell

@property(nonatomic, assign) NSInteger temperature;
@property(nonatomic, assign) NSInteger timeCount;
@property(nonatomic, assign) NSInteger warnTemp;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *tempLabel;
@property(nonatomic, strong) TemperatureView *tempView;

@property(nonatomic, assign) id <ProbeItemDelegate> delegate;

@end
