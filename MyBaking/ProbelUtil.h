//
//  ProbelUtil.h
//  MyBaking
//
//  Created by lei on 12/3/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ProbelUtil : NSObject

@property (nonatomic, strong, readonly) NSArray *kServiceUUIDs;
@property (nonatomic, strong, readonly) NSArray *kCharacteristicUUIDs;

+(instancetype) sharedProbelUtil;
-(void) decodeWithCharacteristic: (CBCharacteristic *) characteristic;

@end
