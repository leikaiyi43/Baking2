//
//  TimeoutViewController.m
//  Clock
//
//  Created by 达言科技 on 25/11/14.
//  Copyright (c) 2014年 达言科技. All rights reserved.
//

#import "TimeoutViewController.h"
#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface TimeoutViewController ()<MusicDeleGate,UIAlertViewDelegate>{
    UIDatePicker *_datePicker;
    NSTimer *_myTimer;
    NSString *_currentDate;
    double _leftSeconds;
    UIButton *_beginBtn;
    UILabel *_lab;
    BOOL select;
    BOOL select1;
    UIButton *_pauseBtn;
    
    SystemSoundID shortSound;
    AVAudioPlayer *audioPlayer;
}
#define W self.view.frame.size.width
#define H self.view.frame.size.height
@end

@implementation TimeoutViewController


- (void)viewDidLoad {
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=NSLocalizedString(@"Timer", @"计时器");
    [self createDatePicker];
    [self createbtnAndTwoRadiousBtn];
   
}


//创建一个时间选择器
-(void)createDatePicker{
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 64, W, 216)];
    _datePicker.backgroundColor=[UIColor lightGrayColor];
    _datePicker.datePickerMode=  UIDatePickerModeCountDownTimer;
    _datePicker.countDownDuration=_leftSeconds;
    _datePicker.minuteInterval=1/60;
    NSLocale *chineseLocale = [NSLocale localeWithLocaleIdentifier:@"zh_cn"];
    
    _datePicker.locale=chineseLocale;
    [self.view addSubview:_datePicker];
    
    
    
}
//创建一个长方形按钮和2个圆形按钮

-(void)createbtnAndTwoRadiousBtn{
    
    UILabel *subTitle = [[ UILabel alloc] initWithFrame:CGRectMake(0, 280, W, 50)];
    subTitle.backgroundColor = [UIColor grayColor];
    subTitle.textColor = [UIColor whiteColor];
    subTitle.textAlignment =  NSTextAlignmentCenter;
    subTitle.text = NSLocalizedString(@"Pick Time", @"选择时间");
    [self.view addSubview:subTitle];
    
    
    UIButton *beginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    beginBtn.frame=CGRectMake(W/2-30, 330+(H-434)/2,60 , 60);
    beginBtn.tag=1;
    beginBtn.layer.cornerRadius=30;
    beginBtn.clipsToBounds=YES;
    beginBtn.backgroundColor=[UIColor greenColor];
    [beginBtn setTitle:NSLocalizedString(@"Start", @"开始") forState:UIControlStateNormal];
    [beginBtn addTarget:self action:@selector(beginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
    _beginBtn=beginBtn;
}

//长方形按钮的方法
-(void)soundBtn:(UIButton *)btn{
    MusicViewController *musicVC=[[MusicViewController alloc] init];
    musicVC.delegate=self;

    [self.navigationController pushViewController:musicVC animated:YES];

    
}
//左边圆形按钮的方法
-(void)beginBtn:(UIButton *)sender{
    
    _leftSeconds = _datePicker.countDownDuration;
    
    if (_delegate && [_delegate respondsToSelector:@selector(timeWithSecond:userData:)]) {
        [_delegate timeWithSecond:_leftSeconds userData:_userData];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//右边圆形按钮的方法
-(void)pauseBtn
{
    if (select1==NO) {
        [_pauseBtn setTitle:@"继续" forState:UIControlStateNormal];
        [_myTimer setFireDate:[NSDate distantFuture]];
        select1=YES;
        
    }
    else{
        [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [_myTimer setFireDate:[NSDate date]];
        
        select1=NO;

    }
   

}
-(void)MusicStr:(NSString *)str{
    self.nameStr=str;
}
#pragma mark-------UIAlertViewDelegate------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [audioPlayer stop];
    
}


@end
