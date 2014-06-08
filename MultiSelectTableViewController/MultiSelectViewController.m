//
//  MultiSelectViewController.m
//  MultiSelectTableViewController
//
//  Created by molon on 6/7/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "MultiSelectViewController.h"
#import "MLLetterIndexNavigationView.h"
#import "MultiSelectItem.h"
#import "MultiSelectTableViewCell.h"

@interface MultiSelectViewController ()<UITableViewDataSource,UITableViewDelegate,MLLetterIndexNavigationViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) NSMutableDictionary *dict;

@property (nonatomic, strong) MLLetterIndexNavigationView *letterIndexView;

@end

@implementation MultiSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择联盟商家";
    self.view.backgroundColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    self.tableView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    
    //处理传递进来的数组成字典
    self.dict = [NSMutableDictionary dictionary];
    NSMutableArray *letters = [@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"]mutableCopy];
    for (NSString *letter in letters) {
        self.dict[letter] = [NSMutableArray array];//先初始化其
    }
    
    for (MultiSelectItem *item in self.items) {
        NSString *firstLetter = [self firstLetterOfString:item.name];
        [self.dict[firstLetter] addObject:item]; //对应的字母数组添加元素。
    }
    
    //删除没有元素的字母key
    for (NSString *key in [self.dict allKeys]) {
        if (((NSArray*)self.dict[key]).count<=0) {
            [self.dict removeObjectForKey:key];
            [letters removeObject:key]; //由于字典是无序的，这里刚好把此数组作为有效key的排序结果。
        }else{
            //对这个数组进行字母排序，系统方法就可以对汉字排序，第一个汉字的首字母，第二个字母。。。这样来排序。
            self.dict[key] = [((NSArray*)self.dict[key]) sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [((MultiSelectItem *)obj1).name localizedCompare:((MultiSelectItem *)obj2).name];
            }];
        }
    }
    
    //整理完毕，将key的排序结果记录
    self.keys = letters;
    
    self.letterIndexView.keys = self.keys;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.letterIndexView];
    [self.tableView setEditing:YES];

    //设置默认选择的
    for (NSUInteger section=0; section<self.keys.count; section++) {
        for (NSUInteger row=0; row<((NSArray*)self.dict[self.keys[section]]).count; row++) {
            MultiSelectItem *item = ((NSArray*)self.dict[self.keys[section]])[row];
            if (item.selected) {
                [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (UITableView *)tableView
{
	if (!_tableView) {
		_tableView = [[UITableView alloc]init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
	}
	return _tableView;
}

- (MLLetterIndexNavigationView *)letterIndexView
{
	if (!_letterIndexView) {
		_letterIndexView = [[MLLetterIndexNavigationView alloc]init];
        _letterIndexView.delegate = self;
	}
	return _letterIndexView;
}

#pragma mark - layout
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    //导航View的位置
    self.letterIndexView.frame = CGRectMake(self.tableView.frame.origin.x+self.tableView.frame.size.width-20, self.tableView.frame.origin.y, 20, self.tableView.frame.size.height);
}

#pragma mark - letter index delegate
- (void)mlLetterIndexNavigationView:(MLLetterIndexNavigationView *)mlLetterIndexNavigationView didSelectIndex:(NSInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.keys.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.keys[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((NSArray*)self.dict[self.keys[section]]) count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MultiSelectTableViewCell";
    MultiSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [MultiSelectTableViewCell instanceFromNib];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    MultiSelectItem *item = ((NSArray*)self.dict[self.keys[indexPath.section]])[indexPath.row];
    
    cell.cellImageView.image = [UIImage imageNamed:item.imageName];
    cell.label.text = item.name;
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

-  (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MultiSelectItem *item = ((NSArray*)self.dict[self.keys[indexPath.section]])[indexPath.row];
    
    if (!item.disabled) {
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }
    
    return UITableViewCellEditingStyleNone;
}

//有这个才能激活编辑状态
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

//添加一项
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"添加%ld",indexPath.row);
    if (indexPath.row==0) {
        
//        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:20 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        
        //        for (NSUInteger i=0; i<50; i++) {
        //            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        //        }
    }
}

//取消一项
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消%ld",indexPath.row);
}

#pragma mark - common
- (NSString*)firstLetterOfString:(NSString*)chinese
{
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, (__bridge CFMutableStringRef)[NSMutableString stringWithString:chinese]);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSMutableString *aNSString = (__bridge NSMutableString *)string;
    NSString *finalString = [aNSString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c", 32] withString:@""];
    
    
    NSString *firstLetter = [[finalString substringToIndex:1]uppercaseString];
    if (!firstLetter||firstLetter.length<=0) {
        firstLetter = @"#";
    }
    return firstLetter;
}
@end
