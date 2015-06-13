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
#define WALL_HEIGHT 400
#define TABLE_WIDTH 400
#define TABLE_HEIGHT 300

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
    
    TableView* tv = [[TableView alloc]initWithFrame:CGRectMake(0, 0, TABLE_WIDTH, TABLE_HEIGHT)];
    tv.center = self.view.center;
    tv.backgroundColor = [UIColor lightGrayColor];
    WallView* nwv = [[WallView alloc]initWithFrame:CGRectMake(0, 0, TABLE_WIDTH, WALL_HEIGHT)];
    nwv.center = self.view.center;
    WallView* swv = [[WallView alloc]initWithFrame:CGRectMake(0, 0, TABLE_WIDTH, WALL_HEIGHT)];
    swv.center = self.view.center;
    WallView* wwv = [[WallView alloc]initWithFrame:CGRectMake(0, 0, WALL_HEIGHT, TABLE_HEIGHT)];
    wwv.center = self.view.center;
    WallView* ewv = [[WallView alloc]initWithFrame:CGRectMake(0, 0, WALL_HEIGHT, TABLE_HEIGHT)];
    ewv.center = self.view.center;
    nwv.backgroundColor = [UIColor redColor];
    swv.backgroundColor = [UIColor blueColor];
    wwv.backgroundColor = [UIColor greenColor];
    ewv.backgroundColor = [UIColor yellowColor];
    
    [shareView customInitWithTableView:tv northWallView:nwv southWallView:swv westWallView:wwv eastWallView:ewv];
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
