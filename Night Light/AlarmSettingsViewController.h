//
//  TimerSettingsViewController.h
//  Night Light
//
//  Created by James Chen on 4/29/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockObject.h"
@protocol AlarmSettingsViewControllerDelegate <NSObject>
-(void) closeAlarmSettingsViewController:(id)sender;
@end

@interface AlarmSettingsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id<AlarmSettingsViewControllerDelegate> delegate;

@property (nonatomic) ClockObject *clock;

@end
