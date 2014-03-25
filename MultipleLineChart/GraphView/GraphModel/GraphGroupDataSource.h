//
// Created by azu on 2014/03/25.
//


#import <Foundation/Foundation.h>


@interface GraphGroupDataSource : NSObject
+ (instancetype)dataSourceWithValues:(NSArray *) values;
- (NSNumber *)valueAtIndex:(NSUInteger) index;
- (NSUInteger)numberOfData;
- (NSNumber *)highestValue;
- (NSNumber *)lowestValue;
@end