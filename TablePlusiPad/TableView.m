//
//  TableView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "TableView.h"

@implementation TableView

- (id)init
{
    self.frame = CGRectMake(0, 0, 200, 150);
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    return self;
}

@end
