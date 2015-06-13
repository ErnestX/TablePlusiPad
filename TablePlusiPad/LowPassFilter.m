//
//  LowPassFilter.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-13.
//
//

#import "LowPassFilter.h"
#define BUFFER_SIZE 20

@implementation LowPassFilter {
    float buffer[BUFFER_SIZE];  // a circular array
    NSInteger currentBufferSlot;
}

-  (id)initBufferwithData:(float)d
{
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
    
    return filteredData;
}

@end
