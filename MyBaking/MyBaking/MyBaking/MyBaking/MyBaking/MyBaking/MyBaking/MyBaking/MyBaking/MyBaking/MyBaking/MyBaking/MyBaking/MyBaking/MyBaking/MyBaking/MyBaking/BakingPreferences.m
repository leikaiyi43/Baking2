//
//  BakingPreferences.m
//  MyBaking
//
//  Created by lei on 11/16/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "BakingPreferences.h"

@implementation BakingPreferences

@synthesize languageIndex;
@synthesize isTemperatureC;

static BakingPreferences *context = nil;
static NSString *isTempereatureCKey = @"isTempereatureCKey";
static NSString *languagePathKey =@"languageIndexKey";

+(BakingPreferences *) sharedBakingPreferences {
    
    static  BakingPreferences *sharedInstance = nil ;
    static  dispatch_once_t onceToken;  // 锁
    dispatch_once (& onceToken, ^ {     // 最多调用一次
        sharedInstance = [[self  alloc] init];
    });
    return  sharedInstance;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        self.isTemperatureC = [defaults boolForKey:isTempereatureCKey];
        self.languageIndex = [defaults integerForKey:languagePathKey];
        
    }
    return self;
}

-(void) savePreferences {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.isTemperatureC forKey:isTempereatureCKey];
    [defaults setInteger:self.languageIndex forKey:languagePathKey];
    [defaults synchronize];
}


@end
