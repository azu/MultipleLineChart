//
// Created by azu on 2014/03/05.
//


#import <ArsScale/ArsScaleLinear.h>
#import <sys/ucred.h>
#import "GraphAxisView.h"


@implementation GraphAxisView {

}
- (void)drawAxisLabel:(CGRect) rect text:(NSString *) text {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectOffset(rect, 0, -(rect.size.height / 2));
    label.textAlignment = NSTextAlignmentRight;
    label.text = text;
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:label];
}

- (void)reDrawView {
    for (UILabel *label in self.subviews) {
        [label removeFromSuperview];
    }
    [self drawAxisLabels:self.frame];
}

- (void)drawAxisLabels:(CGRect) rect {
    NSArray *axis = [self.yScale ticks:10];
    for (NSUInteger i = 0; i < [axis count]; i++) {
        NSNumber *data = [self.yScale scale:axis[i]];
        [self drawAxisLabel:CGRectMake(0, rect.size.height - [data floatValue],
            rect.size.width,
            rect.size.height / 10) text:[NSString stringWithFormat:@"%d", [axis[i] integerValue]]];

    }
}


@end