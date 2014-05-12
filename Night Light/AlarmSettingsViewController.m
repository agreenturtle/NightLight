//
//  TimerSettingsViewController.m
//  Night Light
//
//  Created by James Chen on 4/29/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import "AlarmSettingsViewController.h"

@interface AlarmSettingsViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *alarmPicker;
@property (nonatomic) UISwitch *enableAlarmSwitch;
@property (nonatomic) UITableViewCell *alarmTimeCell;
@end

@implementation AlarmSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    if (indexPath.row == 0)
    {
        _alarmTimeCell = cell;
        cell.textLabel.text = @"Alarm Time";
        cell.detailTextLabel.text = [_clock getCurrentTime];
        [_clock.alarm setPickerToCurrentTime:_alarmPicker];
    }
    else
    {
        _enableAlarmSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        if (_clock.alarm.alarmSwitchIsOn){
            [_enableAlarmSwitch setOn:YES animated:YES];
        }
        else{
            [_enableAlarmSwitch setOn:NO animated:YES];
        }
        [_enableAlarmSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.textLabel.text = @"Enable Alarm";
        cell.detailTextLabel.text = @"";
        cell.accessoryView = _enableAlarmSwitch;
    }
    return cell;
}

-(CGFloat)tableView: (UITableView*)tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Do Nothing For Now
}


-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 12;
            break;
        case 1:
            return 60;
            break;
        case 2:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *intString;
    if (component == 0) {
        if (row < 9) {
            intString = [NSString stringWithFormat:@"0%d",(int)row+1];
        }
        else{
            intString = [NSString stringWithFormat:@"%d", (int)row+1];
        }
        return intString;
    }
    else if (component == 1){
        if (row < 10) {
            intString = [NSString stringWithFormat:@"0%d",(int)row];
        }
        else{
            intString = [NSString stringWithFormat:@"%d", (int)row];
        }
        return intString;
    }
    else{
        if (row == 0) {
            return @"AM";
        }
        else
            return @"PM";
    }
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_clock.alarm updateTimeLabel:_alarmTimeCell withPickerView:_alarmPicker];
}

- (void) switchChanged:(id)sender {
    //Do Nothing For Now
}

- (IBAction)clickCancel:(id)sender
{
    [self.delegate closeAlarmSettingsViewController:self];
}

- (IBAction)clickSave:(id)sender
{
    [_clock.alarm setAlarmTime:_alarmTimeCell.detailTextLabel.text];
    if(_enableAlarmSwitch.on)
        _clock.alarm.alarmSwitchIsOn = YES;
    else
        _clock.alarm.alarmSwitchIsOn = NO;
    
    [self.delegate closeAlarmSettingsViewController:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
