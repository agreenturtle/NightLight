//
//  ClockObject.m
//  Night Light
//
//  Created by James Chen on 4/29/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import "ClockObject.h"

@implementation ClockObject
{
    //NSString *currentTime;
    NSString *alarmTime;
}

-(void) initClockObject
{
    _alarm = [[AlarmObject alloc] init];
    [_alarm initAlarmObject];
}

-(NSString*) getCurrentTime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"hh:mm a"];
    return [dateFormat stringFromDate:[NSDate date]];
}


-(void) updateClock:(UILabel *)clockLabel
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"hh:mm:ss a"];
    clockLabel.text = [dateFormat stringFromDate:[NSDate date]];
}


@end
