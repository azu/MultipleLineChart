//
// Created by azu on 2014/03/03.
//


#import <ArsScale/ArsScaleLinear.h>
#import "BodyWeightGraphViewController.h"
#import "BodyWeightGraphViewModel.h"
#import "LineChartTileView.h"
#import "UIView+MHNibLoading.h"
#import "GraphAxisView.h"
#import "GraphGroupDataSource.h"
#import "ArsRange.h"
#import "ASTMap.h"


@interface BodyWeightGraphViewController ()
@property(weak, nonatomic) IBOutlet DARecycledScrollView *plotScrollView;
@property(weak, nonatomic) IBOutlet GraphAxisView *yAxisView;
@property(strong, nonatomic) BodyWeightGraphViewModel *graphViewModel;
@property(nonatomic, strong) ArsScaleLinear *yScale;
@end

@implementation BodyWeightGraphViewController {

}
- (BodyWeightGraphViewModel *)graphViewModel {
    if (_graphViewModel == nil) {
        _graphViewModel = [[BodyWeightGraphViewModel alloc] init];
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
    LineChartTileView *bodyWeightDataView = (LineChartTileView *)tileView;
    [bodyWeightDataView reset];
    bodyWeightDataView.yScale = self.yScale;
    NSArray *rangeIndex = ArsRange(@0, @([self.graphViewModel numberOfLines]));
    bodyWeightDataView.dateLabel.text = [self.graphViewModel textAtIndex:index];
    bodyWeightDataView.plotDataArray = ASTMap(rangeIndex, ^id(NSNumber *number) {
        LineChartIndexPath indexPath = {.lineNumber = [number unsignedIntegerValue], .dataNumber = index};
        return [self.graphViewModel plotDataAtIndexPath:indexPath];
    });
    [bodyWeightDataView setNeedsDisplay];
}

- (DARecycledTileView *)tileViewForRecycledScrollView:(DARecycledScrollView *) scrollView {
    LineChartTileView *bodyWeightDataView = (LineChartTileView *)[scrollView dequeueRecycledTileView];
    if (bodyWeightDataView == nil) {
        bodyWeightDataView = [LineChartTileView loadInstanceFromNib];
        bodyWeightDataView.backgroundColor = [UIColor clearColor];
    }
    return bodyWeightDataView;
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