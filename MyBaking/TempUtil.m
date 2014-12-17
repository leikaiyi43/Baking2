//
//  TempUtil.m
//  MyBaking
//
//  Created by lei on 12/15/14.
//  Copyright (c) 2014 ;. All rights reserved.
//

#import "TempUtil.h"
#import "BakingPreferences.h"

@interface TempUtil () {
}

@end

@implementation TempUtil

+ (instancetype) sharedTempUtil {
    static TempUtil *instance;
    if (!instance) {
        instance = [[TempUtil alloc] init];
    }
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

-(void) readSeting {
    BakingPreferences *pref = [BakingPreferences sharedBakingPreferences];
    _isTempC = pref.isTemperatureC;
}

- (NSInteger) localizedTemp:(NSInteger) temp {
    [self readSeting];
    if (_isTempC) {
        return temp;
    }
    return temp * 2;
}

- (NSInteger) tempToC:(NSInteger) temp {
    [self readSeting];
    if (_isTempC) {
        return temp;
    }
    return temp / 2;
}

- (NSString *) stringWithUnit: (NSInteger) temp {
    [self readSeting];
    if (_isTempC) {
        return [NSString stringWithFormat:@"%d℃", temp];
    } else {
        return [NSString stringWithFormat:@"%d°F", temp];
    }
}

- (NSString *) stringLocalizedTemp: (NSInteger) temp {
    [self readSeting];
    if (_isTempC) {
        return [NSString stringWithFormat:@"%d℃", temp];
    } else {
        return [NSString stringWithFormat:@"%d°F", temp * 2];
    }
}

@end
