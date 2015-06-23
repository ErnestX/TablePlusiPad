//
//  NorthWallView.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import <UIKit/UIKit.h>
#import "WallViewDelegate.h"

@interface WallView : UIView

@property (readonly) CATransform3D defaultTransform;
@property UIViewController<WallViewDelegate> *delegate;

- (void)initDefaultTransform: (CATransform3D)t;

@end
