//
//  MBBacktrackViewController.m
//  DataStructure
//
//  Created by wenbo on 2024/1/7.
//  Copyright © 2024 inke. All rights reserved.
//

#import "MBBacktrackViewController.h"

@interface MBBacktrackViewController ()

@end

@implementation MBBacktrackViewController

/**
 回溯法（back tracking）:
 是一种选优搜索法，以选优条件向前搜索，以达到目标。当探索到某一步时，发现原先选择达不到目标，就退回一步重新选择。
 之所以称之为回溯算法，是因为该算法在搜索解空间时会采用“尝试”与“回退”的策略
 回溯的本质是穷举，穷举所有可能，然后选出我们想要的答案。
 
 如何理解回溯法
 回溯法解决的问题都可以抽象为树形结构
 
 剪枝
 复杂的回溯问题通常包含一个或多个约束条件，约束条件通常可用于“剪枝”。
 
 解决的问题
 - 组合问题：N个数⾥⾯按⼀定规则找出k个数的集合
 - 切割问题：⼀个字符串按⼀定规则有⼏种切割⽅式
 - ⼦集问题：⼀个N个数的集合⾥有多少符合条件的⼦集
 - 排列问题：N个数按⼀定规则全排列，有⼏种排列⽅式
 - 棋盘问题：N皇后，解数独等等。
 
 回溯法与 DFS
 深度优先搜索适用于所有图。而回溯算法只适用于树结构。
 回溯算法 = 树的深度优先搜索 + 剪枝函数

 递归与回溯的区别
 递归是一种算法结构。递归会出现在子程序中，形式上表现为直接或间接的自己调用自己。典型的例子是阶乘：n * f(n - 1)
 回溯是一种算法思想，它是用递归实现的。回溯的过程类似于穷举法，但回溯有“剪枝”功能，即自我判断过程。
 
 回溯算法的步骤包括：
 选择：在每一步都需要在一个决策树中做出选择。
 约束：每一步都会有一些约束，只有满足约束的选择才会被接受。
 目标：我们有一个目标，只有达到目标的解才会被接受。

 算法框架
 result = []
 backtrack(路径, 选择列表):
     if 满足结束条件:
         result.add(路径)
         return
     
     for 选择 in 选择列表:
         做选择
         backtrack(路径, 选择列表)
         撤销选择
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self generateParenthesis:3];
}

/**
 括号生成
 数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。
 输入：n = 3
 输出：["((()))","(()())","(())()","()(())","()()()"]
 
 问题分析：
 - 当前左右括号都有大于 0 个可以使用的时候，才产生分支；
 - 产生左分支的时候，只看当前是否还有左括号可以使用；
 - 产生右分支的时候，还受到左分支的限制，右边剩余可以使用的括号数量一定得在严格大于左边剩余的数量的时候，才可以产生分支；
 - 在左边和右边剩余的括号数都等于 0 的时候结算
 */

- (void)generateParenthesis:(NSInteger)num {
    NSMutableArray *array = [NSMutableArray array];
    [self dfs:array left:num right:num current:@""];
    NSLog(@"%@", array);
}

/**
 * @param array    结果集
 * @param left   左括号还有几个可以使用
 * @param right  右括号还有几个可以使用
 * @param current 当前递归得到的结果
 */
- (void)dfs:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right current:(NSString *)current {
    // 因为每一次尝试，都使用新的字符串变量，所以无需回溯
    // 在递归终止的时候，直接把它添加到结果集即可
    if (left == 0 && right == 0) {
        [array addObject:current];
    }
    // 剪枝（如图，左括号可以使用的个数严格大于右括号可以使用的个数，才剪枝，注意这个细节）
    if (left > right) {
        return;
    }
    if (left > 0) {
        NSString *nextString = [NSString stringWithFormat:@"%@%@", current, @"("];
        [self dfs:array left:left - 1 right:right current:nextString];
    }
    if (right > 0) {
        NSString *nextString = [NSString stringWithFormat:@"%@%@", current, @")"];
        [self dfs:array left:left right:right - 1 current:nextString];
    }
}


@end
