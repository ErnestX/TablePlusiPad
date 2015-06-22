//
//  3DVector.h
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-19.
//
//

#import <Foundation/Foundation.h>

@interface Vector3D : NSObject

@property float x,y,z;

- (instancetype)initWithX:(float)xv Y:(float)yv Z:(float)zv;
- (Vector3D*)plus:(Vector3D*)v;
- (void)setModule:(float)m;
- (float)getModule;
- (Vector3D*)calcMultiplyByConst:(float)c;
- (Vector3D*)normalize;
- (float)calcDotProd:(Vector3D*)v;
- (float)calcAngleToPlaneWithNormal:(Vector3D*)n;

@end
