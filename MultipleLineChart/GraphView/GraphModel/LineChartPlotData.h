//
// Created by azu on 2014/03/25.
//


#import <Foundation/Foundation.h>

// prev - current - next
@interface LineChartPlotData : NSObject
@property(nonatomic) NSNumber *prevValue;
@property(nonatomic) NSNumber *currentValue;
@property(nonatomic) NSNumber *nextValue;

- (instancetype)initWithCurrentValue:(NSNumber *) currentValue prevValue:(NSNumber *) prevValue nextValue:(NSNumber *) nextValue;

+ (instancetype)dataWithCurrentValue:(NSNumber *) currentValue prevValue:(NSNumber *) prevValue nextValue:(NSNumber *) nextValue;

- (NSString *)description;
@end