//
//  TimerObject.h
//  Night Light
//
//  Created by James Chen on 5/12/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerObject : NSObject
enum timeSettings
{
    oneMinute, //one is for testing purposes only
    fiveMinutes,
    tenMinutes,
    fifteenMinutes,
    halfAnHour,
    oneHour,
    never
};

@property (nonatomic) enum timeSettings lockTimeWithBattery;
@property (nonatomic) enum timeSettings lockTimeWhileCharging;

-(void) initLockTime;

-(void) assignLockTimeWithBattery:(int)selectedRow;
-(void) assignLockTimeWhileCharging:(int)selectedRow;

-(int) getLockTimeWithBatteryInSeconds;
-(int) getLockTimeWhileChargingInSeconds;
@end
