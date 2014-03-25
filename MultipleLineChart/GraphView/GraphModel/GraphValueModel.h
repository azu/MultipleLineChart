//
// Created by azu on 2014/03/25.
//


#import <Foundation/Foundation.h>


@interface GraphValueModel : NSObject
@property(nonatomic, strong) NSNumber *value;

- (NSString *)description;

- (instancetype)initWithValue:(NSNumber *) value;

+ (instancetype)modelWithValue:(NSNumber *) value;

@end