//
//  3DVector.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-19.
//
//

#import "Vector3D.h"

@implementation Vector3D

@synthesize x,y,z;

- (instancetype)init
{
    self = [super init];
    if (self) {
        x = 0.0;
        y = 0.0;
        z = 0.0;
    }
    return self;
}

- (instancetype)initWithX:(float)xv Y:(float)yv Z:(float)zv
{
    self = [super init];
    if (self) {
        x = xv;
        y = yv;
        z = zv;
    }
    return self;
}

- (Vector3D*)plus:(Vector3D*)v
{
    return [[Vector3D alloc]initWithX:x + v.x Y:y + v.y Z:z + v.z];
}

- (float)getModule
{
    return sqrtf(powf(x, 2) + powf(y, 2) + powf(z, 2));
}

- (void)setModule:(float)m
{
    Vector3D* temp = [[self normalize] calcMultiplyByConst:m];
    self.x = temp.x;
    self.y = temp.y;
    self.z = temp.z;
}

- (Vector3D*)calcMultiplyByConst:(float)c
{
    return [[Vector3D alloc]initWithX:x*c Y:y*c Z:z*c];
}
            
- (Vector3D*)calcDivideByConst:(float)c
{
    return [[Vector3D alloc]initWithX:x/c Y:y/c Z:z/c];
}

- (Vector3D*)normalize
{
    return [self calcDivideByConst:[self getModule]];
}

@end
