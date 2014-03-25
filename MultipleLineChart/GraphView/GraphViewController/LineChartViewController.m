//
// Created by azu on 2014/03/03.
//


#import <ArsScale/ArsScaleLinear.h>
#import "LineChartViewController.h"
#import "LineChartGraphViewModel.h"
#import "LineChartTileView.h"
#import "UIView+MHNibLoading.h"
#import "GraphAxisView.h"
#import "GraphGroupDataSource.h"
#import "ArsRange.h"
#import "ASTMap.h"


@interface LineChartViewController ()
@property(weak, nonatomic) IBOutlet DARecycledScrollView *plotScrollView;
@property(weak, nonatomic) IBOutlet GraphAxisView *yAxisView;
@property(strong, nonatomic) LineChartGraphViewModel *graphViewModel;
@property(nonatomic, strong) ArsScaleLinear *yScale;
@end

@implementation LineChartViewController {

}
- (LineChartGraphViewModel *)graphViewModel {
    if (_graphViewModel == nil) {
        _graphViewModel = [[LineChartGraphViewModel alloc] init];
    }
    return _graphViewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.plotScrollView.dataSource = self;
}

- (void)viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    [self.graphViewModel reloadData];
    self.plotScrollView.layer.borderWidth = 1;
    self.plotScrollView.layer.borderColor = [UIColor blackColor].CGColor;
    CGFloat margin = 20;
    self.yScale = [[ArsScaleLinear alloc] init];
    self.yScale.domain = @[[self.graphViewModel lowestDataNumber], [self.graphViewModel highestDataNumber]];
    self.yScale.range = @[@(margin), @(self.plotScrollView.frame.size.height - margin)];
    [self.plotScrollView reloadData];

    self.yAxisView.yScale = self.yScale;
    [self.yAxisView reDrawView];
}


- (NSInteger)numberOfTilesInScrollView:(DARecycledScrollView *) scrollView {
    return [self.graphViewModel numberOfData];
}

- (void)recycledScrollView:(DARecycledScrollView *) scrollView configureTileView:(DARecycledTileView *) tileView forIndex:(NSUInteger) index {
    LineChartTileView *lineChartTileView = (LineChartTileView *)tileView;
    [lineChartTileView reset];
    lineChartTileView.yScale = self.yScale;
    NSArray *rangeIndex = ArsRange(@0, @([self.graphViewModel numberOfLines]));
    lineChartTileView.dateLabel.text = [self.graphViewModel textAtIndex:index];
    lineChartTileView.plotDataArray = ASTMap(rangeIndex, ^id(NSNumber *number) {
        LineChartIndexPath indexPath = {.lineNumber = [number unsignedIntegerValue], .dataNumber = index};
        return [self.graphViewModel plotDataAtIndexPath:indexPath];
    });
    [lineChartTileView setNeedsDisplay];
}

- (DARecycledTileView *)tileViewForRecycledScrollView:(DARecycledScrollView *) scrollView {
    LineChartTileView *lineChartTileView = (LineChartTileView *)[scrollView dequeueRecycledTileView];
    if (lineChartTileView == nil) {
        lineChartTileView = [LineChartTileView loadInstanceFromNib];
        lineChartTileView.backgroundColor = [UIColor clearColor];
    }
    return lineChartTileView;
}

- (CGFloat)widthForTileAtIndex:(NSInteger) index1 scrollView:(DARecycledScrollView *) scrollView {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 70.0f;
    } else {
        return 100.0f;
    }
}

// lock vertical scroll
- (void)scrollViewDidScroll:(id) scrollView {
    CGPoint origin = [scrollView contentOffset];
    [scrollView setContentOffset:CGPointMake(origin.x, 0.0)];
}

@end