//
//  NorthWallView.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import <UIKit/UIKit.h>

@interface WallView : UIView

@property (readonly) CATransform3D defaultTransform;

- (void)initDefaultTransform: (CATransform3D)t;

@end
