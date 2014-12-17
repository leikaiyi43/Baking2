//
//  ProbelModel.h
//  MyBaking
//
//  Created by lei on 12/2/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProbeModelDelegate <NSObject>
@optional
- (void) temp: (NSInteger) temp updateAtIndex: (NSInteger) index;
- (void) timeout: (NSInteger) timeout updateAtIndex: (NSInteger) index;
@end

@interface ProbelModel : NSObject

@property (nonatomic, assign) NSInteger timeout;
@property (nonatomic, assign) NSInteger tempMin;
@property (nonatomic, assign) NSInteger tempMax;
@property (nonatomic, assign) NSInteger currentTemp;
@property (nonatomic, strong) NSMutableArray *tempArrays;

-(void) addTemperature:(NSInteger) temp;


// delegate
-(void) addDelegate: (id<ProbeModelDelegate>) delegate;
-(NSArray*) getDelegates;

@end
