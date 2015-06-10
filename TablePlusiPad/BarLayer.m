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

#define TRIANGLE_HEIGHT 9
#define BAR_WIDTH 20
#define BAR_HEIGHT 400

- (id)customInit
{
    // draw mask
    maskWithCap = [CAShapeLayer layer];
    UIBezierPath* maskPath = UIBezierPath.bezierPath;
    
    [maskPath moveToPoint: CGPointMake(-1 * BAR_WIDTH/2, 0)];
    [maskPath addLineToPoint: CGPointMake(0, -1 * TRIANGLE_HEIGHT)];
    [maskPath addLineToPoint: CGPointMake(BAR_WIDTH/2, 0)];
    [maskPath addLineToPoint: CGPointMake(BAR_WIDTH/2, BAR_HEIGHT)];
    [maskPath addLineToPoint: CGPointMake(-1 * BAR_WIDTH/2, BAR_HEIGHT)];
    [maskPath closePath];
    
    maskWithCap.path = maskPath.CGPath;
    maskWithCap.fillColor = [UIColor redColor].CGColor;
    maskWithCap.anchorPoint = CGPointMake(0.5, 0);
    [self addSublayer:maskWithCap];
    
    // draw bar
    bar = [CAShapeLayer layer];
    bar.strokeColor = [UIColor greenColor].CGColor;
    bar.fillColor = [UIColor clearColor].CGColor;
    bar.lineWidth = BAR_WIDTH;
    UIBezierPath* barPath = [UIBezierPath bezierPath];
    [barPath moveToPoint:CGPointMake(0, 0)];
    [barPath addLineToPoint:CGPointMake(0, -1 * BAR_HEIGHT - TRIANGLE_HEIGHT)];
    [barPath closePath];
    bar.path = barPath.CGPath;
    bar.anchorPoint = CGPointMake(0.5, 1);
    bar.mask = maskWithCap;
    [self addSublayer:bar];

    return self;
}

- (void) updateValueTo: (float)v
{
    if (v > BAR_HEIGHT) {
        v = BAR_HEIGHT;
    } else if (v < 0) {
        v = 0;
    }
    
    maskWithCap.position = CGPointMake(maskWithCap.position.x, -1 * v);
}

@end
