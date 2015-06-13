//
//  TableView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "TableView.h"

@implementation TableView

@synthesize defaultTransform;

- (void)initDefaultTransform: (CATransform3D)t
{
    defaultTransform = t;
    self.layer.transform = t;
    
    self.layer.doubleSided = NO;
}

@end
