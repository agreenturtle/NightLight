//
//  AlarmObject.h
//  Night Light
//
//  Created by James Chen on 5/12/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmObject : NSObject
@property BOOL alarmSwitchIsOn;
@property BOOL alarmIsActivated;

-(void) initAlarmObject;

-(NSString*) getAlarmTime;

-(void) setAlarmTime:(NSString*) timeAlarmToTurnOn;
-(void) setPickerToCurrentTime:(UIPickerView*) pickerView;

-(BOOL) shouldAlarmTurnOn;
-(void) turnOffAlarm;
-(void) snoozeAlarm;

-(void) updateAlarmImage:(UIImageView*) imageView;
-(void) updateTimeLabel:(UITableViewCell*) timeLabel withPickerView: (UIPickerView*) pickerView;
@end
