//
//  ToolTipView.h
//  DiabetesNote
//
//  Created by meetaworks on 2013/02/17.
//  Copyright (c) 2013年 meetaworks. All rights reserved.
//


@class VerticallyAlignedLabel;

@interface ToolTipView : UIView
@property(nonatomic) BOOL isTopPosition;
@property(weak, nonatomic) IBOutlet VerticallyAlignedLabel *tipLabel;
@end
