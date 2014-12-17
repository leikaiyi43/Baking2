//
//  TemperatureView.m
//  MyBaking
//
//  Created by lei on 12/4/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "TemperatureView.h"
#import "LDProgressView.h"
#import "TempUtil.h"

@implementation TemperatureView {
    LDProgressView *_ldProgressView;
    UILabel *_maxTempLabel;
    UILabel *_minTempLabel;
    UILabel *_currentTempLabel;
    UILabel *_warnTempLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentTemp = 0;
        _maxTemp = 200;
        _minTemp = 0;
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    if (!_ldProgressView) {
        _ldProgressView = [[LDProgressView alloc] initWithFrame:CGRectMake(25, CGRectGetMidY(rect) - 5, CGRectGetWidth(rect)- 50, 10)];
        _ldProgressView.color = [UIColor colorWithRed:0.95f green:0.30f blue:0.30f alpha:1.0f];
        _ldProgressView.flat = @YES;
        _ldProgressView.progress = 0.0f;
        
        [self addSubview:_ldProgressView];
    }
    if (!_minTempLabel) {
        _minTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(rect) - 10, 20, 20)];
        _minTempLabel.textAlignment = NSTextAlignmentRight;
        [_minTempLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:_minTempLabel];
    }
    
    if (!_maxTempLabel) {
        _maxTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(rect) - 20, CGRectGetMidY(rect) - 10, 30, 20)];
        [_maxTempLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:_maxTempLabel];
    }
    
    NSInteger currentTempDx = _ldProgressView.frame.origin.x + CGRectGetWidth(_ldProgressView.frame) * _ldProgressView.progress;
    if (!_currentTempLabel) {
        _currentTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentTempDx, CGRectGetMidY(rect) - 30, 20, 20)];
        [_currentTempLabel setAdjustsFontSizeToFitWidth:YES];
        [_currentTempLabel setHidden:YES];
        _currentTempLabel.textColor = [ UIColor redColor];
        [self addSubview:_currentTempLabel];
    }
    
    NSInteger warnTempDx = _ldProgressView.frame.origin.x + CGRectGetWidth(_ldProgressView.frame) * (([[TempUtil sharedTempUtil] localizedTemp:_warnTemp] - _minTemp) * 1.0f / (_maxTemp - _minTemp));
    if (!_warnTempLabel) {
        _warnTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(warnTempDx, CGRectGetMidY(rect) + 10, 20, 20)];
        _warnTempLabel.textColor = [UIColor orangeColor];
        [_warnTempLabel setHidden:YES];
        [_warnTempLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:_warnTempLabel];
    }
    
    _currentTempLabel.frame = CGRectMake(currentTempDx, CGRectGetMidY(rect) - 30, 40, 20);
    _warnTempLabel.frame = CGRectMake(warnTempDx, CGRectGetMidY(rect) + 10, 40, 20);
    _ldProgressView.progress = ([[TempUtil sharedTempUtil] localizedTemp:_currentTemp] - _minTemp) * 1.0f / (_maxTemp - _minTemp);
    _minTempLabel.text = [NSString stringWithFormat:@"%ld", _minTemp];
    _maxTempLabel.text = [NSString stringWithFormat:@"%ld", _maxTemp];
    
    if (_currentTemp == -1) {
        [_currentTempLabel setHidden:YES];
    } else {
        [_currentTempLabel setHidden:NO];
        _currentTempLabel.text = [[TempUtil sharedTempUtil] stringLocalizedTemp: _currentTemp];
    }
    
    if (_warnTemp == -1) {
        [_warnTempLabel setHidden:YES];
    } else {
        [_warnTempLabel setHidden:NO];
        _warnTempLabel.text = [[TempUtil sharedTempUtil] stringLocalizedTemp:_warnTemp];
    }
}

-(void)setCurrentTemp:(NSInteger)currentTemp {
    if ([[TempUtil sharedTempUtil] localizedTemp:currentTemp] > _maxTemp) {
        _maxTemp = _maxTemp * 2;
    }
    _currentTemp = currentTemp;
    [self setNeedsDisplay];
}

-(void)setWarnTemp:(NSInteger)warnTemp {
    if ([[TempUtil sharedTempUtil] localizedTemp:warnTemp] > _maxTemp) {
        _maxTemp = _maxTemp * 2;
    }
    
    _warnTemp = warnTemp;
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
