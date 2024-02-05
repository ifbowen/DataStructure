//
//  ViewController.m
//  DataStructure
//
//  Created by Bowen on 2020/6/15.
//  Copyright © 2020 inke. All rights reserved.
//

#import "ViewController.h"
#import "MBSequenceListViewController.h"
#import "MBSingleLinkListViewController.h"
#import "MBDoubleLinkListViewController.h"
#import "MBBinaryTreeViewController.h"
#import "MBQueueViewController.h"
#import "MBStackViewController.h"
#import "MBStringViewController.h"
#import "MBSortAlgorithmViewController.h"
#import "MBLowestCommonAncestorViewController.h"
#import "MBDynamicProgrammingViewController.h"
#import "MBBacktrackViewController.h"
#import "MBGreedyViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *tableArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"数据结构";
}

- (void)setupData
{
    self.tableArray = @[@"顺序表", @"单链表", @"双链表", @"队列", @"栈", @"串", @"二叉树", @"排序", @"最近公共祖先", @"动态规划与递归算法", @"回溯算法和DFS", @"迭代算法", @"贪心算法", @"分治法", @"分支限界法"];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = ({
        UITableView *tb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        tb.backgroundColor = [UIColor clearColor];
        tb.dataSource = self;
        tb.delegate = self;
        [tb registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:tb];
        tb;
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.tableArray[indexPath.row];
    cell.textLabel.layer.masksToBounds = YES;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc;
    if (indexPath.row == 0) {
        vc = [[MBSequenceListViewController alloc] init];
        vc.navigationItem.title = @"顺序表";
    }
    if (indexPath.row == 1) {
        vc = [[MBSingleLinkListViewController alloc] init];
        vc.navigationItem.title = @"单链表";
    }
    if (indexPath.row == 2) {
        vc = [[MBDoubleLinkListViewController alloc] init];
        vc.navigationItem.title = @"双链表";
    }
    if (indexPath.row == 3) {
        vc = [[MBQueueViewController alloc] init];
        vc.navigationItem.title = @"队列";
    }
    if (indexPath.row == 4) {
        vc = [[MBStackViewController alloc] init];
        vc.navigationItem.title = @"栈";
    }
    if (indexPath.row == 5) {
        vc = [[MBStringViewController alloc] init];
        vc.navigationItem.title = @"串";
    }
    if (indexPath.row == 6) {
        vc = [[MBBinaryTreeViewController alloc] init];
        vc.navigationItem.title = @"二叉树";
    }
    if (indexPath.row == 7) {
        vc = [[MBSortAlgorithmViewController alloc] init];
        vc.navigationItem.title = @"排序算法";
    }
    if (indexPath.row == 8) {
        vc = [[MBLowestCommonAncestorViewController alloc] init];
        vc.navigationItem.title = @"最近公共祖先";
    }
    if (indexPath.row == 9) {
        vc = [[MBDynamicProgrammingViewController alloc] init];
        vc.navigationItem.title = @"动态规划与递归算法";
    }
    if (indexPath.row == 10) {
        vc = [[MBBacktrackViewController alloc] init];
        vc.navigationItem.title = @"回溯算法";
    }
    if (indexPath.row == 11) {
        vc = [[MBGreedyViewController alloc] init];
        vc.navigationItem.title = @"贪心算法";
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}



@end
