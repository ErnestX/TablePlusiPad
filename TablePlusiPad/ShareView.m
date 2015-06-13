//
//  ShareView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "ShareView.h"
#define DISTANCE_FROM_CAMERA 1000.0
#define DISTANCE_FROM_TABLE_TO_SCREEN 400.0

@implementation ShareView {
    TableView* tableView;
    WallView* northWallView;
    WallView* southWallView;
    WallView* westWallView;
    WallView* eastWallView;
    
    CATransform3D rotation;
    CATransform3D tilt;
    
    CADisplayLink* displayLink;
}

- (id)customInitWithTableView:(TableView*)tv northWallView:(WallView*)nwv southWallView:(WallView*)swv westWallView:(WallView*)wwv eastWallView:(WallView*)ewv
{
    // init iVars
    rotation = CATransform3DIdentity;
    tilt = CATransform3DIdentity;
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateView:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    tableView = tv;
    northWallView = nwv;
    southWallView = swv;
    westWallView = wwv;
    eastWallView = ewv;
    
    // set up subviews
//    CATransform3D perspectiveT = CATransform3DIdentity;
//    perspectiveT.m34 = -1.0/DISTANCE_FROM_CAMERA;
    
    [tableView initDefaultTransform:CATransform3DMakeTranslation(0, 0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN)];
    
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
   CATransform3D perspectiveT = CATransform3DIdentity;
   perspectiveT.m34 = -1.0/DISTANCE_FROM_CAMERA;
    
   self.layer.sublayerTransform = CATransform3DConcat(perspectiveT, CATransform3DConcat(rotation, tilt));
}

- (void)setRotateTo: (float) heading
{
    rotation = CATransform3DMakeRotation(heading, 0, 0, 1);
}

- (void)setTiltTo: (float) angleX :(float)angleY 
{
    tilt = CATransform3DConcat(CATransform3DMakeRotation(angleX, 1, 0, 0), CATransform3DMakeRotation(angleY, 0, 1, 0));
}

@end
