//
//  ToolTipView.m
//

#import "ToolTipView.h"
#import "VerticallyAlignedLabel.h"

@implementation ToolTipView

- (id)initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (self.isTopPosition) {
        [self topPath:context Rect:rect];
    } else {
        [self bottomPath:context Rect:rect];
    }
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillPath(context);

    if (self.isTopPosition) {
        [self topPath:context Rect:rect];
    } else {
        [self bottomPath:context Rect:rect];
    }
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextStrokePath(context);

}

- (void)topPath:(CGContextRef) context Rect:(CGRect) rect {
    CGContextMoveToPoint(context, 0.0, rect.size.height / 2);
    CGContextAddLineToPoint(context, (rect.size.width / 5 * 2), rect.size.height / 2);
    CGContextAddLineToPoint(context, rect.size.width / 2, 0.0);
    CGContextAddLineToPoint(context, rect.size.width - (rect.size.width / 5 * 2),
        rect.size.height / 2);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height / 2);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, 0.0, rect.size.height);
    CGContextClosePath(context);
}

- (void)bottomPath:(CGContextRef) context Rect:(CGRect) rect {
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, rect.size.width, 0.0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height / 2);
    CGContextAddLineToPoint(context, rect.size.width - (rect.size.width / 5 * 2),
        rect.size.height / 2);
    CGContextAddLineToPoint(context, rect.size.width / 2, rect.size.height);
    CGContextAddLineToPoint(context, (rect.size.width / 5 * 2), rect.size.height / 2);
    CGContextAddLineToPoint(context, 0.0, rect.size.height / 2);
    CGContextClosePath(context);
}

- (void)setNeedsLayout {
    if (self.isTopPosition) {
        self.tipLabel.verticalAlignment = VerticalAlignmentBottom;
    } else {
        self.tipLabel.verticalAlignment = VerticalAlignmentTop;
    }
}

- (void)setIsTopPosition:(BOOL) isTopPosition {
    _isTopPosition = isTopPosition;
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

@end
