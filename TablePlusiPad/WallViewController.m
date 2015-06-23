//
//  WallViewController.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-23.
//
//

#import "WallViewController.h"
#import "WallView.h"

@implementation WallViewController {
    WallName name;
}

- (id)initWithName:(WallName)n
{
    self = [super init];
    if (self) {
        // init wall view
        self.view = [[WallView alloc]initWithFrame:CGRectZero];
        name = n;
    }
    
    return self;
}

- (void)setWallFrame:(CGRect)f
{
    self.view.frame = f;
}

- (void)setWallFrameCenter:(CGPoint)c
{
    self.view.center = c;
}

- (WallName)getName
{
    return name;
}

- (void)testButtonPressed:(UIView*)view
{
    NSLog(@"testButton Pressed on Wall#%d", name);
}

@end
