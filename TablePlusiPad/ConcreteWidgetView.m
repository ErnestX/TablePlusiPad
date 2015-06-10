//
//  ConcreteWidgetView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-08.
//
//

#import "ConcreteWidgetView.h"
#import "PieLayer.h"
#import "BarLayer.h"
#import "NumberView.h"

@implementation ConcreteWidgetView {
    PieLayer* pieLayer;
    BarLayer* barLayer;
    NumberView* numView;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        pieLayer = [PieLayer layer];
        pieLayer.position = self.center;
        [self.layer addSublayer:pieLayer];
        
        barLayer = [[BarLayer layer]customInit];
        barLayer.position = CGPointMake(900, 700);
        [self.layer addSublayer:barLayer];
        
        numView = [[NumberView alloc]init];
        [numView sizeToFit];
        numView.center = CGPointMake(500, 500);
        [self addSubview:numView];
    }
    
    return self;
}

- (void)updateBarTo: (float) bNum
{
    [barLayer updateValueTo:bNum];
}

- (void)updatePieTo: (float) pieNum
{
    [pieLayer updateValueTo:pieNum];
}

- (void)updateNumTo: (float) num
{
    [numView updateValueTo:num];
}

@end
