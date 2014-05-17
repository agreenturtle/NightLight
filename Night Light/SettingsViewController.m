//
//  SettingsViewController.m
//  Night Light
//
//  Created by James Chen on 4/25/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *timeTableView;

@end

@implementation SettingsViewController
{
    CGFloat redColor;
    CGFloat greenColor;
    CGFloat blueColor;
    CGFloat alpha;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_idleTimer resetTimer];
    
    _redSlider.value = [_nightLight getRedColor];
    _greenSlider.value = [_nightLight getGreenColor];
    _blueSlider.value = [_nightLight getBlueColor];
    
    redColor = _redSlider.value/255.0f;
    greenColor = _greenSlider.value/255.0f;
    blueColor = _blueSlider.value/255.0f;
    
    [_redSlider addTarget:self action:@selector(sliderHasChanged:) forControlEvents:UIControlEventValueChanged];
    [_greenSlider addTarget:self action:@selector(sliderHasChanged:) forControlEvents:UIControlEventValueChanged];
    [_blueSlider addTarget:self action:@selector(sliderHasChanged:) forControlEvents:UIControlEventValueChanged];
    
    _imageView.backgroundColor = [UIColor clearColor];
    [self updatePreviewImage];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetIdleTimer)];
    [singleTap setNumberOfTouchesRequired:1];
    [singleTap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:singleTap];
    singleTap = nil;
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
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    
    cell.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.row == 0)
    {
        if (_clock.alarm.alarmSwitchIsOn)
        {
            cell.textLabel.enabled = YES;
            cell.textLabel.text = @"Alarm Time";
            NSString *alarmTime = [_clock.alarm getAlarmTime];
            cell.detailTextLabel.text = alarmTime;
        }
        else{
            cell.textLabel.enabled = NO;
            cell.textLabel.text = @"Alarm Time";
            cell.detailTextLabel.text = @"OFF";
        }
    }
    else
    {
        cell.textLabel.enabled = YES;
        cell.textLabel.text = @"Auto-Lock";
        cell.detailTextLabel.text = @"";
    }
    
    
    return cell;
}

-(CGFloat)tableView: (UITableView*)tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"alarmSettingSegue" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"timerSettingSegue" sender:self];
    }
    
}



-(void) updatePreviewImage
{
    UIGraphicsBeginImageContext(_imageView.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 30.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), redColor, greenColor, blueColor, alpha);
    //CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, alpha);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),37, 37);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),37, 37);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void) sliderHasChanged:(id)sender
{
    UISlider *currentSlider = sender;
    UIGraphicsBeginImageContext(_imageView.frame.size);
    switch (currentSlider.tag) {
        case 0:
            redColor = currentSlider.value/255.0f;
            break;
        case 1:
            greenColor = currentSlider.value/255.0f;
            break;
        case 2:
            blueColor = currentSlider.value/255.0f;
            break;
        default:
            break;
    }
    [self updatePreviewImage];
}

- (IBAction)clickBack:(id)sender
{
    [_nightLight setRedColor:_redSlider.value
               andGreenColor:_greenSlider.value
                andBlueColor:_blueSlider.value];
    [self.delegate closeSettingsViewController:self];
}

-(void) resetIdleTimer
{
    [_idleTimer resetTimer];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"alarmSettingSegue"])
    {
        AlarmSettingsViewController *nextVC = [segue destinationViewController];
        
        [nextVC setDelegate:self];
        [nextVC setClock:_clock];
        [nextVC setIdleTimer:_idleTimer];
    }
    else
    {
        TimerSettingsViewController *nextVC = [segue destinationViewController];
        
        [nextVC setDelegate:self];
        [nextVC setTimer:_nightLight.timer];
        [nextVC setIdleTimer:_idleTimer];
    }
    
}

-(void) closeAlarmSettingsViewController:(id)sender
{
    _clock = ((AlarmSettingsViewController*)sender).clock;
    [_timeTableView reloadData];
    [_idleTimer resetTimer];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) closeTimerSettingsViewController:(id)sender
{
    [_idleTimer resetTimer];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
