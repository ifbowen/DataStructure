//
//  MBDynamicProgrammingViewController.m
//  DataStructure
//
//  Created by wenbo on 2022/12/26.
//  Copyright © 2022 inke. All rights reserved.
//

#import "MBDynamicProgrammingViewController.h"
#include <vector>

using namespace std;

/**
 一、递归算法：
 指一种通过重复将问题分解为同类的子问题而解决问题的方法。简单来说，递归表现为函数调用函数本身
 
 递归的两个特点:
 自身调用：原问题可以分解为子问题，子问题和原问题的求解方法是一致的，即都是调用自身的同一个函数。
 终止条件：递归必须有一个终止的条件，即不能无限循环地调用本身。
 
 递归与栈的关系:
 递归过程可以理解为栈出入过程
 
 解决递归问题三步曲:
 - 定义函数功能
 - 寻找递归终止条件
 - 递推函数的等价关系式

 二、动态规划算法：
 动态规划常常适用于有重叠子问题和最优子结构性质的问题
 
 性质
 1、最优子结构
   如果问题的最优解所包含的子问题的解也是最优的，我们就称该问题具有最优子结构性质（即满足最优化原理）。最优子结构性质为动态规划算法解决问题提供了重要线索。
 2、子问题重叠
   子问题重叠性质是指在用递归算法自顶向下对问题进行求解时，每次产生的子问题并不总是新问题，有些子问题会被重复计算多次。
   动态规划算法正是利用了这种子问题的重叠性质，对每一个子问题只计算一次，然后将其计算结果保存，当再次计算已经计算过的子问题时，只需要简单地查看一下保存的结果，从而获得较高的效率。
 3、无后效性
   即某阶段状态一旦确定，就不受这个状态以后决策的影响。也就是说，某状态以后的过程不会影响以前的状态，只与当前状态有关。
 
 步骤：
 1、划分：按照问题的特征，把问题分为若干阶段。注意：划分后的阶段一定是有序的或者可排序的
 2、确定状态和状态变量：将问题发展到各个阶段时所处的各种不同的客观情况表现出来。状态的选择要满足无后续性
 3、确定决策并写出状态转移方程：状态转移就是根据上一阶段的决策和状态来导出本阶段的状态。根据相邻两个阶段状态之间的联系来确定决策方法和状态转移方程
 4、边界条件：状态转移方程是一个递推式，因此需要找到递推终止的条件
 
 场景：比如一些求最值的场景
 最长递增子序列、最小编辑距离、背包问题、凑零钱问题等等，都是动态规划的经典应用场景。

 */

@interface MBDynamicProgrammingViewController ()

@end

@implementation MBDynamicProgrammingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    getMax();
    int nums = possibleNum1(10);
    nums = possibleNum2(10);
    int grids = walkGrid(3, 3);
    
}

/**
 递归：自顶向下
 从上向下延伸，从一个规模较大的原问题比如说 f(20)，向下逐渐分解规模，直到 f(1) 和 f(2) 触底，然后逐层返回答案，这就叫「自顶向下」
 也就是从上向下看，遇到问题，发现解决不了，必须解决子问题，就先解决子问题，最后逐步返回
 
 缺点
 1、重复解决子问题，比如fibonacci(n - 1)实际包含了子问题fibonacci(n - 2)和fibonacci(n - 3)，和fibonacci(n)的子问题fibonacci(n - 2)重复了。根因是使用了栈空间保存子问题的解导致问题之间不能共享子问题的解
 2、栈的深度不可控
 */
size_t fibonacci(size_t n) {
    if (n == 1 || n == 2) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}


