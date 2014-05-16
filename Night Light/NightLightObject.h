//
//  NightLightObject.h
//  Night Light
//
//  Created by James Chen on 4/28/14.
//  Copyright (c) 2014 James Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerObject.h"

@interface NightLightObject : NSObject
@property (nonatomic) TimerObject *timer;

-(CGFloat) getRedColor;
-(CGFloat) getGreenColor;
-(CGFloat) getBlueColor;

-(void) initNightLightWithImageView:(UIImageView*) imageView;

-(void) setOn:(BOOL) value;
-(void) setRedColor:(CGFloat)newRedColor
      andGreenColor:(CGFloat) newGreenColor
       andBlueColor:(CGFloat) newBlueColor;

-(void) updateNightLight:(UIImageView*) imageView;
-(void) turnOnOff:(UIImageView*) imageView;
-(void) changedColorOfLight:(UIImageView*) imageView
                    withRed:(CGFloat)newRedColor
                  withGreen:(CGFloat)newGreenColor
                   withBlue:(CGFloat)newBlueColor;

@end
