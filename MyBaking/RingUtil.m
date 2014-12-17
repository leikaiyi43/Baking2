//
//  RingUtil.m
//  MyBaking
//
//  Created by lei on 12/9/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "RingUtil.h"
#import "BakingPreferences.h"
#import <AVFoundation/AVFoundation.h>

@interface RingUtil (){
    AVAudioPlayer *_audioPlayer;
}

@end

@implementation RingUtil

+ (instancetype) sharedRingUtil {
    static RingUtil *instance;
    instance = [[RingUtil alloc] init];
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (NSArray *) getRingNames {
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"Rings" ofType:@"plist"];
    return [[NSMutableArray alloc] initWithContentsOfFile:plist];
}

- (void) playRing {
    BakingPreferences * pref = [BakingPreferences sharedBakingPreferences];
    NSInteger index = pref.ringIndex;
    NSString *name = [[self getRingNames] objectAtIndex:index];
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [_audioPlayer play];
}

- (void) stopRing {
    [_audioPlayer stop];
}

@end
