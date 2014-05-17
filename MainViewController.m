//
//  MainViewController.m
//  Night Light
//
//  Created by James Chen on 4/25/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel;

@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timerImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alarmOffSwitchBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *snoozeBottomConstraint;

@end

@implementation MainViewController
{
    CGFloat redColor;
    CGFloat greenColor;
    CGFloat blueColor;
    CGFloat alpha;
    
    NightLightObject *nightLight;
    ClockObject *clock;
    IdleTimerObject *idleTimer;
}

- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    [self updateTime];
    [super viewDidLoad];
    nightLight = [[NightLightObject alloc] init];
    [nightLight initNightLightWithImageView:_imageView];
    alpha = 1.0f;
    
    clock = [[ClockObject alloc] init];
    [clock initClockObject];
    [clock updateClock:_clockLabel];
    
    idleTimer = [[IdleTimerObject alloc] init];
    [idleTimer initIdleTimerObject];
    
    _directionLabel.text = @"Touch to turn off";
    _timerImageView.backgroundColor = [UIColor clearColor];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetIdleTimer)];
    [singleTap setNumberOfTouchesRequired:1];
    [singleTap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:singleTap];
    singleTap = nil;
    
    [[NSNotificationCenter defaultCenter] addObserverForName: UIApplicationWillEnterForegroundNotification object: nil queue: [NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [idleTimer resetTimer];
    }];
    
    
    [idleTimer setMaxIdleTime:[nightLight.timer getLockTimeWithBatteryInSeconds]];
    
    //UIDeviceBatteryState currentState = [[UIDevice currentDevice] batteryState];
    //if (currentState == UIDeviceBatteryStateCharging || currentState == UIDeviceBatteryStateFull) {
        // The battery is either charging, or connected to a charger and is fully charged
        
    //}
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
/**************************************************************************/
- (IBAction)clickToggle:(id)sender
{
    _directionLabel.text = @"";
    AudioServicesPlaySystemSound(1105);
    [nightLight turnOnOff:_imageView];
}

- (IBAction)clickAlarmOff:(id)sender
{
    [clock.alarm turnOffAlarm];
    [self alarmButtonViewHide];
}
- (IBAction)clickSnooze
{
    [clock.alarm snoozeAlarm];
    [self alarmButtonViewHide];
}

-(void) updateTime
{
    if ([clock.alarm shouldAlarmTurnOn])
    {
        [self activateAlarm];
    }
    [clock updateClock:_clockLabel];
    int temp = [idleTimer getIdleTime];
    int temp2 = [idleTimer getMaxIdleTime];
    NSLog(@"--Idle time: %i with max idle time: %i", temp, temp2);
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
}

-(void) activateAlarm
{
    if (clock.alarm.alarmIsActivated)
    {
        [self alarmButtonViewShow];
        AudioServicesPlaySystemSound(1005);
        [self performSelector:@selector(activateAlarm) withObject:self afterDelay:2.0];
    }
}


- (void) alarmButtonViewShow
{
    NSTimeInterval animationDuration = 0.7;
    
    _alarmOffSwitchBottomConstraint.constant = 504 - 44; //Original Height of Constraint - Height of "Off Button View"
    _snoozeBottomConstraint.constant = 20 + 50;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void) alarmButtonViewHide
{
    
    NSTimeInterval animationDuration = 0.7;
    
    _alarmOffSwitchBottomConstraint.constant = 504;
    _snoozeBottomConstraint.constant = 20;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void) resetIdleTimer
{
    [idleTimer resetTimer];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(motion == UIEventSubtypeMotionShake)
    {
        if(clock.alarm.alarmIsActivated == YES)
            [self clickSnooze];
    }
}

-(void) closeSettingsViewController:(id)sender
{
    nightLight = ((SettingsViewController*)sender).nightLight;
    clock = ((SettingsViewController*)sender).clock;
    [nightLight setOn:YES];
    [nightLight updateNightLight:_imageView];
    
    [clock.alarm updateAlarmImage:_timerImageView];
    [idleTimer resetTimer];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SettingsViewController *nextVC = [segue destinationViewController];
    
    [nextVC setNightLight:nightLight];
    [nextVC setDelegate:self];
    [nextVC setClock:clock];
    [nextVC setIdleTimer:idleTimer];
}

@end
