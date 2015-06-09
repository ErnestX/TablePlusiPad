//
//  ConcreteWidgetView.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-08.
//
//

#import <UIKit/UIKit.h>
#import "Widget.h"

@interface ConcreteWidgetView : UIView <Widget>

- (void)updatePieTo: (float) pieNum;
- (void)updateBarTo: (float) bNum;

@end
