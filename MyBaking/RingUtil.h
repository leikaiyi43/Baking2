//
//  RingUtil.h
//  MyBaking
//
//  Created by lei on 12/9/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RingUtil : NSObject


+ (instancetype) sharedRingUtil;
- (NSArray *) getRingNames;
- (void) playRing;
- (void) stopRing;

@end

