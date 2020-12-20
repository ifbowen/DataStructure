//
//  MBSingleLinkListViewController.m
//  DataStructure
//
//  Created by Bowen on 2020/6/17.
//  Copyright © 2020 inke. All rights reserved.
//

#import "MBSingleLinkListViewController.h"

typedef struct LNode{
    int value;
    struct LNode *next;
} LinkList;

@interface MBSingleLinkListViewController ()

@property (nonatomic, assign) LinkList node;

@end

@implementation MBSingleLinkListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

void initSingleLinkList(LinkList *list)
{
    list = (LinkList *)malloc(sizeof(LinkList));
    list->next = NULL;
}

void headerCreateSingleLinkList(LinkList *list, int a[], int n)
{
    LinkList *s;
    initSingleLinkList(list);
    for (int i = 0; i < n; i++) {
        s = (LinkList *)malloc(sizeof(LinkList));
        s->value = a[i];
        s->next = list->next;
        list->next = s;
    }
}

void tailCreateSingleLinkList(LinkList *list, int a[], int n)
{
    LinkList *s = NULL, *p = NULL;
    initSingleLinkList(list);
    p = list;
    for (int i = 0; i < n; i++) {
        s = (LinkList *)malloc(sizeof(LinkList));
        s->value = a[i];
        p->next = s;
        p = s;
    }
    s->next = NULL;
}

void insertSingleLinkList(LinkList *list, int value, int index)
{
    int current = 0;
    LinkList *p = list;
    while (current < index-1 && p != NULL) {
        current++;
        p = p->next;
    }
    if (p == NULL) {
        return;
    }
    LinkList *s = (LinkList *)malloc(sizeof(LinkList));
    s->value = value;
    s->next = p->next;
    p->next = s;
}

void removeSingleLinkList(LinkList *list, int index)
{
    int current = 0;
    LinkList *p = list;
    while (current < index-1 && p != NULL) {
        current++;
        p = p->next;
    }
    if (p == NULL) {
        return;
    }
    LinkList *q = p->next;
    p->next = q->next;
    free(q);
}

void displaySingleLinkList(LinkList *list)
{
    LinkList *p = list->next;
    while (p != NULL) {
        printf("%d ", p->value);
        p = p->next;
    }
    printf("\n=======================\n");
}

// 只遍历一次就找到链表中的中间节点, fathNode的偏移速度是slowNode的两倍
void centerNodeOfSingleLinkList(LinkList *list)
{
    LinkList *fastNode = list;
    LinkList *slowNode = list;
    while (fastNode != NULL) {
        fastNode = fastNode->next->next;
        slowNode = slowNode->next;
    }
    printf("中间节点：%d\n", slowNode->value);
}

/*
 https://mp.weixin.qq.com/s/lVrQnCMbbbHD8eHpApeg3g
 fathNode的偏移速度是slowNode的两倍
 当两点相交时,我们有以下的结论,fathNode走过的路程为L + (C + A) + A,slowNode走过的路程为L + A,
 我们得出 (L + A) x 2 = L + (C + A) + A;
 所以L = C
 */
void isLoopSingleLinkList(LinkList *list)
{
    int length = 0;
    LinkList *fastNode = list;
    LinkList *slowNode = list;
    LinkList *firstMeetNode = list;
    LinkList *startNode = list;
    
    // 判断有环
    while (fastNode != NULL && slowNode != NULL) {
        fastNode = fastNode->next->next;
        slowNode = slowNode->next;
        if (fastNode == slowNode) {
            firstMeetNode = fastNode;
            printf("有环\n");
            break;
        }
    }
    
    // 入口节点
    while (startNode != NULL && slowNode != NULL) {
        startNode = startNode->next;
        slowNode = slowNode->next;
        length++;
        if (startNode == slowNode) {
            printf("入口节点\n");
            break;
        }
    }
    
    // 判断环的长度
    while (startNode != NULL) {
        if (startNode == firstMeetNode) {
            break;
        } else {
            startNode = startNode->next;
            length++;
        }
    }
    
    
}

- (IBAction)headerCreate:(id)sender
{
    int a[10] = {1,2,3,4,5,6,7,8,9,10};
    headerCreateSingleLinkList(&_node, a, 10);
}

- (IBAction)tailCreate:(id)sender
{
    int a[10] = {1,2,3,4,5,6,7,8,9,10};
    tailCreateSingleLinkList(&_node, a, 10);
}

- (IBAction)add:(id)sender
{
    insertSingleLinkList(&_node, 100, 5);
}

- (IBAction)remove:(id)sender
{
    removeSingleLinkList(&_node, 5);
}

- (IBAction)update:(id)sender
{
    
}

- (IBAction)display:(id)sender
{
    displaySingleLinkList(&_node);
}

- (IBAction)look:(id)sender
{
    
}

- (IBAction)centerNode:(id)sender
{
    centerNodeOfSingleLinkList(&_node);
}

- (IBAction)isLoop:(id)sender
{
    
}

@end

/**
 
 数组的特点是：寻址容易，插入和删除困难。
 链表的特点是：寻址困难，插入和删除容易。
 
 综合数组和链表的优缺点：哈希表
 哈希表：根据关键码值(Key value)而直接进行访问的数据结构
 哈希冲突：（每个节点都存储key和value，冲突对比key）
 1、开放地址法：当发生地址冲突时，按照某种方法继续探测哈希表中的其他存储单元，直到找到空位置为止
 2、链地址法：当发生地址冲突时，建立一个单链表，哈希表中存放链表的指针，key和value存放在链表的一个节点中
 
 */
