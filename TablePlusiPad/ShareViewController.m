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

#define MOTION_CHECK_INTERVAL 0.01
#define WALL_HEIGHT 400
#define TABLE_WIDTH 400
#define TABLE_HEIGHT 300

#define BUFFER_SIZE 20

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
    // apply low-pass noise filter
    static float buffer[BUFFER_SIZE];  // a circular array
    static BOOL bufferInited = NO;
    static NSInteger currentBufferSlot = 0;
    
    // init buffer
    if (!bufferInited) {
        for (NSInteger i = 0; i < BUFFER_SIZE; i++){
            buffer[i] = motionManager.accelerometerData.acceleration.x;
        }
        bufferInited = YES;
    }
    
    float newAccel = motionManager.accelerometerData.acceleration.x;
    buffer[currentBufferSlot] = newAccel;
    float sum = 0;
    for (NSInteger i = 0; i < BUFFER_SIZE; i++) {
        sum += buffer[i];
    }
    float filteredNewAccel = sum / BUFFER_SIZE;
    
    [shareView tiltTo: -1 * filteredNewAccel * 1.5 :0.0];
    
    currentBufferSlot = (currentBufferSlot + 1) % BUFFER_SIZE;
//    NSLog(@"current buffer slot %d", currentBufferSlot);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [shareView rotateTo:-1 * newHeading.trueHeading/360*2*M_PI]; // negate to turn to the opposite direction the iPad is turning
}

@end
