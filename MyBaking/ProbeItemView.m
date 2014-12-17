//
//  ProbeDetailView.m
//  MyBaking
//
//  Created by lei on 11/17/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "ProbeItemView.h"
#import "TemperatureView.h"

@implementation ProbeItemView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    UIImageView *thermometerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 65, 65)];
    [thermometerIcon setImage:[UIImage imageNamed:@"thermometer"]];
    
    _tempView = [[TemperatureView alloc] initWithFrame:CGRectMake(80, 0, self.frame.size.width - 150, CGRectGetMidY(rect))];
    _tempView.backgroundColor = [UIColor whiteColor];
    
    UIButton *setTemperatureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    setTemperatureBtn.frame = CGRectMake(self.frame.size.width - 65, 35, 55, 35);
    [setTemperatureBtn setTitle:NSLocalizedString(@"Set", @"设置") forState: UIControlStateNormal];
    [setTemperatureBtn addTarget:self action:@selector(temperatureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:setTemperatureBtn];
    [self addSubview:_tempView];
    [self addSubview:thermometerIcon];
    
    
    UIImageView *clockIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.frame.size.height - 85,
                                                                                    65, 65)];
    [clockIcon setImage:[UIImage imageNamed:@"clock"]];
    
    _timeLabel= [[UILabel alloc] initWithFrame:CGRectMake(120, self.frame.size.height - 70, self.frame.size.width - 150, 35)];
    _timeLabel.text = _timeCount > 0 ? [self formatTime:_timeCount] : NSLocalizedString(@"No Set", @"未设置");
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, self.frame.size.height - 70, 40, 35)];
    leftLabel.text = NSLocalizedString(@"Left", @"剩余");
    leftLabel.textAlignment = NSTextAlignmentRight;
    
    UIButton *setTimerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    setTimerBtn.frame = CGRectMake(self.frame.size.width - 65, self.frame.size.height - 70, 55, 35);
    [setTimerBtn setTitle:NSLocalizedString(@"Set", @"设置") forState:UIControlStateNormal];
    [setTimerBtn addTarget:self action:@selector(timerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:setTimerBtn];
    [self addSubview:clockIcon];
    [self addSubview:_timeLabel];
    [self addSubview:leftLabel];
}

- (void) temperatureBtnClick:(id) sender {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(probeItemViewDidTemperatureSelected:)]) {
        [_delegate probeItemViewDidTemperatureSelected:self];
    }
}

- (void) timerBtnClick: (id) sender {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(probeItemViewDidTimerSelected:)]) {
        [_delegate probeItemViewDidTimerSelected:self];
    }
}

-(void)setTimeCount:(NSInteger)timeCount {
    _timeCount = timeCount;
    _timeLabel.text = _timeCount > 0 ? [self formatTime:_timeCount] : NSLocalizedString(@"No Set", @"未设置");
}

- (void)setTemperature:(NSInteger)temperature {
    _temperature = temperature;
    _tempView.currentTemp = temperature;
}

- (void)setWarnTemp:(NSInteger)warnTemp {
    _warnTemp = warnTemp;
    _tempView.warnTemp = warnTemp;
}

- (NSString *) formatTime:(NSInteger) count {
    NSInteger seconds = count % 60;
    NSInteger minutes = (count / 60) % 60;
    NSInteger hours = count / 3600;
    return [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hours, minutes, seconds];
}

@end
