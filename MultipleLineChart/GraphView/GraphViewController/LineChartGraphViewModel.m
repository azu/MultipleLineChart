//
// Created by azu on 2014/03/03.
//


#import "LineChartGraphViewModel.h"
#import "ArsMinMax.h"
#import "GraphGroupDataSource.h"
#import "ASTMap.h"
#import "LineChartPlotData.h"
#import "ArsRange.h"

@interface LineChartGraphViewModel ()
@property(nonatomic, strong) NSArray *graphDataSources;
@property(nonatomic, strong) NSArray *axisLabels;
@end

@implementation LineChartGraphViewModel {

}
- (void)reloadData {
    // set data..
    NSArray *array = ArsRange(@5, @100, @3);
    GraphGroupDataSource *oneDataSource = [GraphGroupDataSource dataSourceWithValues:array];
    NSArray *twoArray = ASTMap(array, ^id(NSNumber *obj) {
        return @(obj.integerValue + arc4random_uniform(80));
    });
    GraphGroupDataSource *twiDataSource = [GraphGroupDataSource dataSourceWithValues:twoArray];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    self.axisLabels = ASTMap(array, ^id(id obj, NSUInteger idx) {
        return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:idx * 60 * 60 * 24]];
    });
    self.graphDataSources = @[oneDataSource, twiDataSource];
}

- (NSInteger)numberOfLines {
    return [self.graphDataSources count];
}

- (NSInteger)numberOfData {
    if ([self.graphDataSources count] == 0) {
        return 0;
    }
    GraphGroupDataSource *dataSource = [self.graphDataSources firstObject];
    return [dataSource numberOfData];
}

- (NSNumber *)highestDataNumber {
    if ([self.graphDataSources count] == 0) {
        return @1;
    }
    NSArray *numbers = ASTMap(self.graphDataSources, ^id(GraphGroupDataSource *dataSource) {
        return [dataSource highestValue];
    });
    return @([ArsMax(numbers) floatValue] + 5);
}

- (NSNumber *)lowestDataNumber {
    if ([self.graphDataSources count] == 0) {
        return @0;
    }
    NSArray *numbers = ASTMap(self.graphDataSources, ^id(GraphGroupDataSource *dataSource) {
        return [dataSource lowestValue];
    });
    return @(MAX([ArsMin(numbers) floatValue] - 10, 0));
}


- (NSNumber *)valueAtLineIndexPath:(LineChartIndexPath) indexPath {
    if (indexPath.lineNumber >= 0 && indexPath.lineNumber < [self numberOfLines]) {
        GraphGroupDataSource *dataSource = self.graphDataSources[indexPath.lineNumber];
        return [dataSource valueAtIndex:indexPath.dataNumber];
    }
    return nil;
}

LineChartIndexPath MoveGraphLineIndexPath(LineChartIndexPath indexPath, NSInteger distance) {
    LineChartIndexPath newPath;
    newPath.lineNumber = indexPath.lineNumber;
    newPath.dataNumber = indexPath.dataNumber + distance;
    return newPath;
}

- (LineChartPlotData *)plotDataAtIndexPath:(LineChartIndexPath) index {
    LineChartPlotData *plotData = [[LineChartPlotData alloc] init];
    plotData.prevValue = [self valueAtLineIndexPath:MoveGraphLineIndexPath(index, -1)];
    plotData.currentValue = [self valueAtLineIndexPath:index];
    plotData.nextValue = [self valueAtLineIndexPath:MoveGraphLineIndexPath(index, 1)];
    return plotData;
}

- (BOOL)hasValidDataAtIndexPath:(LineChartIndexPath) indexPath {
    if (indexPath.lineNumber >= 0 && indexPath.lineNumber < [self numberOfLines]) {
        GraphGroupDataSource *dataSource = self.graphDataSources[indexPath.lineNumber];
        if (indexPath.dataNumber < [dataSource numberOfData]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)textAtIndex:(NSUInteger) index {
    return self.axisLabels[index];
}
@end