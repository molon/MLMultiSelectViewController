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
    //网上拉的昵称列表，请忽视非主流。
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
                      @"1③⒋4.⒈",
                      @"殇、箌茈僞祉",
                      ];
    
    NSArray *avatarURLs = @[
                            @"http://v1.qzone.cc/avatar/201406/08/18/50/53943ff25f268523.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/35/53943c70b54e9227.jpeg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/51/539440434b1c7139.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/48/53943f8408bea913.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/48/53943f8ae0384052.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/49/53943fcbb3be9306.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/38/53943d320f616180.png!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/47/53943f469a925760.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/46/53943f1a6b0ee418.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/47/53943f5ec2961034.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/47/53943f486e7ae921.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/45/53943ebae083b101.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/45/53943ec67c849838.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/45/53943ed21aa91813.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/45/53943ec4449f3999.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/43/53943e4e5733a368.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/43/53943e5d120b6630.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dc293e22403.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/43/53943e6188616462.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/43/53943e3b42266017.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dea86fa9728.png!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/42/53943e2c732d6796.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/40/53943da63ea18098.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dec0428e119.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dea86fa9728.png!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dec0428e119.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/42/53943e2c732d6796.jpg!180x180.jpg",
                            ];
    
    for (NSUInteger i=0; i<names.count; i++) {
        MultiSelectItem *item = [[MultiSelectItem alloc]init];
        item.imageURL = [NSURL URLWithString:avatarURLs[i]];
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
    
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:navVC animated:YES completion:nil];
}

@end
