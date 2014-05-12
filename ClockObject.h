//
//  ClockObject.h
//  Night Light
//
//  Created by James Chen on 4/29/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlarmObject.h"

@interface ClockObject : NSObject
@property AlarmObject *alarm;
-(void) initClockObject;
-(NSString*) getCurrentTime;

-(void) updateClock:(UILabel*) clockLabel;
@end
