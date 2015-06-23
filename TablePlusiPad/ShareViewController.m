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
#define HEADING_CHECK_INTERVAL 0.01

#define TILT_BUFFER_SIZE 20
#define ROTATE_BUFFER_SIZE 10

@implementation ShareViewController {
    ShareView* shareView;
    
    CMMotionManager* motionManager;
    CLLocationManager* locationManager;
    NSTimer* motionCheckTimer;
    NSTimer* headingCheckTimer;
    
    LowPassFilter* tiltFilter;
    LowPassFilter* rotateFilter;
    
    TableView* tableView;
    WallView* northWallView;
    WallView* southWallView;
    WallView* westWallView;
    WallView* eastWallView;
}

- (void) viewDidLoad
{
    shareView = (ShareView*)self.view;
    
    motionManager = [[CMMotionManager alloc]init];
    motionManager.accelerometerUpdateInterval = MOTION_CHECK_INTERVAL;
    [motionManager startAccelerometerUpdates];
    motionCheckTimer = [NSTimer scheduledTimerWithTimeInterval:MOTION_CHECK_INTERVAL target:self selector:@selector(handleTilt:) userInfo:nil repeats:YES];
    static float array1[TILT_BUFFER_SIZE];
    tiltFilter = [[LowPassFilter alloc]initBufferWithArray:array1 ofSize:TILT_BUFFER_SIZE withData:motionManager.accelerometerData.acceleration.x];

    locationManager = [[CLLocationManager alloc]init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.headingFilter = HEADING_FILTER;
    [locationManager startUpdatingHeading];
    headingCheckTimer = [NSTimer scheduledTimerWithTimeInterval:HEADING_CHECK_INTERVAL target:self selector:@selector(updateHeading:) userInfo:nil repeats:YES];
    static float array2[ROTATE_BUFFER_SIZE];
    rotateFilter = [[LowPassFilter alloc]initBufferWithArray:array2 ofSize:ROTATE_BUFFER_SIZE withData:locationManager.heading.trueHeading];
    
    tableView = [[TableView alloc]initWithFrame:CGRectZero];
    northWallView = [[WallView alloc]initWithFrame:CGRectZero];
    southWallView = [[WallView alloc]initWithFrame:CGRectZero];
    westWallView = [[WallView alloc]initWithFrame:CGRectZero];
    eastWallView = [[WallView alloc]initWithFrame:CGRectZero];
    
    northWallView.delegate = self;
    southWallView.delegate = self;
    westWallView.delegate = self;
    eastWallView.delegate = self;
    
    [shareView customInitWithTableView:tableView northWallView:northWallView southWallView:southWallView westWallView:westWallView eastWallView:eastWallView];
}

- (void) handleTilt:(NSTimer*) timer
{
    [shareView setTiltTo: -1 * [tiltFilter filterData:motionManager.accelerometerData.acceleration.x] * 4 :0.0];
}

- (void)updateHeading: (NSTimer*) timer
{
    static float oldH = 0.0;
    float newH = locationManager.heading.trueHeading;
    
    while ((newH - oldH) > 180.0) {
        newH -= 360;
    }
    while ((newH - oldH) < -180) {
        newH += 360;
    }
    
    oldH = newH;
    
    [shareView setRotationTo:[rotateFilter filterData: newH]/360.0*2.0*M_PI]; // negate to turn to the opposite direction the iPad is turning
}

- (void)testButtonPressed:(UIView*)view
{
    if (view == northWallView) {
        NSLog(@"north test button pressed");
    } else if (view == southWallView) {
        NSLog(@"south test button pressed");
    } else if (view == westWallView) {
        NSLog(@"west test button pressed");
    } else if (view == eastWallView) {
        NSLog(@"east test button pressed");
    }
}

@end
