//
//  ViewController.m
//  MultiSelectTableViewController
//
//  Created by molon on 6/7/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "ViewController.h"
#import "MultiSelectViewController.h"
#import "MultiSelectItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)press:(id)sender {
    
    //建立100个测试数据
    NSMutableArray *items = [NSMutableArray array];
    NSArray *names = @[@"貓眼无敌",
                      @"涽暗丶芉咮帘",
                      @"一个人搁浅",
                      @"时间像沙漏一样穿过瓶颈。",
                      @"朶，莪哋囡亾-",
                      @"得不到的在乎",
                      @"请不要留恋 .",
                      @"草bian的戒指",
                      @"y1旧、狠轻狂",
                      @"阿娇的垃圾的死了快回答了",
                      @"Angel、葬爱",
                      @"花无心。",
                      @"別致の情緒",
                      @"最近的心跳╰",
                      @"莪想莪慬嘚",
                      @"祂誓〃：毅丹",
                      @"╃渼锝Ъú橡話♂",
                      @"盗梦空间",
                      @"飘流瓶丶逆反",
                      @"①個〆国产纯货ル",
                      @"请你别敷衍ら",
                      @"乱挺爱4@",
                      @"︶￣浮动",
                      @"无规则 Rules°",
                      @"——拽、杀。",
                      @"③⒋4.⒈",
                      @"殇、箌茈僞祉",
                      ];
    for (NSUInteger i=0; i<names.count; i++) {
        MultiSelectItem *item = [[MultiSelectItem alloc]init];
        item.imageName = @"avatar.jpg";
        item.name = names[i];
        if (i==10||(i>4&&i<8)) {
            item.selected = YES;
        }
        if (i==6||i==9) {
            item.disabled = YES;
        }
        [items addObject:item];
    }
    MultiSelectViewController *vc = [[MultiSelectViewController alloc]init];
    vc.items = items;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
