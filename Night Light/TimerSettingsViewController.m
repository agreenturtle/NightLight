//
//  TimerSettingsViewController.m
//  Night Light
//
//  Created by James Chen on 5/12/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import "TimerSettingsViewController.h"

@interface TimerSettingsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimerSettingsViewController
{
    NSArray *timeLabels;
}

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
    timeLabels = [[NSArray alloc] initWithObjects:
                  @"After 1 Minute",
                  @"After 5 Minutes",
                  @"After 10 Minutes",
                  @"After 15 Minutes",
                  @"After 30 Minutes",
                  @"After 1 Hour",
                  @"Never",
                  nil];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetIdleTimer)];
    [singleTap setNumberOfTouchesRequired:1];
    [singleTap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:singleTap];
    singleTap = nil;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return timeLabels.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    
    cell.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = timeLabels[indexPath.row];
    [self isSelectedRow:cell withIndexPath:indexPath];
    
    return cell;
}

/*-(CGFloat)tableView: (UITableView*)tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return 50.0f;
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [_timer assignLockTimeWithBattery:indexPath.row];
        [_idleTimer setMaxIdleTime:[_timer getLockTimeWithBatteryInSeconds]];
    }
    else
    {
        [_timer assignLockTimeWhileCharging:indexPath.row];
        [_idleTimer setMaxIdleTime:[_timer getLockTimeWhileChargingInSeconds]];
    }
    [_tableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"When on battery power";
    else
        return @"When plugged in charger";
}

- (IBAction)clickBack:(id)sender
{
    [self.delegate closeTimerSettingsViewController:self];
}

-(int) returnRowForSelectedTimeSetting:(enum timeSettings) currentTimeSetting
{
    switch (currentTimeSetting) {
        case oneMinute:
            return 0;
            break;
        case fiveMinutes:
            return 1;
            break;
        case tenMinutes:
            return 2;
            break;
        case fifteenMinutes:
            return 3;
            break;
        case halfAnHour:
            return 4;
            break;
        case oneHour:
            return 5;
            break;
        case never:
            return 6;
            break;
        default:
            break;
    }
}

-(void) isSelectedRow:(UITableViewCell*) cell withIndexPath:(NSIndexPath*) indexPath
{
    UIImage *checkmarkImage = [UIImage imageNamed:@"Checkmark"];
    UIImage *blankImage = [UIImage imageNamed:@"BlankImage"];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == [self returnRowForSelectedTimeSetting:_timer.lockTimeWithBattery]) {
            cell.imageView.image = checkmarkImage;
        }
        else{
            cell.imageView.image = blankImage;
        }
    }
    else
    {
        if (indexPath.row == [self returnRowForSelectedTimeSetting:_timer.lockTimeWhileCharging]){
            cell.imageView.image = checkmarkImage;
        }
        else{
            cell.imageView.image = blankImage;
        }
    }
}

-(void) resetIdleTimer
{
    [_idleTimer resetTimer];
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
