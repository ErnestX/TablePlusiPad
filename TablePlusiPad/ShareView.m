//
//  ShareView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "ShareView.h"
#define DISTANCE_FROM_CAMERA 800.0
#define DISTANCE_FROM_TABLE_TO_SCREEN 400.0

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
    //CATransform3D translationT = CATransform3DMakeTranslation(0, 0, -1 * DISTANCE_FROM_TABLE_TO_SCREEN);
    defaultTransform = perspectiveT;//CATransform3DConcat(perspectiveT, translationT);
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
    
    // set up subviews
    [tableView initDefaultTransform:CATransform3DMakeTranslation(0.0, 0.0, 0.0)];
    
    [northWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 1, 0, 0),
                                                            CATransform3DMakeTranslation(0, -1 * CGRectGetHeight(tableView.frame)/2.0, 0.0))];
    [southWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 1, 0, 0),
                                                            CATransform3DMakeTranslation(0, CGRectGetHeight(tableView.frame)/2.0, 0.0))];
    [westWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 0, 1, 0),
                                                           CATransform3DMakeTranslation(-1 * CGRectGetWidth(tableView.frame)/2.0, 0, 0.0))];
    [eastWallView initDefaultTransform:CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 0, 1, 0),
                                                           CATransform3DMakeTranslation(CGRectGetWidth(tableView.frame)/2.0, 0, 0.0))];
    
    [self addSubview:tableView];
    [self addSubview:northWallView];
    [self addSubview:southWallView];
    [self addSubview:westWallView];
    [self addSubview:eastWallView];
        
    return self;
}

- (void)updateView:(CADisplayLink*)dl
{
    // have to change the rotations view by view, or won't have the perspective effect
    CATransform3D t = CATransform3DConcat(rotation, tilt);
    
    tableView.layer.transform = CATransform3DConcat(tableView.defaultTransform, t);
    northWallView.layer.transform = CATransform3DConcat(northWallView.defaultTransform, t);
    southWallView.layer.transform = CATransform3DConcat(southWallView.defaultTransform, t);
    westWallView.layer.transform = CATransform3DConcat(westWallView.defaultTransform, t);
    eastWallView.layer.transform = CATransform3DConcat(eastWallView.defaultTransform, t);
   //self.layer.sublayerTransform = CATransform3DConcat(defaultTransform, CATransform3DConcat(rotation, tilt));
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
