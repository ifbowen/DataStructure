//
//  MBBinaryTreeViewController.m
//  DataStructure
//
//  Created by Bowen on 2020/6/24.
//  Copyright © 2020 inke. All rights reserved.
//

#import "MBBinaryTreeViewController.h"

@interface MBBinaryTreeViewController ()

@end

@implementation MBBinaryTreeViewController

/**
 深度优先遍历（Depth-First-Search，缩写为 DFS）：先序遍历，中序遍历，后续遍历
 深度优先搜索的步骤: 1.递归下去 2.回溯上来。
 递归下去，深度优先，则是以深度为准则，先一条路走到底，直到达到目标。
 回溯上来，既没有达到目标又无路可走了，那么则退回到上一步的状态，走其他路
 DFS 用递归的形式，用到了栈结构，先进后出。

 广度优先遍历（Breadth-First-Search，缩写为 BFS）：层次遍历
 广度优先遍历，指的是从图的一个未遍历的节点出发，先遍历这个节点的相邻节点，再依次遍历每个相邻节点的相邻节点。
 BFS 选取状态用队列的形式，先进先出。
 */
 
- (void)viewDidLoad{
    [super viewDidLoad];
}

/*
            A
          /   \
         B     C
        /     / \
       D     E   F
        \
         G
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    BTNode *b;
    char str1[] = "A(B(D(,G)),C(E,F))";
    createBTree(b,str1);
    postOrder2(b);
    inOrder1(b);

    char str2[] = "ABD#G###CE##F##";
    BTNode *root = createBTree1(str2);
    dispBTree(root);
    
}

typedef struct Node {
    char data;
    struct Node *lchild;
    struct Node *rchild;
} BTNode;

typedef struct LinkNode{
    BTNode *data;
    struct LinkNode *pre;
    struct LinkNode *next;
} LinkNode;

void initLinkNode(LinkNode *&list, BTNode *node)
{
    list = (LinkNode *)malloc(sizeof(LinkNode));
    list->data = node;
    list->pre = NULL;
    list->next = NULL;
}

BTNode* createNode(char data)
{
    BTNode* node = (BTNode *)malloc(sizeof(BTNode));
    node->data = data;
    node->lchild = NULL;
    node->rchild = NULL;
    return node;
}

typedef struct StackNode {
    BTNode *data;
    struct StackNode *next;
} LinkStack;

void initStack(LinkStack * &s)
{
    s = (LinkStack *)malloc(sizeof(LinkStack));
    s->next = NULL;
}

BOOL isEmptyStack(LinkStack * &s)
{
    return s->next == NULL;
}

void push(LinkStack * &s, BTNode *data)
{
    LinkStack *p;
    p = (LinkStack *)malloc(sizeof(LinkStack));
    p->data = data;
    p->next = s->next;
    s->next = p;
}

void pop(LinkStack * &s)
{
    LinkStack *p;
    if (s->next == NULL) {
        return;
    }
    p = s->next;
    s->next = p->next;
    free(p);
}

BTNode* top(LinkStack * &s)
{
    if (s->next == NULL) {
        return NULL;
    }
    return s->next->data;
}

BTNode* createBTree1(char *str)
{
    BTNode* root = createNode(str[0]);
    StackNode *stk;
    initStack(stk);
    push(stk, root);
    int idx = 1;
    while (!isEmptyStack(stk)) {
        if (top(stk)->lchild == NULL && str[idx - 1] != '#') {
            if (str[idx] != '#') {
                BTNode* left = createNode(str[idx]);
                top(stk)->lchild = left;
                push(stk, left);
            }
            idx++;
        } else {
            if (top(stk)->rchild == NULL) {
                if (str[idx] != '#') {
                    BTNode* right = createNode(str[idx]);
                    top(stk)->rchild = right;
                    push(stk, right);
                } else {
                    pop(stk);
                }
                idx++;
            } else {
                pop(stk);
            }
        }
    }
    return root;
}

void createBTree(BTNode * &b,char *str)    //创建二叉树
{
    BTNode *St[100],*p=NULL;
    int top=-1,k=0,j=0;
    char ch;
    b=NULL;                //建立的二叉树初始时为空
    ch=str[j];
    while (ch!='\0') {    //str未扫描完时循环
        switch(ch) {
            case '(':
                top++;
                St[top]=p;
                k=1;
                break;        //为左孩子节点
            case ')':
                top--;
                break;
            case ',':
                k=2;
                break;                              //为孩子节点右节点
            default:
                p=(BTNode *)malloc(sizeof(BTNode));
                p->data=ch;
                p->lchild=p->rchild=NULL;
                if (b==NULL) {                             //*p为二叉树的根节点
                    b=p;
                } else {                                 //已建立二叉树根节点
                    switch(k) {
                        case 1:St[top]->lchild=p;break;
                        case 2:St[top]->rchild=p;break;
                    }
                }
        }
        j++;
        ch=str[j];
    }
}

void destroyBTree(BTNode *&b)
{
    if (b == NULL) {
        return;
    }
    destroyBTree(b->lchild);
    destroyBTree(b->rchild);
    free(b);
}

BTNode *findNode(BTNode *b,char x)
{
    if (b == NULL) {
        return NULL;
    }
    BTNode *p;
    if (b->data==x) {
        return b;
    } else {
        p=findNode(b->lchild,x);
        if (p!=NULL) {
            return p;
        } else {
            return findNode(b->rchild,x);
        }
    }
}

int getHeight(BTNode *b)
{
    if (b==NULL) {
        return(0);                 //空树的高度为0
    }
    int lchildh,rchildh;
    lchildh=getHeight(b->lchild);    //求左子树的高度为lchildh
    rchildh=getHeight(b->rchild);    //求右子树的高度为rchildh
    return (lchildh>rchildh)? (lchildh+1):(rchildh+1);
}

void dispBTree(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    printf("%c",b->data);
    if (b->lchild!=NULL || b->rchild!=NULL) {
        printf("(");                         //有孩子节点时才输出(
        dispBTree(b->lchild);                //递归处理左子树
        if (b->rchild!=NULL) printf(",");    //有右孩子节点时才输出,
        dispBTree(b->rchild);                //递归处理右子树
        printf(")");                         //有孩子节点时才输出)
    }
}

#pragma mark - 递归遍历

///  先序遍历（根-左-右）
void preOrder(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    printf("%c", b->data);
    preOrder(b->lchild);
    preOrder(b->rchild);
}

/// 中序遍历（左-根-右）
void inOrder(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    inOrder(b->lchild);
    printf("%c", b->data);
    inOrder(b->rchild);
}

/// 后序遍历（左-右-根）
void postOrder(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    postOrder(b->lchild);
    postOrder(b->rchild);
    printf("%c", b->data);
}

#pragma mark - 非递归遍历

///  先序遍历
void preOrder1(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    
    BTNode *stack[100], *p;
    int top = 0;
    stack[top] = b;
    
    while (top > -1) {
        p = stack[top];
        top--;
        printf("%c", p->data);
        if (p->rchild != NULL) {
            top++;
            stack[top] = p->rchild;
        }
        if (p->lchild != NULL) {
            top++;
            stack[top] = p->lchild;
        }
    }
    printf("\n");
}

/// 中序遍历
void inOrder1(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    BTNode *stack[100], *p;
    int top = -1;
    p = b;
    while (top > -1 || p != NULL) {
        while (p != NULL) {
            top++;
            stack[top] = p;
            p = p->lchild;
        }
        if (top > -1) {
            p = stack[top];
            top--;
            printf("%c", p->data);
            p = p->rchild;
        }
    }
    printf("\n");
}

/// 后序遍历
void postOrder1(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    BTNode *stack[100], *p;
    int flag = 0, // 1：表示*b的左孩子已经访问过或者为空
    top = -1;
    do {
        while (b != NULL) {
            top++;
            stack[top] = b;
            b = b->lchild;
        }
        p = NULL;
        flag = 1;
        while (top != -1 && flag) {
            b = stack[top];
            if (b->rchild == p) {
                printf("%c", b->data);
                top--;
                p = b;
            } else {
                b = b->rchild;
                flag = 0;
            }
        }
        
    } while (top != -1);
    
    printf("\n");

}

/// 层次遍历
void levelOrder1(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    
    BTNode *queue[100], *p;
    int top = -1;
    int bottom = -1;
    bottom++;
    queue[bottom] = b;
    while (top != bottom) {
        top = top + 1;
        p = queue[top];
        printf("%c", p->data);
        if (p->lchild != NULL) {
            bottom = bottom +1;
            queue[bottom] = p->lchild;
        }
        if (p->rchild != NULL) {
            bottom = bottom +1;
            queue[bottom] = p->rchild;
        }
    }
    printf("\n");
}


#pragma mark - 自己

///  先序遍历（根-左-右）
void preOrder2(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    BTNode *p = b;
    LinkNode *link, *current;
    initLinkNode(link, p);
    current = link;
    
    while (p != NULL) {
        if (p->lchild != NULL) {
            LinkNode *node, *next;
            initLinkNode(node, p->lchild);
            
            next = current->next;
            current->next = node;
            node->next = next;
        }
        if (p->rchild != NULL) {
            LinkNode *node, *next;
            initLinkNode(node,p->rchild);
            
            if (p->lchild == NULL) {
                next = current->next;
                current->next = node;
                node->next = next;
            } else {
                next = current->next->next;
                current->next->next = node;
                node->next = next;
            }
        }
        current = current->next;
        if (current != NULL) {
            p = current->data;
        } else {
            p = NULL;
        }
    }
    
    while (link != NULL) {
        printf("%c", link->data->data);
        link = link->next;
    }
    printf("\n");
}

/// 中序遍历（左-根-右）
void inOrder2(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    
}

/// 后序遍历（左-右-根）
void postOrder2(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    BTNode *p = b;
    
    LinkNode *link, *current;
    initLinkNode(link, p);
    current = link;
    
    while (p != NULL) {
        if (p->rchild != NULL) {
            LinkNode *node;
            initLinkNode(node, p->rchild);
            node->next = current;
            node->pre = current->pre;
            current->pre = node;
            if (node->pre != NULL) {
                node->pre->next = node;
            }
            link = node;
        }
        if (p->lchild != NULL) {
            LinkNode *node;
            initLinkNode(node, p->lchild);
            
            if (p->rchild == NULL) {
                node->next = current;
                node->pre = current->pre;
                current->pre = node;
                if (node->pre != NULL) {
                    node->pre->next = node;
                }
            } else {
                node->next = current->pre;
                node->pre = current->pre->pre;
                if (node->pre != NULL) {
                    node->pre->next = node;
                }
                node->next->pre = node;
            }
            
            link = node;
        }
        current = current->pre;
        if (current != NULL) {
            p = current->data;
        } else {
            p = NULL;
        }
    }
    
    while (link != NULL) {
        printf("%c", link->data->data);
        link = link->next;
    }
    printf("\n");
    
}

/// 层次遍历
void levelOrder2(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    int i = 0, j = 0;
    BTNode *array[100] = {};
    BTNode *p = b;
    array[i]= p;
    while (p != NULL) {
        if (p->lchild != NULL) {
            array[++i] = p->lchild;
        }
        if (p->rchild != NULL) {
            array[++i] = p->rchild;
        }
        p = array[++j];
    }
    for (int k = 0; k < j; k++) {
        BTNode *node = array[k];
        printf("%c", node->data);
    }
    printf("\n");
}

/// 层次遍历
void levelOrder3(BTNode *b)
{
    if (b == NULL) {
        return;
    }
    BTNode *p = b;
    LinkNode *link, *current, *end;
    initLinkNode(link, p);
    current = link;
    end = link;
    while (p != NULL) {
        if (p->lchild != NULL) {
            LinkNode *node, *next;
            initLinkNode(node, p->lchild);
            next = end->next;
            end->next = node;
            node->next = next;
            end = node;
        }
        if (p->rchild != NULL) {
            LinkNode *node, *next;
            initLinkNode(node, p->rchild);
            next = end->next;
            end->next = node;
            node->next = next;
            end = node;
        }
        current = current->next;
        if (current != NULL) {
            p = current->data;
        } else {
            p = NULL;
        }
    }
    while (link != NULL) {
        printf("%c", link->data->data);
        link = link->next;
    }
    printf("\n");
}




@end
