//
//  NorthWallView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "WallView.h"

@implementation WallView

@synthesize defaultTransform;

- (void)initDefaultTransform: (CATransform3D)t
{
    defaultTransform = t;
    self.layer.transform = t;
}

@end
