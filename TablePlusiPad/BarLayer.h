//
//  BarLayer.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-09.
//
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface BarLayer : CALayer

- (id)customInit;
- (void) updateValueTo: (float)v;

@end
