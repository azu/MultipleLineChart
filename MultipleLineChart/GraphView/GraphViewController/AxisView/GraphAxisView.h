//
// Created by azu on 2014/03/05.
//


#import <Foundation/Foundation.h>

@class ArsScaleLinear;


@interface GraphAxisView : UIView
@property (nonatomic, weak) ArsScaleLinear *yScale;

- (void)reDrawView;
@end