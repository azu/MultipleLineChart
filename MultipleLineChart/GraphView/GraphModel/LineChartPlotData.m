//
// Created by azu on 2014/03/25.
//


#import "LineChartPlotData.h"


@implementation LineChartPlotData {

}
- (instancetype)initWithCurrentValue:(NSNumber *) currentValue prevValue:(NSNumber *) prevValue nextValue:(NSNumber *) nextValue {
    self = [super init];
    if (self == nil) {
        return nil;
    }

    self.currentValue = currentValue;
    self.prevValue = prevValue;
    self.nextValue = nextValue;

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass(
        [self class])];
    [description appendFormat:@"self.prevValue=%@", self.prevValue];
    [description appendFormat:@", self.currentValue=%@", self.currentValue];
    [description appendFormat:@", self.nextValue=%@", self.nextValue];
    [description appendString:@">"];
    return description;
}


+ (instancetype)dataWithCurrentValue:(NSNumber *) currentValue prevValue:(NSNumber *) prevValue nextValue:(NSNumber *) nextValue {
    return [[self alloc] initWithCurrentValue:currentValue prevValue:prevValue nextValue:nextValue];
}

@end