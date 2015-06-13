//
//  LowPassFilter.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-13.
//
//

#import "LowPassFilter.h"

@implementation LowPassFilter {
    NSInteger BUFFER_SIZE;
    float* buffer;  // a circular array
    NSInteger currentBufferSlot;
}

-  (id)initBufferWithArray:(float*)array ofSize:(NSInteger)size withData:(float)d
{
    BUFFER_SIZE = size;
    buffer = array;
    
    for (NSInteger i = 0; i < BUFFER_SIZE; i++){
        buffer[i] = d;
    }
    
    currentBufferSlot = 0;
    
    return self;
}

- (float)filterData:(float)newData
{
    buffer[currentBufferSlot] = newData;
    
    // calc average
    float sum = 0;
    for (NSInteger i = 0; i < BUFFER_SIZE; i++) {
        sum += buffer[i];
    }
    float filteredData = sum / BUFFER_SIZE;

    currentBufferSlot = (currentBufferSlot + 1) % BUFFER_SIZE;
//    NSLog(@"current slot %d", currentBufferSlot);
    return filteredData;
}

@end
