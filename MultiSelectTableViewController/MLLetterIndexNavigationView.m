//
//  MLLetterIndexNavigationView.m
//  SecondhandCar
//
//  Created by molon on 14-1-8.
//  Copyright (c) 2014年 Molon. All rights reserved.
//

#import "MLLetterIndexNavigationView.h"
#import "MLLetterIndexNavigationItem.h"
//#import "MolonCore.h"

@interface MLLetterIndexNavigationView()

@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) NSMutableArray *items;

@end

@implementation MLLetterIndexNavigationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
}

- (UIView*)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (void)setKeys:(NSArray *)keys
{
    if ([keys isEqual:_keys]) {
        return;
    }
    
    _keys = keys;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除所有的子View，重新加载
    self.items = [NSMutableArray array];
    
    for (NSUInteger i=0; i<self.keys.count; i++) {
        MLLetterIndexNavigationItem *item = [[MLLetterIndexNavigationItem alloc]init];
        item.text = self.keys[i];
        item.index = i;
        [self.contentView addSubview:item];
        [self.items addObject:item];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.keys) {
        return;
    }
    
    //整理自身的数据
#define kMaxItemHeight 15  //最高20高度，如果太多的话可能会重叠
    CGFloat itemHeight = self.frame.size.height/self.keys.count;
    if (itemHeight>kMaxItemHeight) {
        itemHeight = kMaxItemHeight;
    }
    
    CGFloat lastY = 0;
    for (MLLetterIndexNavigationItem *item in self.items) {
        item.frame = CGRectMake(0, lastY, self.frame.size.width, itemHeight);
        lastY+=itemHeight;
    }
    //内容View放在中间
    self.contentView.frame = CGRectMake(0, (self.frame.size.height-lastY)/2, self.frame.size.width, lastY);
}


- (void)unHighlightAllItem
{
    //全局取消高亮
    for (MLLetterIndexNavigationItem *item in self.items) {
        item.isHighlighted = NO;
    }
}

#pragma mark - 下面处理触摸事件

- (void)findAndSelectItemWithTouchPoint:(CGPoint)touchPoint
{
    for (MLLetterIndexNavigationItem *item in self.items) {
        if (CGRectContainsPoint(item.frame, touchPoint)) {
            [self unHighlightAllItem];
            item.isHighlighted = YES;//设置其高亮
            //找到了选择的index
            if (self.delegate&&[self.delegate respondsToSelector:@selector(mlLetterIndexNavigationView:didSelectIndex:)]) {
                [self.delegate mlLetterIndexNavigationView:self didSelectIndex:item.index];
            }
            return;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.contentView];
    
    [self findAndSelectItemWithTouchPoint:touchPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.contentView];
    
    [self findAndSelectItemWithTouchPoint:touchPoint];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self unHighlightAllItem];
}


@end
