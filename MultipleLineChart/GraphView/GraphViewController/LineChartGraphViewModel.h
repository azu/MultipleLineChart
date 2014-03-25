//
// Created by azu on 2014/03/03.
//


#import <Foundation/Foundation.h>

@class GraphGroupDataSource;
@class LineChartPlotData;
struct LineChartIndexPath {
    NSUInteger lineNumber;
    // 何本目の線
    NSUInteger dataNumber;// 何個目のデータ
};
typedef struct LineChartIndexPath LineChartIndexPath;

@interface LineChartGraphViewModel : NSObject
- (NSInteger)numberOfLines;

- (NSInteger)numberOfData;

- (NSNumber *)highestDataNumber;

- (NSNumber *)lowestDataNumber;


- (LineChartPlotData *)plotDataAtIndexPath:(LineChartIndexPath) index1;

- (BOOL)hasValidDataAtIndexPath:(LineChartIndexPath) indexPath;

- (void)reloadData;

- (NSString *)textAtIndex:(NSUInteger) index;
@end