//
//  ProbelDao.h
//  MyBaking
//
//  Created by lei on 12/2/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProbelModel;
@protocol ProbeModelDelegate;
@interface ProbelDao : NSObject

+(instancetype) sharedProbelDao;
-(NSInteger) probelNumber;
-(ProbelModel *) probelModelForIndex: (NSInteger) index;

-(void) setTimeout: (NSInteger) timeout forIndex:(NSInteger) index;
-(void) setTempMin: (NSInteger) tempMin forIndex: (NSInteger) index;
-(void) setTempMax: (NSInteger) tempMax forIndex: (NSInteger) index;
-(void) setCurrentTemp: (NSInteger) temp forIndex: (NSInteger) index;
-(void) addTemp: (NSInteger) temp toArrayForIndex: (NSInteger) index;

//delegate
-(void) addDelegate: (id<ProbeModelDelegate>) delegate forIndex:(NSInteger) index;


@end