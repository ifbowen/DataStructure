//
//  MBStackViewController.m
//  DataStructure
//
//  Created by Bowen on 2020/6/24.
//  Copyright © 2020 inke. All rights reserved.
//

#import "MBStackViewController.h"

@interface MBStackViewController ()

@end

@implementation MBStackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

 -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    testStack();
    testStackQueue();
}

/// 先进后出

#pragma mark - 栈的顺序存储结构

void testStack()
{
    LinkStack *s;
    initLinkStack(s);
    pushLinkStack(s, 10);
    pushLinkStack(s, 20);
    int data;
    popLinkStack(s, data);
    printf("%d\n", data);
}

typedef struct {
    int data[10];
    int top;
} SequenceStack;

void initSequenceStack(SequenceStack * &s)
{
    s = (SequenceStack *)malloc(sizeof(SequenceStack));
    s->top = -1;
}

void destroySequenceStack(SequenceStack * &s)
{
    free(s);
}

BOOL isEmptySequenceStack(SequenceStack * &s)
{
    return s->top == -1;
}

void pushSequenceStack(SequenceStack * &s, int value)
{
    if (s -> top == 9) {
        return;
    }
    s->top++;
    s->data[s->top] = value;
}

void popSequenceStack(SequenceStack * &s, int &value)
{
    if (s->top == -1) {
        return;
    }
    value = s->data[s->top];
    s->top--;
}

#pragma mark - 栈的链式存储结构

typedef struct StackNode {
    int data;
    struct StackNode *next;
} LinkStack;

void initLinkStack(LinkStack * &s)
{
    s = (LinkStack *)malloc(sizeof(LinkStack));
    s->next = NULL;
}

void destroyLinkStack(LinkStack * &s)
{
    LinkStack *p = s;
    LinkStack *q = s->next;
    while (q != NULL) {
        free(q);
        p = q;
        q = p->next;
    }
    free(p);
}

BOOL isEmptyLinkStack(LinkStack * &s)
{
    return s->next == NULL;
}

void pushLinkStack(LinkStack * &s, int value)
{
    LinkStack *p;
    p = (LinkStack *)malloc(sizeof(LinkStack));
    p->data = value;
    p->next = s->next;
    s->next = p;
}

void popLinkStack(LinkStack * &s, int &value)
{
    LinkStack *p;
    if (s->next == NULL) {
        return;
    }
    p = s->next;
    value = p->data;
    s->next = p->next;
    free(p);
}

#pragma mark - 两个栈实现队列

void testStackQueue()
{
    StackQueue *sq;
    initStackQueue(sq);
    enStackQueue(sq, 1);
    enStackQueue(sq, 2);
    enStackQueue(sq, 3);
    deStackQueue(sq);
    enStackQueue(sq, 4);
    deStackQueue(sq);
}

typedef struct {
    SequenceStack *stack1;
    SequenceStack *stack2;
} StackQueue;

void initStackQueue(StackQueue *&sq)
{
    sq = (StackQueue *)malloc(sizeof(StackQueue));
    initSequenceStack(sq->stack1);
    initSequenceStack(sq->stack2);
}

void enStackQueue(StackQueue *&sq, int data)
{
    SequenceStack *stack1 = sq->stack1;
    SequenceStack *stack2 = sq->stack2;
    while (!isEmptySequenceStack(stack1)) {
        int value = NULL;
        popSequenceStack(stack1, value);
        pushSequenceStack(stack2, value);
    }
    pushSequenceStack(stack1, data);
    while (!isEmptySequenceStack(stack2)) {
        int value = NULL;
        popSequenceStack(stack2, value);
        pushSequenceStack(stack1, value);
    }
}

int deStackQueue(StackQueue *&sq)
{
    int data;
    popSequenceStack(sq->stack1, data);
    NSLog(@"%d", data);
    return data;
}



@end
