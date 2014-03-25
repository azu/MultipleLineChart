//
// Created by azu on 2014/03/25.
//


#import "GraphValueModel.h"


@implementation GraphValueModel {

}
- (instancetype)initWithValue:(NSNumber *) value {
    self = [super init];
    if (self == nil) {
        return nil;
    }

    self.value = value;

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass(
        [self class])];
    [description appendFormat:@"self.value=%@", self.value];
    [description appendString:@">"];
    return description;
}


+ (instancetype)modelWithValue:(NSNumber *) value {
    return [[self alloc] initWithValue:value];
}

@end