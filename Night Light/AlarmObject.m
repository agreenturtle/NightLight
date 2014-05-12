//
//  AlarmObject.m
//  Night Light
//
//  Created by James Chen on 5/12/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import "AlarmObject.h"

@implementation AlarmObject
{
    NSString *alarmTime;
    CGFloat alpha;
}

-(void) initAlarmObject
{
    alarmTime = @"";
    _alarmSwitchIsOn = NO;
    _alarmIsActivated = NO;
}

-(NSString*) getAlarmTime
{
    return alarmTime;
}

-(void) setPickerToCurrentTime:(UIPickerView *)pickerView
{
    //Get the current Time
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"hh:mm a"];
    NSString *currentTime = [dateFormat stringFromDate:[NSDate date]];
    
    //Get Hours
    NSArray *stringParts = [currentTime componentsSeparatedByString:@":"];
    NSString *timePart = stringParts[0];
    int hours = [timePart intValue];
    hours--;
    [pickerView selectRow:hours inComponent:0 animated:NO];
    
    //Get Minutes
    timePart = stringParts[1];
    NSString *minutesPart = [timePart substringToIndex:2];
    int minutes = [minutesPart intValue];
    [pickerView selectRow:minutes inComponent:1 animated:NO];
    
    //Get time period
    NSArray *parts = [timePart componentsSeparatedByString:@" "];
    NSString *timePeriodPart = parts[1];
    if([timePeriodPart isEqualToString:@"AM"])
    {
        [pickerView selectRow:0 inComponent:2 animated:NO];
    }
    else
    {
        [pickerView selectRow:1 inComponent:2 animated:NO];
    }
}

-(void) setAlarmTime:(NSString*) timeAlarmToTurnOn
{
    alarmTime = timeAlarmToTurnOn;
}

-(void) updateAlarmImage:(UIImageView*) imageView
{
    if (_alarmSwitchIsOn)
    {
        UIImage *image = [UIImage imageNamed: @"AlarmImage"];
        imageView.image = image;
    }
    else{
        imageView.image = nil;
        imageView.backgroundColor = [UIColor clearColor];
    }
}

-(void) updateTimeLabel:(UITableViewCell*) timeLabel withPickerView: (UIPickerView*) pickerView
{
    NSInteger hours = [pickerView selectedRowInComponent:0];
    NSInteger minutes = [pickerView selectedRowInComponent:1];
    NSInteger timePeriod = [pickerView selectedRowInComponent:2];
    hours++;
    
    NSString *hourString;
    if (hours < 10) {
        hourString = [NSString stringWithFormat:@"0%d", (int)hours];
    }
    else{
        hourString = [NSString stringWithFormat:@"%d", (int)hours];
    }
    NSString *minutesString;
    if (minutes < 10){
        minutesString = [NSString stringWithFormat:@"0%d", (int)minutes];
    }
    else{
        minutesString = [NSString stringWithFormat:@"%d", (int)minutes];
    }
    NSString *timePeriodString;
    if (timePeriod == 0){
        timePeriodString = @"AM";
    }
    else{
        timePeriodString = @"PM";
    }
    
    timeLabel.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@ %@", hourString, minutesString, timePeriodString];
}

-(BOOL) shouldAlarmTurnOn
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"hh:mm a"];
    NSString *currentTime = [dateFormat stringFromDate:[NSDate date]];
    
    if (_alarmSwitchIsOn && !_alarmIsActivated)
    {
        NSLog(@"----DEBUG: alarmSwitchIsOn && !_alarmIsAtivated");
        NSLog(@"----DEBUG: currentTime: (%@), alarmTime: (%@)", currentTime,alarmTime);
        if ([currentTime isEqualToString:alarmTime]) {
            _alarmIsActivated = YES;
            return YES;
        }
    }
    return NO;
}

-(void) turnOffAlarm
{
    _alarmIsActivated = NO;
    _alarmSwitchIsOn = NO;
}

-(void) snoozeAlarm
{
    _alarmIsActivated = NO;
    _alarmSwitchIsOn = YES;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"hh:mm a"];
    NSString *currentTime = [dateFormat stringFromDate:[NSDate date]];
    
    //Get Hours
    NSArray *stringParts = [currentTime componentsSeparatedByString:@":"];
    NSString *timePart = stringParts[0];
    int hours = [timePart intValue];
    NSString *hourString;
    if (hours < 10)
        hourString = [NSString stringWithFormat:@"0%i", hours];
    else
        hourString = [NSString stringWithFormat:@"%i", hours];
    
    //Get Minutes
    timePart = stringParts[1];
    NSString *minutesPart = [timePart substringToIndex:2];
    int minutes = [minutesPart intValue];
    minutes = minutes + 10;
    
    NSString *minuteString;
    if (minutes < 10 && minutes > 0)
        minuteString = [NSString stringWithFormat:@"0%i", minutes];
    else if (minutes >= 10 && minutes < 60)
        minuteString = [NSString stringWithFormat:@"%i", minutes];
    else if (minutes >= 60)
    {
        minutes = minutes - 60;
        if (minutes == 0) // :00
            minuteString = @"00";
        else if (minutes < 10 && minutes > 0) // :01-:09
            minuteString = [NSString stringWithFormat:@"0%i", minutes];
        else if (minutes >= 10 && minutes < 60)// :10-59
            minuteString = [NSString stringWithFormat:@"%i", minutes];
        
        hours = hours + 1;
        if (hours < 10)
            hourString = [NSString stringWithFormat:@"0%i", hours];
        else if (hours <= 12)
            hourString = [NSString stringWithFormat:@"%i", hours];
        else if (hours == 13)
            hourString = @"01";
    }
    
    //Get time period
    NSArray *parts = [timePart componentsSeparatedByString:@" "];
    NSString *timePeriodPart = parts[1];
    
    
    alarmTime = [NSString stringWithFormat:@"%@:%@ %@", hourString, minuteString, timePeriodPart];
    NSLog(@"snooze - alarm time: %@", alarmTime);
}

@end
