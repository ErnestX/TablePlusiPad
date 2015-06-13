//
//  LowPassFilter.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-13.
//
//

#import <Foundation/Foundation.h>

@interface LowPassFilter : NSObject

-  (id)initBufferWithArray:(float*)array ofSize:(NSInteger)size withData:(float)d;
- (float)filterData:(float)newData;

@end