/**
 动态规划：自底向上
 问题规模最小的 f(1) 和 f(2) 开始往上推，直到推到我们想要的答案 f(20)
 dp[i] = dp[i - 1] + dp[i - 2];称为状态转移方程，表示如果利用子问题的解得到当前问题的最优解，
 当前问题为 dp[i] 的值，子问题的解为 dp[i - 1] 和 dp[i - 2]，这里只是很简单的相加就是最优解，复杂的比如求两者间的最大值作为最优解（最优策略）。
 
 缺点是需要一个 dp 数组保存已经解决的子问题，优点是问题之间可以共享解，无需重复解子问题。
 */
int fib(int N) {
    vector<int> dp(N, 0);
    dp[1] = dp[2] = 1;
    for (int i = 3; i <= N; i++) {
        dp[i] = dp[i - 1] + dp[i - 2];
    }
    return dp[N];
}

/**
 数字塔动态规划：
 每行的各个值只能和正下或右下的值相连，求值总和最大的路径的总和值
 7
 3 8
 8 1 0
 2 7 4 4
 4 5 2 6 5
 */

int getMax() {
    int array[5][5] = {{7}, {3, 8}, {8, 1, 0}, {2, 7, 4, 4}, {4, 5, 2, 6, 5}}; // 存储问题中的数字三角形
    int n = 5;      // n表示总行数
    int i = 0;      // i表示当前行数
    int j = 0;      // j表示行偏移
    int maxSum = getMaxSum1(array, n, i, j);
    maxSum = getMaxSum2(array, n);
    return maxSum;
}

// 递归
int getMaxSum1(int a[5][5], int n, int i, int j) {
    // 结束条件
    if (i == n - 1) {
        return a[i][j];
    }
    // 子问题1：正下方的最优路径值总和
    int x = getMaxSum1(a, n, i + 1, j);
    // 子问题2: 右下方的最优路径值总和
    int y = getMaxSum1(a, n, i + 1, j + 1);
    // 当前问题：当前最优路径值总和
    return MAX(x, y) + a[i][j];
}

// 动态规划
int getMaxSum2(int a[5][5], int n) {
    int maxSum[5][5];
    for(int i = 0; i < n; i++) {
        for(int j = 0; j <= i; j++) {
            maxSum[i][j] = a[i][j];
        }
    }
    for(int i = n - 2; i >= 0; i--) {
        for(int j = 0; j <= i; j++) {
            // 状态转移方程，当前最优解为下方两个中最大的值和自身值之和
            maxSum[i][j] = MAX(maxSum[i+1][j], maxSum[i+1][j+1]) + a[i][j];
        }
    }
    return maxSum[0][0];
}

/**
 爬楼梯
 楼梯有 n 阶，一次能爬 1 阶或 2 阶，爬到顶一共有几种可能的走法
 */

// 递归
int possibleNum1(int n){
    if (n == 1){
        return 1;
    }
    if (n == 2){
        return 2;
    }

    return possibleNum1(n-1) + possibleNum1(n-2);
}

// 动态规划
int possibleNum2(int n){
    vector<int> dp(n, 0);
    dp[1] = 1;
    dp[2] = 2;
    for(int i = 3; i <= n; i++) {
        dp[i] = dp[i-1] + dp[i-2];
    }
    return dp[n];
}

/**
 问题：走格子
 一个机器人位于一个 m x n 网格的左上角 。机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角。
 问总共有多少条不同的路径？
 */

// 动态规划
int walkGrid(int m, int n) {
    int dp[m][n];
    dp[0][0] = 0;
    for(int i = 0; i <= n; i++) {
        dp[i][0] = 1;
    }
    
    for(int j = 0; j<=m; j++) {
        dp[0][j] = 1;
    }
    
    for(int i = 1; i <= n; i++) {
        for( int j = 1; j <= m; j++) {
            dp[i][j] = dp[i-1][j] + dp[i][j-1];
        }
    }
    return dp[m - 1][n - 1];
}

// 递归
int getGridCount(int m, int n) {
    if(n == 0 || m == 0) {
        return 1;
    } else {
        return getGridCount(n-1, m) + getGridCount(n, m-1);
    }
}

@end
