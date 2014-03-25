//
// Created by azu on 2014/03/25.
//


#import "GraphGroupDataSource.h"
#import "ASTMinMax.h"


@interface GraphGroupDataSource ()
@property(nonatomic) NSArray *values;
@end

@implementation GraphGroupDataSource {

}
- (instancetype)initWithValues:(NSArray *) values {
    self = [super init];
    if (self == nil) {
        return nil;
    }

    self.values = values;

    return self;
}

+ (instancetype)dataSourceWithValues:(NSArray *) values {
    return [[self alloc] initWithValues:values];
}

- (NSNumber *)valueAtIndex:(NSUInteger) index {
    if (index >= 0 && index < [self.values count]) {
        return self.values[index];
    }
    return nil;
}

- (NSUInteger)numberOfData {
    return [self.values count];
}

- (NSNumber *)highestValue {
    return ASTMax(self.values);
}

- (NSNumber *)lowestValue {
    return ASTMin(self.values);
}


@end