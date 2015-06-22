//
//  Vector3DTests.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-19.
//
//

#import "Vector3DTests.h"
#import "Vector3D.h"

@implementation Vector3DTests {
    Vector3D* v0, *v1, *v2, *v3, *v4;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    v0 = [[Vector3D alloc]initWithX:0.0 Y:0.0 Z:0.0];
    v1 = [[Vector3D alloc]initWithX:1.0 Y:0.0 Z:0.0];
    v2 = [[Vector3D alloc]initWithX:0.0 Y:1.0 Z:0.0];
    v3 = [[Vector3D alloc]initWithX:0.0 Y:0.0 Z:-1.0];
    v4 = [[Vector3D alloc]initWithX:1.0 Y:0.0 Z:1.0];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPlus
{
    XCTAssertEqual([v0 plus:v1].x, v1.x);
    XCTAssertEqual([v0 plus:v1].y, v1.y);
    XCTAssertEqual([v0 plus:v1].z, v1.z);
    
    XCTAssertEqual([v1 plus:v1].x, 2.0);
}

- (void)testGetModule
{
    XCTAssertEqual([v0 getModule], 0.0);
    XCTAssertEqual([v1 getModule], 1.0);
    XCTAssertEqual([v4 getModule], sqrtf(2.0));
}

- (void)testSetModule
{
    [v1 setModule:2.0];
    XCTAssertEqual(v1.x, 2.0);
    XCTAssertEqual(v1.y, 0.0);
    XCTAssertEqual(v1.z, 0.0);
    
    [v3 setModule:2.0];
    XCTAssertEqual(v3.x, 0.0);
    XCTAssertEqual(v3.y, 0.0);
    XCTAssertEqual(v3.z, -2.0);
}

- (void)testCalcMultiplyByConst
{
    Vector3D* temp = [v1 calcMultiplyByConst:10.0];
    XCTAssertEqual(temp.x, 10.0);
    XCTAssertEqual(temp.y, 0.0);
    XCTAssertEqual(temp.z, 0.0);
    
    temp = [v2 calcMultiplyByConst:10.0];
    XCTAssertEqual(temp.x, 0.0);
    XCTAssertEqual(temp.y, 10.0);
    XCTAssertEqual(temp.z, 0.0);
}

- (void)testNormalize
{
    v1 = [v1 normalize];
    XCTAssertEqual(v1.x, 1.0);
    XCTAssertEqual(v1.y, 0.0);
    XCTAssertEqual(v1.z, 0.0);
    
    v4 = [v4 normalize];
    XCTAssertEqualWithAccuracy(v4.x, 1.0 / sqrtf(2.0), 0.0001);
    XCTAssertEqualWithAccuracy(v4.y, 0.0, 0.0001);
    XCTAssertEqualWithAccuracy(v4.z, 1.0 / sqrtf(2.0), 0.0001);
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

@end
