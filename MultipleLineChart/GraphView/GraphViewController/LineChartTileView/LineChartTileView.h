//
// Created by azu on 2014/03/03.
//


#import <Foundation/Foundation.h>
#import "DARecycledTileView.h"

@class ArsScaleLinear;
@class ToolTipView;


@interface LineChartTileView : DARecycledTileView
@property (nonatomic) NSArray *plotDataArray;
@property (nonatomic, weak) ArsScaleLinear *yScale;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)reset;
@end