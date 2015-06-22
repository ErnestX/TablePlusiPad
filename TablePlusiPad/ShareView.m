//
//  ShareView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "ShareView.h"

#define WALL_HEIGHT 600
#define TABLE_WIDTH 600
#define TABLE_HEIGHT 400

#define DISTANCE_FROM_CAMERA 800.0
#define DISTANCE_FROM_TABLE_TO_SCREEN 300.0

@implementation ShareView {
    TableView* tableView;
    WallView* northWallView;
    WallView* southWallView;
    WallView* westWallView;
    WallView* eastWallView;
    
    CATransform3D defaultTransform;
    CATransform3D rotation;
    CATransform3D tilt;
    
    CADisplayLink* displayLink;
}

- (id)customInitWithTableView:(TableView*)tv northWallView:(WallView*)nwv southWallView:(WallView*)swv westWallView:(WallView*)wwv eastWallView:(WallView*)ewv
{
    // init iVars
    CATransform3D perspectiveT = CATransform3DIdentity;
    perspectiveT.m34 = -1.0/DISTANCE_FROM_CAMERA;
    defaultTransform = perspectiveT;
    self.layer.sublayerTransform = defaultTransform;
    
    rotation = CATransform3DIdentity;
    tilt = CATransform3DIdentity;
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateView:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    tableView = tv;
    northWallView = nwv;
    southWallView = swv;
    westWallView = wwv;
    eastWallView = ewv;
    
    tableView.frame = CGRectMake(0, 0, TABLE_WIDTH, TABLE_HEIGHT);
    tableView.center = self.center;
    northWallView.frame = CGRectMake(0, 0, TABLE_WIDTH, WALL_HEIGHT);
    northWallView.layer.anchorPoint = CGPointMake(0.5, 1);
    northWallView.center = self.center;
    southWallView.frame = CGRectMake(0, 0, TABLE_WIDTH, WALL_HEIGHT);
    southWallView.layer.anchorPoint = CGPointMake(0.5, 0);
    southWallView.center = self.center;
    westWallView.frame = CGRectMake(0, 0, WALL_HEIGHT, TABLE_HEIGHT);
    westWallView.layer.anchorPoint = CGPointMake(1, 0.5);
    westWallView.center = self.center;
    eastWallView.frame = CGRectMake(0, 0, WALL_HEIGHT, TABLE_HEIGHT);
    eastWallView.layer.anchorPoint = CGPointMake(0, 0.5);
    eastWallView.center = self.center;
    tableView.backgroundColor = [UIColor lightGrayColor];
    northWallView.backgroundColor = [UIColor redColor];
    southWallView.backgroundColor = [UIColor blueColor];
    westWallView.backgroundColor = [UIColor greenColor];
    eastWallView.backgroundColor = [UIColor yellowColor];
    
    // set up default transforms
    [tableView initDefaultTransform:CATransform3DMakeTranslation(0.0, 0.0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN)];
    
    [northWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 1, 0, 0),
                                                            CATransform3DMakeTranslation(0, -1 * CGRectGetHeight(tableView.frame)/2.0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN))];
    [southWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 1, 0, 0),
                                                            CATransform3DMakeTranslation(0, CGRectGetHeight(tableView.frame)/2.0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN))];
    [westWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 0, 1, 0),
                                                           CATransform3DMakeTranslation(-1 * CGRectGetWidth(tableView.frame)/2.0, 0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN))];
    [eastWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 0, 1, 0),
                                                           CATransform3DMakeTranslation(CGRectGetWidth(tableView.frame)/2.0, 0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN))];
    
    [self addSubview:tableView];
    [self addSubview:northWallView];
    [self addSubview:southWallView];
    [self addSubview:westWallView];
    [self addSubview:eastWallView];
    
    return self;
}

- (void)updateView:(CADisplayLink*)dl
{
    // have to change the rotations view by view, or won't have the perspective effect. sublayerTransform should be used only for persepctive transform
    CATransform3D t = CATransform3DConcat(rotation, tilt);
    
    tableView.layer.transform = CATransform3DConcat(tableView.defaultTransform, t);
    northWallView.layer.transform = CATransform3DConcat(northWallView.defaultTransform, t);
    southWallView.layer.transform = CATransform3DConcat(southWallView.defaultTransform, t);
    westWallView.layer.transform = CATransform3DConcat(westWallView.defaultTransform, t);
    eastWallView.layer.transform = CATransform3DConcat(eastWallView.defaultTransform, t);
   //self.layer.sublayerTransform = CATransform3DConcat(defaultTransform, CATransform3DConcat(rotation, tilt));
}

- (void)setRotationTo: (float) heading
{
//    NSLog(@"heading: %f", heading);
    rotation = CATransform3DMakeRotation(heading, 0, 0, -1);
}

- (void)setTiltTo: (float) angleX :(float)angleY 
{
    tilt = CATransform3DConcat(CATransform3DMakeRotation(angleX, 1, 0, 0), CATransform3DMakeRotation(angleY, 0, 1, 0));
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // TODO: OVERWRITE!
    
    CGPoint p = [northWallView convertPoint:point fromView:self];
    UIView* temp = [northWallView hitTest:p withEvent:event];
    if (temp != nil && temp != northWallView) {
//        NSLog(@"north");
        return temp;
    }
    
    p = [southWallView convertPoint:point fromView:self];
    temp = [southWallView hitTest:p withEvent:event];
    if (temp != nil && temp != southWallView) {
//        NSLog(@"south");
        return temp;
    }
    
    p = [westWallView convertPoint:point fromView:self];
    temp = [westWallView hitTest:p withEvent:event];
    if (temp != nil && temp != westWallView) {
//        NSLog(@"west");
        return temp;
    }
    
    p = [eastWallView convertPoint:point fromView:self];
    temp = [eastWallView hitTest:p withEvent:event];
    if (temp != nil && temp != eastWallView) {
//        NSLog(@"east");
        return temp;
    }
    
    p = [tableView convertPoint:point fromView:self];
    temp = [tableView hitTest:p withEvent:event];
    if (temp != nil && temp != tableView) {
//        NSLog(@"table");
        return temp;
    }
    
    if ([self pointInside:point withEvent:event]) {
//        NSLog(@"self");
        return self;
    }
    
    return nil;
}

@end
