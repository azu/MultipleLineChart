//
//  DetailViewController.h
//  MultipleLineChart
//
//  Created by azu on 2014/03/25.
//  Copyright (c) 2014年 azu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
