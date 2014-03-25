//
// Created by azu on 2014/03/03.
//


#import <ArsScale/ArsScaleLinear.h>
#import <MHNibLoading/UIView+MHNibLoading.h>
#import "LineChartTileView.h"
#import "DrowningGraphicer.h"
#import "DrowningGraphicsLineContext.h"
#import "DrowningGraphicsArcContext.h"
#import "ToolTipView.h"
#import "VerticallyAlignedLabel.h"
#import "LineChartPlotData.h"


@interface LineChartTileView ()
@property(nonatomic, weak) LineChartPlotData *selectedPlotData;
@property(nonatomic, strong) ToolTipView *toolTipView;
@property(nonatomic) CGSize arcSize;
@end

@implementation LineChartTileView {

}

- (void)drawRect:(CGRect) rect {
    [super drawRect:rect];
    CGSize size = self.bounds.size;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = NO;
    self.arcSize = CGSizeMake(10, 10);
    [self drawContext:context size:size];
}

// prev -> current -> next
- (void)drawContext:(CGContextRef) context size:(CGSize) size {
    DrowningGraphicer *drowning = [DrowningGraphicer drowningWithContextRef:context];
    [self.plotDataArray enumerateObjectsUsingBlock:^(LineChartPlotData *plotData, NSUInteger idx, BOOL *stop) {
        [self draw:drowning size:size plotData:plotData];
    }];
}

- (CGRect)arcRectForPlotData:(LineChartPlotData *) data {
    CGSize canvasSize = self.frame.size;
    CGFloat centerX = canvasSize.width / 2;
    CGPoint startPoint = CGPointMake(centerX,
        canvasSize.height - [self.yScale scale:data.currentValue].floatValue);
    return CGRectMake(
        startPoint.x - (self.arcSize.width / 2),
        startPoint.y - (self.arcSize.height / 2),
        self.arcSize.width, self.arcSize.height);;
}

- (void)draw:(DrowningGraphicer *) drowning size:(CGSize) size plotData:(LineChartPlotData *) plotData {
    NSNumber *currentY = plotData.currentValue;
    NSNumber *prevY = plotData.prevValue;
    NSNumber *nextY = plotData.nextValue;
    CGFloat centerX = size.width / 2;
    [drowning lineContext:^(DrowningGraphicsLineContext *line) {
        [line drawLine:CGPointMake(centerX, 0) endPoint:CGPointMake(centerX,
            self.dateLabel.frame.origin.y) lineColor:[UIColor blackColor]];
    }];


    CGPoint startPoint = CGPointMake(centerX,
        size.height - [self.yScale scale:currentY].floatValue);
    UIColor *blueColor = [UIColor colorWithRed:0.275 green:0.596 blue:0.820 alpha:1.0];
    if (prevY != nil) {// first
        CGPoint prevEnd = CGPointMake(-centerX,
            size.height - [self.yScale scale:prevY].floatValue);
        [drowning lineContext:^(DrowningGraphicsLineContext *line) {
            [line drawLine:prevEnd endPoint:startPoint lineColor:blueColor];
        }];
    }
    if (nextY != nil) {
        CGPoint endPoint = CGPointMake(centerX + size.width, size.height -
            [self.yScale scale:nextY].floatValue);
        [drowning lineContext:^(DrowningGraphicsLineContext *line) {
            [line drawLine:startPoint endPoint:endPoint lineColor:blueColor];
        }];
    }
    [drowning arcContext:^(DrowningGraphicsArcContext *arcContext) {
        if (self.selectedPlotData == plotData) {
            UIColor *orangeColor = [UIColor colorWithRed:0.918 green:0.435 blue:0.165 alpha:1.0];
            [arcContext drawFilledCircle:startPoint radius:self.arcSize.width / 2 color:orangeColor];
        } else {
            [arcContext drawFilledCircle:startPoint radius:self.arcSize.width / 2 color:blueColor];
        }
    }];
}



#pragma mark - touch delegate
- (void)touchesEnded:(NSSet *) touches withEvent:(UIEvent *) event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self detectTouchDataAtPoint:point];
}

- (void)detectTouchDataAtPoint:(CGPoint) point {
    // 10px hittestを拡大
    [self.plotDataArray enumerateObjectsUsingBlock:^(LineChartPlotData *plotData, NSUInteger idx, BOOL *stop) {
        CGRect drawArcRect = [self arcRectForPlotData:plotData];
        CGRect hitRect = CGRectInset(drawArcRect, -10, -10);
        if (CGRectContainsPoint(hitRect, point)) {
            [self toggleToolTipView:plotData];
            [self setNeedsDisplay];
        }
    }];
}

- (ToolTipView *)toolTipView {
    if (_toolTipView == nil) {
        _toolTipView = [ToolTipView loadInstanceFromNib];
        [self addSubview:_toolTipView];
    }
    return _toolTipView;
}

- (void)toggleToolTipView:(LineChartPlotData *) plotData {
    CGRect drawArcRect = [self arcRectForPlotData:plotData];
    CGPoint kitCenterPoint = drawArcRect.origin;
    CGSize tooltipSize = self.toolTipView.frame.size;
    CGRect normalRect = CGRectMake(kitCenterPoint.x - (tooltipSize.width / 2) + 5,
        kitCenterPoint.y - tooltipSize.height - 5,
        tooltipSize.width,
        tooltipSize.height);
    if (CGRectContainsRect(self.bounds, normalRect)) {
        self.toolTipView.isTopPosition = NO;
        self.toolTipView.frame = normalRect;
    } else {// はみ出てるなら◀を反転させる
        self.toolTipView.isTopPosition = YES;
        self.toolTipView.frame = CGRectOffset(normalRect, 0, tooltipSize.height + 10);
    }
    self.toolTipView.tipLabel.text = [NSString stringWithFormat:@"%0.1f", plotData.currentValue.floatValue];
    if (self.selectedPlotData == plotData) {
        self.toolTipView.hidden = YES;
        self.selectedPlotData = nil;
    } else {
        self.toolTipView.hidden = NO;
        self.selectedPlotData = plotData;
    }
}

- (void)reset {
    self.toolTipView.hidden = YES;
    self.selectedPlotData = nil;
}
@end