//
//  WallViewController.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-23.
//
//

#import <UIKit/UIKit.h>
#import "WallViewDelegate.h"
#import "WallName.h"

@interface WallViewController : UIViewController <WallViewDelegate>

- (WallName)getName;

@end
