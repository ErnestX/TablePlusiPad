//
//  BarLayer.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-09.
//
//

#import "BarLayer.h"

@implementation BarLayer{
    CAShapeLayer* bar;
    CAShapeLayer* maskWithCap;
}

- (id)customInit
{
    // draw bar
    bar = [CAShapeLayer layer];
    bar.strokeColor = [UIColor greenColor].CGColor;
    bar.fillColor = [UIColor clearColor].CGColor;
    bar.lineWidth = 20;
    UIBezierPath* barPath = [UIBezierPath bezierPath];
    [barPath moveToPoint:CGPointMake(0, 0)];
    [barPath addLineToPoint:CGPointMake(0, -350)];
    [barPath closePath];
    bar.path = barPath.CGPath;
    bar.anchorPoint = CGPointMake(0.5, 1);
    [self addSublayer:bar];
    
    // draw mask
    maskWithCap = [CAShapeLayer layer];
    UIBezierPath* maskPath = UIBezierPath.bezierPath;
    
    float triangleHeight = 9;
    float triangleWidth = 20;
    float barHeight = 300;
    [maskPath moveToPoint: CGPointMake(-1 * triangleWidth/2, 0)];
    [maskPath addLineToPoint: CGPointMake(0, -1 * triangleHeight)];
    [maskPath addLineToPoint: CGPointMake(triangleWidth/2, 0)];
    [maskPath addLineToPoint: CGPointMake(triangleWidth/2, barHeight)];
    [maskPath addLineToPoint: CGPointMake(-1 * triangleWidth/2, barHeight)];
    [maskPath closePath];
    
    maskWithCap.path = maskPath.CGPath;
    maskWithCap.fillColor = [UIColor redColor].CGColor;
    maskWithCap.anchorPoint = CGPointMake(0.5, 0);
    [self addSublayer:maskWithCap];

    return self;
}

- (void) updateValueTo: (float)v
{
    maskWithCap.position = CGPointMake(maskWithCap.position.x, -1 * v);
}

@end
