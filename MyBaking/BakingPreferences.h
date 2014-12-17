//
//  BakingPreferences.h
//  MyBaking
//
//  Created by lei on 11/16/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BakingPreferences : NSObject

@property (nonatomic) NSInteger languageIndex;
@property (nonatomic) BOOL isTemperatureC;
@property (nonatomic) NSInteger ringIndex;

+(BakingPreferences *) sharedBakingPreferences;

-(void) savePreferences;

@end
