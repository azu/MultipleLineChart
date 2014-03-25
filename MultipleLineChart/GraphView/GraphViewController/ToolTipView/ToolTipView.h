//
//  ToolTipView.h
//


@class VerticallyAlignedLabel;

@interface ToolTipView : UIView
@property(nonatomic) BOOL isTopPosition;
@property(weak, nonatomic) IBOutlet VerticallyAlignedLabel *tipLabel;
@end
