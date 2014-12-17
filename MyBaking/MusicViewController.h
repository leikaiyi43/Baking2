//
//  MusicViewController.h
//  Clock
//
//  Created by 达言科技 on 27/11/14.
//  Copyright (c) 2014年 达言科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MusicDeleGate<NSObject>
-(void)MusicStr:(NSString *)str;

@end


@interface MusicViewController : UIViewController
@property(nonatomic,assign)id<MusicDeleGate>delegate;


@end
