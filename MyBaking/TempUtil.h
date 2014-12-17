//
//  TempUtil.h
//  MyBaking
//
//  Created by lei on 12/15/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempUtil : NSObject

@property (nonatomic, assign) BOOL isTempC;

- (NSInteger) localizedTemp:(NSInteger) temp;
- (NSString *) stringLocalizedTemp: (NSInteger) temp;
- (NSInteger) tempToC:(NSInteger) temp;
- (NSString *) stringWithUnit: (NSInteger) temp;
+ (instancetype) sharedTempUtil;

@end
