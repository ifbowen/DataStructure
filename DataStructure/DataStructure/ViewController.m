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
    self.tableArray = @[@"顺序表", @"单链表"];
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
    [self.navigationController pushViewController:vc animated:YES];
}



@end
