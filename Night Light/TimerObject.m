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
    _lockTimeWithBattery = 5;
    _lockTimeWhileCharging = 0;
}

-(void) setLockTimeWithBattery:(enum timeSettings)lockTimeWithBattery
{
    _lockTimeWithBattery = lockTimeWithBattery;
}

-(void) setLockTimeWhileCharging:(enum timeSettings)lockTimeWhileCharging
{
    _lockTimeWhileCharging = lockTimeWhileCharging;
}


@end
