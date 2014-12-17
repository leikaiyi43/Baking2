//
//  ProbelUtil.m
//  MyBaking
//
//  Created by lei on 12/3/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "ProbelUtil.h"
#import "ProbelDao.h"

@interface ProbelUtil () {
    ProbelDao *_probelDao;
}

@end

@implementation ProbelUtil

-(instancetype)init {
    if (self = [super init]) {
        _kServiceUUIDs = @[@"FE551580-4180-8A02-EF2C-1B42A0AC3F83"];
        _kCharacteristicUUIDs = @[@"FE551582-4180-8A02-EF2C-1B42A0AC3F83"];
        _probelDao = [ProbelDao sharedProbelDao];
    }
    return self;
}

+ (instancetype)sharedProbelUtil {
    static ProbelUtil *instance;
    
    if (!instance) {
        instance = [[ProbelUtil alloc] init];
    }
    return instance;
}

- (void)decodeWithCharacteristic:(CBCharacteristic *)characteristic {
    for (int i = 0; i < _kCharacteristicUUIDs.count; i++) {
        
        NSLog(@"%@", characteristic);
        CBUUID *uuid = [CBUUID UUIDWithString:[_kCharacteristicUUIDs objectAtIndex:i]];
        if ([uuid isEqual:characteristic.UUID]) {
            if (i == 0) {
                unsigned short *values = (unsigned short *) [characteristic.value bytes];
                int temp1 = *values;
                int temp2 = *(values + 1);
                
                [_probelDao setCurrentTemp:temp1 forIndex:0];
                [_probelDao setCurrentTemp:temp2 forIndex:1];
            }
        }
    }
}

@end
