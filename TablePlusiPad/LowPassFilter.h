//
//  LowPassFilter.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-13.
//
//

#import <Foundation/Foundation.h>

@interface LowPassFilter : NSObject

-  (id)initBufferwithData:(float)d;
- (float)filterData:(float)newData;

@end
