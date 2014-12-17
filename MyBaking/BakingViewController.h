//
//  BakingViewController.h
//  MyBaking
//
//  Created by lei on 11/12/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProbeItemView.h"
#import "TimeoutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BakingViewController : UINavigationController <UITableViewDelegate, UITableViewDataSource, ProbeItemDelegate, TimerViewDelegate, UIAlertViewDelegate> {
    AVAudioPlayer *_audioPlayer;
}

@property (nonatomic, retain) UITableViewController *tableViewCtrl;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSMutableArray *timerCounts;

@end
