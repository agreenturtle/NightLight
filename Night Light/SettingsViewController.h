//
//  SettingsViewController.h
//  Night Light
//
//  Created by James Chen on 4/25/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NightLightObject.h"
#import "AlarmSettingsViewController.h"
#import "TimerSettingsViewController.h"
#import "ClockObject.h"

@protocol SettingsViewControllerDelegate <NSObject>
-(void) closeSettingsViewController:(id)sender;
@end

@interface SettingsViewController : UIViewController <AlarmSettingsViewControllerDelegate, TimerSettingsViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;

@property NightLightObject *nightLight;
@property ClockObject *clock;
@end
