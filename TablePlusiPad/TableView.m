//
//  TableView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-12.
//
//

#import "TableView.h"

@implementation TableView {
    UIButton* testButton;
}

@synthesize defaultTransform;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        testButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [testButton setTitle:@"Test Button" forState:UIControlStateNormal];
        [testButton sizeToFit];
        testButton.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [testButton addTarget:self action:@selector(testButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:testButton];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    testButton.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
}

- (void)initDefaultTransform: (CATransform3D)t
{
    defaultTransform = t;
    self.layer.transform = t;
    
    self.layer.doubleSided = NO;
}

- (void)testButtonPressed:(id)sender
{
    NSLog(@"test button pressed");
}

@end
