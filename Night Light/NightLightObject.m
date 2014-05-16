//
//  NightLightObject.m
//  Night Light
//
//  Created by James Chen on 4/28/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import "NightLightObject.h"

@implementation NightLightObject
{
    CGFloat redColor;
    CGFloat greenColor;
    CGFloat blueColor;
    CGFloat alpha;
    BOOL isOn;
}

-(CGFloat) getRedColor
{
    return redColor * 255.0f;
}
-(CGFloat) getGreenColor
{
    return greenColor * 255.0f;
}
-(CGFloat) getBlueColor
{
    return blueColor * 255.0f;
}

-(void) setRedColor:(CGFloat) newRedColor
      andGreenColor:(CGFloat) newGreenColor
       andBlueColor:(CGFloat) newBlueColor
{
    redColor = newRedColor/255.0f;
    greenColor = newGreenColor/255.0f;
    blueColor = newBlueColor/255.0f;
    alpha = 1.0;
}

-(void) initNightLightWithImageView:(UIImageView*) imageView;
{
    redColor = 0.0/255.0f;
    greenColor = 122.0/255.0f;
    blueColor = 255.0/255.0f;
    alpha = 1.0f;
    isOn = YES;
    
    imageView.backgroundColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:alpha];
    _timer = [[TimerObject alloc] init];
    [_timer initLockTime];
    
}

-(void) updateNightLight:(UIImageView*) imageView
{
    imageView.backgroundColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:alpha];
}

-(void) changedColorOfLight:(UIImageView*) imageView
                    withRed:(CGFloat)newRedColor
                  withGreen:(CGFloat)newGreenColor
                   withBlue:(CGFloat)newBlueColor
{
    redColor = newRedColor/255.0f;
    greenColor = newGreenColor/255.0f;
    blueColor = newBlueColor/255.0f;
    imageView.backgroundColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:alpha];
}

-(void) setOn:(BOOL) value
{
    isOn = value;
}

-(void) turnOnOff:(UIImageView*) imageView
{
    if (isOn) {
        isOn = NO;
        imageView.backgroundColor = [UIColor blackColor];
    }
    else
    {
        isOn = YES;
        imageView.backgroundColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:alpha];
    }
}


@end
