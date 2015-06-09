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
    CAShapeLayer* cap;
}

- (id)customInit
{
    bar = [CAShapeLayer layer];
    bar.strokeColor = [UIColor greenColor].CGColor;
    bar.fillColor = [UIColor clearColor].CGColor;
    bar.lineWidth = 20;
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(0, 0)];
    [aPath addLineToPoint:CGPointMake(0, -300)];
    [aPath closePath];
    bar.path = aPath.CGPath;
    
    [self addSublayer:bar];
    return self;
}

@end
