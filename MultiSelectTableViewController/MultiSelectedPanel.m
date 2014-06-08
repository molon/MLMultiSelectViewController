//
//  MultiSelectedPanel.m
//  MultiSelectTableViewController
//
//  Created by molon on 6/8/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "MultiSelectedPanel.h"

@interface MultiSelectedPanel()

@property (weak, nonatomic) IBOutlet UIImageView *bkgImageView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MultiSelectedPanel

+ (instancetype)instanceFromNib
{
    return [[[NSBundle mainBundle]loadNibNamed:@"MultiSelectedPanel" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUp];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setUp
{
    self.bkgImageView.image = [[UIImage imageNamed:@"MultiSelectedPanelBkg"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    [self.confirmBtn setTitle:@"" forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundImage:[[UIImage imageNamed:@"MultiSelectedPanelConfirmBtnbKG"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)] forState:UIControlStateNormal];
}


@end
