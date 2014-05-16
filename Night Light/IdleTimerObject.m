//
//  IdleTimerObject.m
//  Night Light
//
//  Created by James Chen on 5/16/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import "IdleTimerObject.h"

@implementation IdleTimerObject
{
    int idleTime;
    int maxIdleTime;
}

-(void) initIdleTimerObject
{
    idleTime = 0;
    maxIdleTime = -1;
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    //[[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    [self startTimer];
}

-(int) getIdleTime
{
    return idleTime;
}

-(int) getMaxIdleTime
{
    return maxIdleTime;
}

-(void) setMaxIdleTime:(int) newMaxIdleTime
{
    maxIdleTime = newMaxIdleTime;
}

-(void) startTimer
{
    idleTime++;
    if (idleTime >= maxIdleTime) {
        [self enableIdleTimer];
    }
    [self performSelector:@selector(startTimer) withObject:self afterDelay:1.0];
}

-(void) enableIdleTimer
{
    NSLog(@"Disable");
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    //[[UIApplication sharedApplication] setIdleTimerDisabled: NO];
}

-(void) resetTimer
{
    idleTime = 0;
}



@end
