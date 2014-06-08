//
//  MultiSelectTableViewCell.m
//  MultiSelectTableViewController
//
//  Created by molon on 6/8/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "MultiSelectTableViewCell.h"

@implementation MultiSelectTableViewCell

+ (instancetype)instanceFromNib
{
    return [[[NSBundle mainBundle]loadNibNamed:@"MultiSelectTableViewCell" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    // Initialization code
    [self reset];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self reset];
}

- (void)reset
{
    self.cellImageView.image = nil;
    self.label.text = @" ";
}

@end
