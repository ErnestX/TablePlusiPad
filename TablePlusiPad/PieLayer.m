//
//  BarLayer.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-08.
//
//

#import "PieLayer.h"

@implementation PieLayer

+ (instancetype)layer
{
    PieLayer* pl = [super layer];
    if (pl) {
        UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:pl.frame.origin radius:100 startAngle:-0.5 * M_PI endAngle:1.5 * M_PI clockwise:YES];
        pl.path = aPath.CGPath;
        pl.lineCap = kCALineCapRound;
        pl.strokeColor = [UIColor greenColor].CGColor;
        pl.fillColor = [UIColor clearColor].CGColor;
        pl.lineWidth = 20;
    }
    return pl;
}

@end
