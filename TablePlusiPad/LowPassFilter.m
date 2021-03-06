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
    NSInteger currentBufferIndex;
}

-  (id)initBufferWithArray:(float*)array ofSize:(NSInteger)size withData:(float)d
{
    BUFFER_SIZE = size;
    
    buffer = array;
    for (NSInteger i = 0; i < BUFFER_SIZE; i++){
        buffer[i] = d;
    }
    
    currentBufferIndex = 0;
    
    return self;
}

- (float)filterData:(float)newData
{
    buffer[currentBufferIndex] = newData;
    
    // calc average of the last BUFFER_SIZE num of data in order to filter out high frequency
    float sum = 0;
    for (NSInteger i = 0; i < BUFFER_SIZE; i++) {
        sum += buffer[i];
    }
    float filteredData = sum / BUFFER_SIZE;

    currentBufferIndex = (currentBufferIndex + 1) % BUFFER_SIZE;
    
    return filteredData;
}

@end
