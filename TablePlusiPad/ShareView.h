//
//  ShareView.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import <UIKit/UIKit.h>
#import "TableView.h"
#import "WallView.h"

@interface ShareView : UIView

- (id)customInitWithTableView:(TableView*)tv northWallView:(WallView*)nwv southWallView:(WallView*)swv westWallView:(WallView*)wwv eastWallView:(WallView*)ewv;
- (void)setRotateTo: (float) heading;
- (void)setTiltTo: (float) angleX :(float)angleY;

@end
