//
//  NumberView.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-09.
//
//

#import "NumberView.h"
#import "UICountingLabel.h"

@implementation NumberView {
    UICountingLabel* label;
}

- (id)init
{
    self = [super init];
    if (self) {
        label = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 0, 500, 100)];
        label.format = @"%d";
        label.method = UILabelCountingMethodLinear;
        label.text = @"0";
        label.textColor = [UIColor greenColor];
        label.font = [UIFont fontWithName:@"Futura" size:100];
        [self addSubview:label];
    }
    
    return self;
}

- (void) updateValueTo: (float) v
{
    NSLog(@"update");
    [label countFrom:label.text.floatValue to:v withDuration:0.2];
}

@end
