//
//  shareViewController.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>
#import "ShareViewController.h"
#import "ShareView.h"

#define MOTION_CHECK_INTERVAL 0.1

@implementation ShareViewController {
    CMMotionManager* motionManager;
    CLLocationManager* locationManager;
    NSTimer* motionCheckTimer;
    ShareView* shareView;
}

- (void) viewDidLoad
{
    motionManager = [[CMMotionManager alloc]init];
    [motionManager startAccelerometerUpdates];
    motionManager.accelerometerUpdateInterval = MOTION_CHECK_INTERVAL;
    motionCheckTimer = [NSTimer scheduledTimerWithTimeInterval:MOTION_CHECK_INTERVAL target:self selector:@selector(handleTilt:) userInfo:nil repeats:YES];

    locationManager = [[CLLocationManager alloc]init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingHeading];
    
    shareView = (ShareView*)self.view;
    [shareView customInit];
}

- (void) handleTilt:(NSTimer*) timer
{
    [shareView tiltTo:motionManager.accelerometerData.acceleration.x * 1.5 : motionManager.accelerometerData.acceleration.y * 1.5];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [shareView rotateTo:-1 * newHeading.trueHeading/360*2*M_PI]; // negate to turn to the opposite direction the iPad is turning
}

@end
