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

#define WALL_HEIGHT 400
#define TABLE_WIDTH 400
#define TABLE_HEIGHT 300

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
    
    TableView* tv = [[TableView alloc]initWithFrame:CGRectMake(0, 0, TABLE_WIDTH, TABLE_HEIGHT)];
    tv.center = self.view.center;
    WallView* nwv = [[WallView alloc]initWithFrame:CGRectMake(0, 0, TABLE_WIDTH, WALL_HEIGHT)];
    nwv.layer.anchorPoint = CGPointMake(0.5, 1);
    nwv.center = self.view.center;
    WallView* swv = [[WallView alloc]initWithFrame:CGRectMake(0, 0, TABLE_WIDTH, WALL_HEIGHT)];
    swv.layer.anchorPoint = CGPointMake(0.5, 0);
    swv.center = self.view.center;
    WallView* wwv = [[WallView alloc]initWithFrame:CGRectMake(0, 0, WALL_HEIGHT, TABLE_HEIGHT)];
    wwv.layer.anchorPoint = CGPointMake(1, 0.5);
    wwv.center = self.view.center;
    WallView* ewv = [[WallView alloc]initWithFrame:CGRectMake(0, 0, WALL_HEIGHT, TABLE_HEIGHT)];
    ewv.layer.anchorPoint = CGPointMake(0, 0.5);
    ewv.center = self.view.center;
    tv.backgroundColor = [UIColor lightGrayColor];
    nwv.backgroundColor = [UIColor redColor];
    swv.backgroundColor = [UIColor blueColor];
    wwv.backgroundColor = [UIColor greenColor];
    ewv.backgroundColor = [UIColor yellowColor];
    
    [shareView customInitWithTableView:tv northWallView:nwv southWallView:swv westWallView:wwv eastWallView:ewv];
}

- (void) handleTilt:(NSTimer*) timer
{
    [shareView setTiltTo: -1 * [tiltFilter filterData:motionManager.accelerometerData.acceleration.x] * 1.5 :0.0];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [shareView setRotateTo:-1 * [rotateFilter filterData: newHeading.trueHeading]/360*2*M_PI]; // negate to turn to the opposite direction the iPad is turning
}

@end
