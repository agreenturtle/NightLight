//
//  TimerObject.m
//  Night Light
//
//  Created by James Chen on 5/12/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import "TimerObject.h"

@implementation TimerObject
-(void) initLockTime
{
    _lockTimeWithBattery = oneMinute;
    _lockTimeWhileCharging = never;
}

-(int) getLockTimeWithBatteryInSeconds
{
    switch (_lockTimeWithBattery) {
        case oneMinute:
            return 5;
            break;
        case fiveMinutes:
            return 300;
            break;
        case tenMinutes:
            return 600;
            break;
        case fifteenMinutes:
            return 900;
            break;
        case halfAnHour:
            return 1800;
            break;
        case oneHour:
            return 3600;
            break;
        case never:
            return -1;
            break;
        default:
            NSLog(@"**ERROR: Unable to get time in seconds");
            break;
    }
}

-(int) getLockTimeWhileChargingInSeconds
{
    switch (_lockTimeWhileCharging) {
        case oneMinute:
            return 60;
            break;
        case fiveMinutes:
            return 300;
            break;
        case tenMinutes:
            return 600;
            break;
        case fifteenMinutes:
            return 900;
            break;
        case halfAnHour:
            return 1800;
            break;
        case oneHour:
            return 3600;
            break;
        case never:
            return -1;
            break;
        default:
            NSLog(@"**ERROR: Unable to get time in seconds");
            break;
    }
}

-(void) assignLockTimeWithBattery:(int)selectedRow
{
    switch (selectedRow) {
        case 0:
            _lockTimeWithBattery = oneMinute;
            break;
        case 1:
            _lockTimeWithBattery = fiveMinutes;
            break;
        case 2:
            _lockTimeWithBattery = tenMinutes;
            break;
        case 3:
            _lockTimeWithBattery = fifteenMinutes;
            break;
        case 4:
            _lockTimeWithBattery = halfAnHour;
            break;
        case 5:
            _lockTimeWithBattery = oneHour;
            break;
        case 6:
            _lockTimeWithBattery = never;
            break;
        default:
            NSLog(@"**ERROR: Invalid row (%i) was chosen for timer while on battery", selectedRow);
            break;
    }
}

-(void) assignLockTimeWhileCharging:(int)selectedRow;
{
    switch (selectedRow) {
        case 0:
            _lockTimeWhileCharging = oneMinute;
            break;
        case 1:
            _lockTimeWhileCharging = fiveMinutes;
            break;
        case 2:
            _lockTimeWhileCharging = tenMinutes;
            break;
        case 3:
            _lockTimeWhileCharging = fifteenMinutes;
            break;
        case 4:
            _lockTimeWhileCharging = halfAnHour;
            break;
        case 5:
            _lockTimeWhileCharging = oneHour;
            break;
        case 6:
            _lockTimeWhileCharging = never;
            break;
        default:
            NSLog(@"**ERROR: Invalid row (%i) was chosen for timer while charging", selectedRow);
            break;
    }
}


@end
