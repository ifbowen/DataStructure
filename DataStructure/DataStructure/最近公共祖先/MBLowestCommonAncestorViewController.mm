//
//  MBLowestCommonAncestorViewController.m
//  DataStructure
//
//  Created by wenbo on 2022/12/26.
//  Copyright © 2022 inke. All rights reserved.
//

#import "MBLowestCommonAncestorViewController.h"
#include <unordered_map>

using namespace std;

@interface MBLowestCommonAncestorViewController ()

@end

@implementation MBLowestCommonAncestorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

typedef struct TreeNode {
    int data;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

#pragma mark - 递归方法
 
TreeNode* lowestCommonAncestor1(TreeNode* root, TreeNode* p, TreeNode* q) {
    // 如果 root 本身就是 p 或者 q 或者 空, 返回 root
    if (root == q || root == p || root == NULL) return root;
    // 后续遍历
    TreeNode* left = lowestCommonAncestor1(root->left, p, q);
    TreeNode* right = lowestCommonAncestor1(root->right, p, q);
    // 如果 p 和 q 都在以 root 为根的树中, 函数返回的便是 p 和 q 的最近公共祖先节点
    if (left != NULL && right != NULL) return root;
    // 如果 p 和 q 都不在以 root 为根的树中, 返回 null
    if (left == NULL && right == NULL) return NULL;
    // 如果 p 和 q 只有一个存在于 root 为根的树中, 返回这个节点即可.
    return left == NULL ? right : left;
}

#pragma mark - 存储父节点

void dfs(TreeNode* root, unordered_map<int, TreeNode*> map){
    if (root->left != NULL) {
        map[root->left->data] = root;
        dfs(root->left, map);
    }
    if (root->right != NULL) {
        map[root->right->data] = root;
        dfs(root->right, map);
    }
}

TreeNode* lowestCommonAncestor2(TreeNode* root, TreeNode* p, TreeNode* q) {
    unordered_map<int, TreeNode*> fatherNodeMap;
    unordered_map<int, bool> visitorMap;
    dfs(root, fatherNodeMap);
    while (p != NULL) {
        visitorMap[p->data] = true;
        p = fatherNodeMap[p->data];
    }
    while (q != NULL) {
        if (visitorMap[q->data]) return q;
        q = fatherNodeMap[q->data];
    }
    return NULL;
}


#pragma mark - 求最近公共父视图

/// Monsary 方法
- (UIView *)closestCommonSuperviewWithOneView:(UIView *)oneView anotherView:(UIView *)anotherView {
    UIView *closestCommonSuperview = nil;
    UIView *secondViewSuperview = oneView;
    while (!closestCommonSuperview && secondViewSuperview) {
        UIView *firstViewSuperview = anotherView;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}


@end
