//
//  ProbelConnector.m
//  MyBaking
//
//  Created by lei on 12/3/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "ProbelConnector.h"
#import "ProbelUtil.h"

@interface ProbelConnector () <CBCentralManagerDelegate, CBPeripheralDelegate> {
    ProbelUtil *_probelUtil;
    
    CBCentralManager *_manager;
    CBPeripheral *_peripheral;
    NSMutableData *_data;
}
@end

@implementation ProbelConnector

+(instancetype)sharedProelConnector {
    static ProbelConnector *instance;
    
    if (!instance) {
        instance = [[ProbelConnector alloc] init];
    }
    return instance;
}

-(instancetype)init  {
    
    if (self = [super init]) {
        _probelUtil = [ProbelUtil sharedProbelUtil];
    }
    return self;
}

-(void)startConnector {
    static BOOL start = NO;
    if (!start) {
        _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        start = YES;
    }
}

#pragma mark ------ CBCentralManagerDelegate --------
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSMutableArray *uuids = [NSMutableArray array];
    
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            for (NSString *kServiceUUID in _probelUtil.kServiceUUIDs) {
                [uuids addObject:[CBUUID UUIDWithString:kServiceUUID]];
            }
            [_manager scanForPeripheralsWithServices:uuids options:@{CBCentralManagerScanOptionAllowDuplicatesKey: @YES}];
            break;
        default:
            NSLog(@"central manager did change state %@", central);
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    // stop scan;
    NSLog(@"did discover peripheral");
    [central stopScan];
    
    if (_peripheral != peripheral) {
        _peripheral = peripheral;
        [_manager connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"did connect peripheral %@", peripheral);
    
    NSMutableArray *uuids = [NSMutableArray array];
    for (NSString *kServiceUUID in _probelUtil.kServiceUUIDs) {
        [uuids addObject:[CBUUID UUIDWithString:kServiceUUID]];
    }
    
    [_data setLength:0];
    [_peripheral setDelegate:self];
    [_peripheral discoverServices:uuids];
}
#pragma mark -------- CBPeripheralDelegate -----
- (void)peripheral:(CBPeripheral *)aPeripheral didDiscoverServices:(NSError *)error {
    if (error) {
        NSLog(@"Error discovering service: %@", [error localizedDescription]);
        return;
    }
    for (CBService *service in aPeripheral.services) {
        for (NSString *kServiceUUID in _probelUtil.kServiceUUIDs) {
            CBUUID *uuid = [CBUUID UUIDWithString:kServiceUUID];
            if ([service.UUID isEqual:uuid]) {
                NSMutableArray *characteristicUUIDs = [NSMutableArray array];
                for (NSString *kCharacteristicUUID in _probelUtil.kCharacteristicUUIDs) {
                    [characteristicUUIDs addObject:[CBUUID UUIDWithString:kCharacteristicUUID]];
                }
                [aPeripheral discoverCharacteristics:characteristicUUIDs forService:service];
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@"Error discovering characteristic: %@", [error localizedDescription]);
        return;
    }
    NSMutableArray *serviceUUIDs = [NSMutableArray array];
    NSMutableArray *characteristicUUIDs = [NSMutableArray array];
    
    for (NSString *kServiceUUID in _probelUtil.kServiceUUIDs) {
        [serviceUUIDs addObject:[CBUUID UUIDWithString:kServiceUUID]];
    }
    for (NSString *kCharacteristicUUID in _probelUtil.kCharacteristicUUIDs) {
        [characteristicUUIDs addObject:[CBUUID UUIDWithString:kCharacteristicUUID]];
    }
    
    for (CBUUID *serviceUUID in serviceUUIDs) {
        if ([service.UUID isEqual:serviceUUID]) {
            for (CBCharacteristic *characteristic in service.characteristics) {
                for (CBUUID *characteristicUUID in characteristicUUIDs) {
                    if ([characteristic.UUID isEqual:characteristicUUID]) {
                        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                    }
                }
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    [_probelUtil decodeWithCharacteristic:characteristic];
}

@end
