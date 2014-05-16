//
//  IdleTimerObject.h
//  Night Light
//
//  Created by James Chen on 5/16/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IdleTimerObject : NSObject

-(void) initIdleTimerObject;
-(void) setMaxIdleTime:(int) newMaxIdleTime;
-(int) getIdleTime;
-(int) getMaxIdleTime;

-(void) resetTimer;

@end
