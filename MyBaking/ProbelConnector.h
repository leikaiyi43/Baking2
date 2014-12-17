//
//  ProbelConnector.h
//  MyBaking
//
//  Created by lei on 12/3/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProbelConnector : NSObject

+ (instancetype) sharedProelConnector;

- (void) startConnector;

@end
