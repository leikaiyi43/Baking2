//
//  TimeoutViewController.h
//  Clock
//
//  Created by 达言科技 on 25/11/14.
//  Copyright (c) 2014年 达言科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimerViewDelegate <NSObject>

-(void) timeWithSecond:(NSInteger) seconds userData: userData;

@end


@interface TimeoutViewController : UIViewController

@property(nonatomic ,copy)NSString *nameStr;

@property(nonatomic, assign) id <TimerViewDelegate> delegate;
@property(nonatomic, retain) NSObject *userData;

@end
