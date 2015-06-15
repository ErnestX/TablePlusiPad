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
#import "LowPassFilter.h"

#define MOTION_CHECK_INTERVAL 0.01
#define HEADING_FILTER 0.1
#define TILT_BUFFER_SIZE 20
#define ROTATE_BUFFER_SIZE 5

@implementation ShareViewController {
    ShareView* shareView;
    
    CMMotionManager* motionManager;
    CLLocationManager* locationManager;
    NSTimer* motionCheckTimer;
    
    LowPassFilter* tiltFilter;
    LowPassFilter* rotateFilter;
}

- (void) viewDidLoad
{
    shareView = (ShareView*)self.view;
    
    motionManager = [[CMMotionManager alloc]init];
    [motionManager startAccelerometerUpdates];
    motionManager.accelerometerUpdateInterval = MOTION_CHECK_INTERVAL;
    motionCheckTimer = [NSTimer scheduledTimerWithTimeInterval:MOTION_CHECK_INTERVAL target:self selector:@selector(handleTilt:) userInfo:nil repeats:YES];
    static float array1[TILT_BUFFER_SIZE];
    tiltFilter = [[LowPassFilter alloc]initBufferWithArray:array1 ofSize:TILT_BUFFER_SIZE withData:motionManager.accelerometerData.acceleration.x];

    locationManager = [[CLLocationManager alloc]init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.headingFilter = HEADING_FILTER;
    locationManager.delegate = self;
    [locationManager startUpdatingHeading];
    static float array2[ROTATE_BUFFER_SIZE];
    rotateFilter = [[LowPassFilter alloc]initBufferWithArray:array2 ofSize:ROTATE_BUFFER_SIZE withData:locationManager.heading.trueHeading];
    
    TableView* tv = [[TableView alloc]initWithFrame:CGRectZero];
    WallView* nwv = [[WallView alloc]initWithFrame:CGRectZero];
    WallView* swv = [[WallView alloc]initWithFrame:CGRectZero];
    WallView* wwv = [[WallView alloc]initWithFrame:CGRectZero];
    WallView* ewv = [[WallView alloc]initWithFrame:CGRectZero];
    [shareView customInitWithTableView:tv northWallView:nwv southWallView:swv westWallView:wwv eastWallView:ewv];
}

- (void) handleTilt:(NSTimer*) timer
{
    [shareView setTiltTo: -1 * [tiltFilter filterData:motionManager.accelerometerData.acceleration.x] * 4 :0.0];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [shareView setRotateTo:-1 * [rotateFilter filterData: newHeading.trueHeading]/360.0*2.0*M_PI]; // negate to turn to the opposite direction the iPad is turning
}

@end
