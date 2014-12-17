//
//  ProbelModel.m
//  MyBaking
//
//  Created by lei on 12/2/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "ProbelModel.h"

@implementation ProbelModel {
    NSMutableArray *_delegates;
}

-(instancetype)init  {
    if (self = [super init]) {
        _tempArrays = [NSMutableArray array];
        _delegates = [NSMutableArray array];
        _timeout = -1;
        _tempMin = -1;
        _tempMax = -1;
        _currentTemp = -1;
    }
    return self;
}

-(void) addTemperature:(NSInteger) temp {
    [_tempArrays addObject:[NSNumber numberWithInt:temp]];
}

// delegate
-(void) addDelegate: (id<ProbeModelDelegate>) delegate {
    [_delegates addObject:delegate];
}
-(NSArray*) getDelegates {
    return _delegates;
}

@end
