//
//  MBQueueViewController.m
//  DataStructure
//
//  Created by Bowen on 2020/6/24.
//  Copyright © 2020 inke. All rights reserved.
//

#import "MBQueueViewController.h"

const int kLengthQueue = 10;

@interface MBQueueViewController ()

@end

@implementation MBQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    testQueue();
}

void testQueue()
{
    SequenceQueue *q;
    initSequenceQueue(q);
}

#pragma mark - 队列的线性存储

typedef struct {
    int data[kLengthQueue];
    int top;
    int bottom;
}SequenceQueue;

void initSequenceQueue(SequenceQueue * &q)
{
    q = (SequenceQueue *)malloc(sizeof(SequenceQueue));
    q->top = -1;
    q->bottom = -1;
}

void destroySequenceQueue(SequenceQueue * &q)
{
    free(q);
}

BOOL isEmptySequenceQueue(SequenceQueue * &q)
{
    return q->top == q->bottom;
}

void enSequenceQueue(SequenceQueue * &q, int value)
{
    if (q->bottom == kLengthQueue - 1) {
        return;
    }
    q->bottom++;
    q->data[q->bottom] = value;
}

void deSequenceQueue(SequenceQueue * &q, int &value)
{
    if (q->top == q->bottom) {
        return;
    }
    q->top++;
    value = q->data[q->top];
}

#pragma mark - 环形队列

typedef struct {
    int data[kLengthQueue];
    int top;
    int bottom;
}CicleQueue;

void initCicleQueue(CicleQueue * &q)
{
    q = (CicleQueue *)malloc(sizeof(CicleQueue));
    q->top = 0;
    q->bottom = 0;
}

void destroyCicleQueue(CicleQueue * &q)
{
    free(q);
}

BOOL isEmptyCicleQueue(CicleQueue * &q)
{
    return q->top == q->bottom;
}

void enCicleQueue(CicleQueue * &q, int value)
{
    if ((q->bottom + 1) % kLengthQueue ==  q->top) { // 队满
        return;
    }
    q->bottom = (q->bottom + 1) % kLengthQueue;
    q->data[q->bottom] = value;
}

void deCicleQueue(CicleQueue * &q, int &value)
{
    if (q->top == q->bottom) { // 队空
        return;
    }
    q->top = (q->top + 1) % kLengthQueue;
    value = q->data[q->top];
}

#pragma mark - 队列的链式存储

typedef struct QNode {
    int data;
    struct QNode *next;
} QueueNode;

typedef struct {
    QueueNode *top;
    QueueNode *bottom;
} LinkQueue;

void initLinkQueue(LinkQueue * &q)
{
    q = (LinkQueue *)malloc(sizeof(LinkQueue));
    q->top = NULL;
    q->bottom = NULL;
}

void destroyLinkQueue(LinkQueue * &q)
{
    QueueNode *p = q->top;
    QueueNode *r;
    if (p != NULL) {
        r = p->next;
        while (r != NULL) {
            free(p);
            p = r;
            r = p->next;
        }
    }
    free(p);
    free(q);
}

BOOL isEmptyLinkQueue(LinkQueue * &q)
{
    return q->bottom == NULL;
}

void enLinkQueue(LinkQueue * &q, int value)
{
    QueueNode *p;
    p = (QueueNode *)malloc(sizeof(QueueNode));
    p->data = value;
    p->next = NULL;
    
    if (q->bottom == NULL) {
        q->top = q->bottom = p;
    } else {
        q->bottom->next = p;
        q->bottom = p;
    }
}

void deLinkQueue(LinkQueue * &q, int &value)
{
    QueueNode *t;
    if (q->bottom == NULL) {
        return;
    }
    t = q->top;
    if (q->top == q->bottom) {
        q->top = NULL;
        q->bottom = NULL;
    } else {
        q->top = q->top->next;
        value = t->data;
    }
    free(t);
}


@end
