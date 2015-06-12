//
//  ShareView.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

- (id)customInit;
- (void)rotateTo: (float) heading;
- (void)tiltTo: (float) angleX :(float)angleY;

@end
