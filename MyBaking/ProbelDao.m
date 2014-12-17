//
//  ProbelDao.m
//  MyBaking
//
//  Created by lei on 12/2/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "ProbelDao.h"
#import "ProbelModel.h"

@interface ProbelDao (){
    NSMutableArray *_probelModels;
}

@end

@implementation ProbelDao

+(instancetype) sharedProbelDao {
    static ProbelDao *instance;
    
    if (instance == nil) {
        instance = [[ProbelDao alloc] init];
    }
    
    return instance;
}

#pragma mark ------- class override method ------
- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"init dao");
        _probelModels = [NSMutableArray arrayWithObjects:[[ProbelModel alloc] init],[[ProbelModel alloc] init], nil];
    }
    return self;
}
#pragma mark -------- class public method -------
-(NSInteger) probelNumber {
    return _probelModels.count;
}

-(ProbelModel *) probelModelForIndex: (NSInteger) index {
    return [_probelModels objectAtIndex:index];
}

-(void) setTimeout: (NSInteger) timeout forIndex:(NSInteger) index {
    ProbelModel * model = [_probelModels objectAtIndex:index];
    model.timeout = timeout;
    [self timeout:timeout updateForIndex:index];
}

-(void) setTempMin: (NSInteger) tempMin forIndex: (NSInteger) index {
    ProbelModel *model = [_probelModels objectAtIndex:index];
    model.tempMin = tempMin;
}

-(void) setTempMax: (NSInteger) tempMax forIndex: (NSInteger) index {
    ProbelModel *model = [_probelModels objectAtIndex:index];
    model.tempMax = tempMax;
}

-(void) setCurrentTemp: (NSInteger) temp forIndex: (NSInteger) index {
    ProbelModel *model = [_probelModels objectAtIndex:index];
    model.currentTemp = temp;
    [self currentTemp:temp updateForIndex:index];
}

-(void) addTemp: (NSInteger) temp toArrayForIndex: (NSInteger) index {
    ProbelModel *model = [_probelModels objectAtIndex:index];
    
    if (model.tempArrays.count > 50) {
        [model.tempArrays removeObjectAtIndex:0];
    }
    
    [model addTemperature:temp];
}

-(void) addDelegate: (id<ProbeModelDelegate>) delegate forIndex:(NSInteger) index {
    ProbelModel *model = [_probelModels objectAtIndex:index];
    [model addDelegate:delegate];
}



#pragma mark -------- class private method -------

-(void) currentTemp: (NSInteger) temp updateForIndex:(NSInteger) index {
    ProbelModel *model = [_probelModels objectAtIndex:index];
    NSArray *delegates  = [model getDelegates];
    
    for (id<ProbeModelDelegate> delegate in delegates) {
        if (delegates != nil && [delegate respondsToSelector:@selector(temp:updateAtIndex:)]) {
            [delegate temp:temp updateAtIndex:index];
        }
    }
}

-(void) timeout: (NSInteger) timeout updateForIndex:(NSInteger) index {
    ProbelModel *model = [_probelModels objectAtIndex:index];
    NSArray *delegates  = [model getDelegates];
    
    for (id<ProbeModelDelegate> delegate in delegates) {
        if (delegates != nil && [delegate respondsToSelector:@selector(timeout:updateAtIndex:)]) {
            [delegate timeout:timeout updateAtIndex:index];
        }
    }
}

@end

