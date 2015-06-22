//
//  ShareView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "ShareView.h"
#import "Vector3D.h"

#define WALL_HEIGHT 600.0
#define TABLE_WIDTH 600.0
#define TABLE_HEIGHT 400.0

#define DISTANCE_FROM_CAMERA 800.0
#define DISTANCE_FROM_TABLE_TO_SCREEN 0.0//300.0

@implementation ShareView {
    TableView* tableView;
    WallView* northWallView;
    WallView* southWallView;
    WallView* westWallView;
    WallView* eastWallView;
    
    CATransform3D defaultTransform;
    CATransform3D rotationMatrix;
    float rotationAngle;
    CATransform3D tiltMatrix;
    float tiltAngle;
    
    CADisplayLink* displayLink;
}

- (id)customInitWithTableView:(TableView*)tv northWallView:(WallView*)nwv southWallView:(WallView*)swv westWallView:(WallView*)wwv eastWallView:(WallView*)ewv
{
    // init iVars
    CATransform3D perspectiveT = CATransform3DIdentity;
    perspectiveT.m34 = -1.0/DISTANCE_FROM_CAMERA;
    defaultTransform = perspectiveT;
    self.layer.sublayerTransform = defaultTransform;
    tiltAngle = 0.0;
    
    rotationMatrix = CATransform3DIdentity;
    tiltMatrix = CATransform3DIdentity;
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateView:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    tableView = tv;
    northWallView = nwv;
    southWallView = swv;
    westWallView = wwv;
    eastWallView = ewv;
    
    tableView.frame = CGRectMake(0, 0, TABLE_WIDTH, TABLE_HEIGHT);
    tableView.center = self.center;
    [tableView initDefaultTransform:CATransform3DMakeTranslation(0.0, 0.0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN)];
    
    northWallView.frame = CGRectMake(0, 0, TABLE_WIDTH, WALL_HEIGHT);
    northWallView.layer.anchorPoint = CGPointMake(0.5, 1);
    northWallView.center = CGPointMake(self.center.x, self.center.y - TABLE_HEIGHT/2.0);
    [northWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 1, 0, 0),
                                                            CATransform3DMakeTranslation(0, 0.0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN))];
    southWallView.frame = CGRectMake(0, 0, TABLE_WIDTH, WALL_HEIGHT);
    southWallView.layer.anchorPoint = CGPointMake(0.5, 0);
    southWallView.center = CGPointMake(self.center.x, self.center.y + TABLE_HEIGHT/2.0);
    [southWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 1, 0, 0),
                                                            CATransform3DMakeTranslation(0, 0.0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN))];
    
    westWallView.frame = CGRectMake(0, 0, WALL_HEIGHT, TABLE_HEIGHT);
    westWallView.layer.anchorPoint = CGPointMake(1, 0.5);
    westWallView.center = CGPointMake(self.center.x - TABLE_WIDTH/2.0, self.center.y);
    [westWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 0, 1, 0),
                                                           CATransform3DMakeTranslation(0.0, 0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN))];
    
    eastWallView.frame = CGRectMake(0, 0, WALL_HEIGHT, TABLE_HEIGHT);
    eastWallView.layer.anchorPoint = CGPointMake(0, 0.5);
    eastWallView.center = CGPointMake(self.center.x + TABLE_WIDTH/2.0, self.center.y);
    [eastWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 0, 1, 0),
                                                           CATransform3DMakeTranslation(0.0, 0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN))];
    
    tableView.backgroundColor = [UIColor lightGrayColor];
    northWallView.backgroundColor = [UIColor redColor];
    southWallView.backgroundColor = [UIColor blueColor];
    westWallView.backgroundColor = [UIColor greenColor];
    eastWallView.backgroundColor = [UIColor yellowColor];
    
    [self addSubview:tableView];
    [self addSubview:northWallView];
    [self addSubview:southWallView];
    [self addSubview:westWallView];
    [self addSubview:eastWallView];
    //southWallView.hidden = YES;
    westWallView.hidden = YES;
    eastWallView.hidden = YES;
    
    return self;
}

- (void)updateView:(CADisplayLink*)dl
{
    // have to change the rotations view by view, or won't have the perspective effect. sublayerTransform should be used only for persepctive transform
    CATransform3D t = CATransform3DConcat(rotationMatrix, tiltMatrix);
    
    tableView.layer.transform = CATransform3DConcat(tableView.defaultTransform, t);
    
    CATransform3D const northTranslationFromCenter = CATransform3DMakeTranslation(0.0, -1 * TABLE_HEIGHT/2.0, 0.0);
    CATransform3D northConcated = CATransform3DConcat(northTranslationFromCenter, t);
    // extract translation values
    float northXTranslate = northConcated.m41 - northTranslationFromCenter.m41;
    float northYTranslate = northConcated.m42 - northTranslationFromCenter.m42;
    float northZTranslate = northConcated.m43 - northTranslationFromCenter.m43;
    
    NSLog(@"%f, %f, %f", northXTranslate, northYTranslate, northZTranslate);
    
    CATransform3D northT = CATransform3DMakeTranslation(northXTranslate, northYTranslate, northZTranslate);
    northWallView.layer.transform = CATransform3DConcat(northWallView.defaultTransform, CATransform3DConcat(northT, t));
    
    CATransform3D const southTranslationFromCenter = CATransform3DMakeTranslation(0.0, TABLE_HEIGHT/2.0, 0.0);
    CATransform3D southConcated = CATransform3DConcat(southTranslationFromCenter, t);
    float southXTranslate = southConcated.m41 - southTranslationFromCenter.m41;
    float southYTranslate = southConcated.m42 - southTranslationFromCenter.m42;
    float southZTranslate = southConcated.m43 - southTranslationFromCenter.m43;
    
    CATransform3D southT = CATransform3DTranslate(t, southXTranslate, southYTranslate, southZTranslate);
    southWallView.layer.transform = CATransform3DConcat(southWallView.defaultTransform, southT);
    
    westWallView.layer.transform = CATransform3DConcat(westWallView.defaultTransform, t);
    
    eastWallView.layer.transform = CATransform3DConcat(eastWallView.defaultTransform, t);
}

/* 
 heading is in radian
 */
- (void)setRotationTo: (float) heading
{
    rotationMatrix = CATransform3DMakeRotation(heading, 0, 0, -1);
    rotationAngle = heading;
}

- (void)setTiltTo: (float) angleX :(float)angleY 
{
    tiltMatrix = CATransform3DConcat(CATransform3DMakeRotation(angleX, 1, 0, 0), CATransform3DMakeRotation(angleY, 0, 1, 0));
    tiltAngle = angleX;
}

@end
