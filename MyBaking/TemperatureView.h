//
//  TemperatureView.h
//  MyBaking
//
//  Created by lei on 12/4/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemperatureView : UIView

@property (nonatomic, assign) NSInteger currentTemp;
@property (nonatomic, assign) NSInteger warnTemp;
@property (nonatomic, assign) NSInteger maxTemp;
@property (nonatomic, assign) NSInteger minTemp;

@end
