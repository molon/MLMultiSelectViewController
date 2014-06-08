//
//  MultiSelectItem.h
//  MultiSelectTableViewController
//
//  Created by molon on 6/7/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiSelectItem : NSObject

@property (nonatomic, copy) NSString *imageName; //图片名字
@property (nonatomic, copy) NSString *name; //名字
@property (nonatomic, assign) BOOL disabled; //是否不让选择
@property (nonatomic, assign) bool selected; //是否已经被选择

@end