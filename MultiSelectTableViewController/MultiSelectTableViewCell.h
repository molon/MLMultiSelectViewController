//
//  MultiSelectTableViewCell.h
//  MultiSelectTableViewController
//
//  Created by molon on 6/8/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiSelectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@property (weak, nonatomic) IBOutlet UILabel *label;

+ (instancetype)instanceFromNib;

@end
