//
//  ShareView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "ShareView.h"
#define DISTANCE_FROM_CAMERA 600.0

@implementation ShareView {
    TableView* tableView;
    WallView* northWallView;
    WallView* southWallView;
    WallView* westWallView;
    WallView* eastWallView;
    
    CATransform3D rotation;
    CATransform3D tilt;
    
    NSTimer* displayerLink; //TODO: get a real display link
}

- (id)customInitWithTableView:(TableView*)tv northWallView:(WallView*)nwv southWallView:(WallView*)swv westWallView:(WallView*)wwv eastWallView:(WallView*)ewv
{
    // init iVars
    rotation = CATransform3DIdentity;
    tilt = CATransform3DIdentity;
    displayerLink = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
    
    tableView = tv;
    northWallView = nwv;
    southWallView = swv;
    westWallView = wwv;
    eastWallView = ewv;
    
    // set up subviews
    CATransform3D perspectiveT = CATransform3DIdentity;
    perspectiveT.m34 = -1.0/DISTANCE_FROM_CAMERA;
    
    [tableView initDefaultTransform:perspectiveT];
    
    [northWallView initDefaultTransform:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 1, 0, 0),
                                                                                CATransform3DMakeTranslation(0, -1 * CGRectGetHeight(tableView.frame)/2.0, 0)),
                                                            perspectiveT)];
    [southWallView initDefaultTransform:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 1, 0, 0),
                                                                                CATransform3DMakeTranslation(0, CGRectGetHeight(tableView.frame)/2.0, 0)),
                                                            perspectiveT)];
    [westWallView initDefaultTransform:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 0, 1, 0),
                                                                               CATransform3DMakeTranslation(-1 * CGRectGetWidth(tableView.frame)/2.0, 0, 0)),
                                                           perspectiveT)];
    [eastWallView initDefaultTransform:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 0, 1, 0),
                                                                               CATransform3DMakeTranslation(CGRectGetWidth(tableView.frame)/2.0, 0, 0)),
                                                           perspectiveT)];
    
    [self addSubview:tableView];
    [self addSubview:northWallView];
    [self addSubview:southWallView];
    [self addSubview:westWallView];
    [self addSubview:eastWallView];
    
    return self;
}

- (void)updateView
{
   self.layer.sublayerTransform = CATransform3DConcat(rotation, tilt);
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
