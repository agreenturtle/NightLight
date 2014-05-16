//
//  TimerSettingsViewController.h
//  Night Light
//
//  Created by James Chen on 5/12/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerObject.h"
#import "IdleTimerObject.h"

@protocol TimerSettingsViewControllerDelegate <NSObject>
-(void) closeTimerSettingsViewController:(id) sender;
@end

@interface TimerSettingsViewController : UIViewController
@property (weak, nonatomic) id<TimerSettingsViewControllerDelegate> delegate;
@property (nonatomic) TimerObject *timer;
@property IdleTimerObject *idleTimer;

@end
