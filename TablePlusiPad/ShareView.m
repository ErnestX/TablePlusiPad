//
//  ShareView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "ShareView.h"

@implementation ShareView {
    CALayer* gyroTestLayer;
    
    TableView* tableView;
    WallView* northWallView;
    WallView* southWallView;
    WallView* westWallView;
    WallView* eastWallView;
    
    CATransform3D rotation;
    CATransform3D tilt;
}

- (id)customInitWithTableView:(TableView*)tv northWallView:(WallView*)nwv southWallView:(WallView*)swv westWallView:(WallView*)wwv eastWallView:(WallView*)ewv
{
    // init iVars
    rotation = CATransform3DIdentity;
    tilt = CATransform3DIdentity;
    
    // set up subviews
    CATransform3D perspectiveT = CATransform3DIdentity;
    perspectiveT.m34 = -1.0/500.0;
    [nwv initDefaultTransform:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 1, 0, 0), CATransform3DMakeTranslation(0, -1 * CGRectGetHeight(tv.frame), 0)), perspectiveT)];
    [swv initDefaultTransform:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 1, 0, 0), CATransform3DMakeTranslation(0, CGRectGetHeight(tv.frame), 0)), perspectiveT)];
    [wwv initDefaultTransform:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeRotation(M_PI/2, 0, 1, 0), CATransform3DMakeTranslation(-1 * CGRectGetWidth(tv.frame), 0, 0)), perspectiveT)];
    [ewv initDefaultTransform:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeRotation(-1 * M_PI/2, 0, 1, 0), CATransform3DMakeTranslation(CGRectGetWidth(tv.frame), 0, 0)), perspectiveT)];
    
    [self addSubview:tv];
    [self addSubview:nwv];
    [self addSubview:swv];
    [self addSubview:wwv];
    [self addSubview:ewv];
    
    // set up test layer
    gyroTestLayer = [CALayer layer];
    gyroTestLayer.backgroundColor = [UIColor redColor].CGColor;
    gyroTestLayer.frame = CGRectMake(0, 0, 200, 400);
    // since it's iPad starting in landscape, have to do this initialization after the view having been loaded
    gyroTestLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    gyroTestLayer.hidden = YES;
    [self.layer addSublayer:gyroTestLayer];
    
    return self;
}

- (void)updateView
{
    CATransform3D perspectiveT = CATransform3DIdentity;
    perspectiveT.m34 = -1.0/500.0;
    
    CATransform3D t = CATransform3DConcat(rotation, tilt);
    
    gyroTestLayer.transform = CATransform3DConcat(t, perspectiveT); 
}

- (void)rotateTo: (float) heading
{
    rotation = CATransform3DMakeRotation(heading, 0, 0, 1);
    [self updateView];
}

- (void)tiltTo: (float) angleX :(float)angleY 
{
    tilt = CATransform3DConcat(CATransform3DMakeRotation(angleX, 1, 0, 0), CATransform3DMakeRotation(angleY, 0, 1, 0));
    [self updateView];
}

@end
