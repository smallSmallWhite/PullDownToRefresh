//
//  ViewController.m
//  RefreshControler
//
//  Created by mac on 2018/7/15.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>
#import "PSRefreshControl.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource
>

//tableView
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"下拉刷新";
    [self.view addSubview:self.tableView];
    
    PSRefreshGifHeader *headerRefresh = [PSRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(BK_Order_Update_Header)];
    self.tableView.mj_header = headerRefresh;
}

- (void)BK_Order_Update_Header {
    
    [self.tableView.mj_header endRefreshing];
    
}

#pragma mark ==================UITableViewDelegate==================
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"测试数据";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ==================懒加载==================
-(UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
