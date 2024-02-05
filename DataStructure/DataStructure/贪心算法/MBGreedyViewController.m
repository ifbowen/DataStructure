//
//  MBGreedyViewController.m
//  DataStructure
//
//  Created by wenbo on 2024/1/13.
//  Copyright © 2024 inke. All rights reserved.
//

#import "MBGreedyViewController.h"

@interface MBGreedyViewController ()

@end

@implementation MBGreedyViewController

/**
 跳跃游戏 II
 给定一个长度为 n 的 0 索引整数数组 nums。初始位置为 nums[0]。
 每个元素 nums[i] 表示从索引 i 向前跳转的最大长度。换句话说，如果你在 nums[i] 处，你可以跳转到任意 nums[i + j] 处:
 0 <= j <= nums[i]
 i + j < n
 返回到达 nums[n - 1] 的最小跳跃次数。生成的测试用例可以到达 nums[n - 1]。
 
 贪心算法：
 通过局部最优解得到全局最优解
 
 贪心算法与动态规划：
 贪心算法对每个子问题的解决方案都做出选择，不能回退；
 动态规划则会根据以前的选择结果对当前进行选择，有回退功能。

 贪心算法的基本步骤：
 - 从某个初始解出发；
 - 采用迭代的过程，当可以向目标前进一步时，就根据局部最优策略，得到一部分解，缩小问题规模；
 - 将所有解综合起来。
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSLog(@"%ld", [self jump:@[@2, @3, @1, @1, @4]]);
}

- (NSInteger)jump:(NSArray *)nums {
    NSInteger count = 0;
    NSInteger start = 0, end = 1;
    while (end < nums.count) {
        NSInteger maxNum = 0;
        for (NSInteger index = start; index < end; index++) {
            // 能跳到最远的距离
            maxNum = MAX(maxNum, index + [nums[index] integerValue]);
        }
        // 下一次起跳点范围开始的格子
        start = end;
        // 下一次起跳点范围结束的格子
        end = maxNum + 1;
        // 跳跃次数
        count++;
    }
    return count;
}
@end
