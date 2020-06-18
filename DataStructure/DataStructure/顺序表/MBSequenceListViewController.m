//
//  MBSequenceListViewController.m
//  DataStructure
//
//  Created by Bowen on 2020/6/15.
//  Copyright © 2020 inke. All rights reserved.
//

#import "MBSequenceListViewController.h"

typedef struct {
    int data[20];
    int length;
} SqList;

@interface MBSequenceListViewController ()

@property (nonatomic, assign) SqList sl;

@end

@implementation MBSequenceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

void createList(SqList *L, int a[], int n)
{
    initList(L);
    for (int i = 0; i < n; i++) {
        L->data[i] = a[i];
    }
    L->length = n;
    
}

void initList(SqList *L)
{
    L = (SqList *)malloc(sizeof(SqList));
    L->length = 0;
}

void destroyList(SqList *L)
{
    free(L);
}

BOOL isEmptyList(SqList *L)
{
    return L->length;;
}

void dispalyList(SqList *L)
{
    for (int i = 0; i < L->length; i++) {
        printf("%d ", L->data[i]);
    }
    printf("\n=======================\n");
}

void insertList(SqList *L, int index, int value)
{
    if (index < 1 || index > L->length) {
        return;
    }
    for (int j = L->length; j > index-1; j--) {
        L->data[j] = L->data[j-1];
    }
    L->data[index-1] = value;
    L->length++;
}

void removeList(SqList *L, int index)
{
    if (index < 1 || index > L->length) {
        return;
    }
    for (int j = index; j < L->length; j++) {
        L->data[j-1] = L->data[j];
    }
    L->length--;
}

void updateList(SqList *L, int index, int value)
{
    if (index < 1 || index > L->length) {
        return;
    }
    L->data[index] = value;
}

int queryList(SqList *L, int index)
{
    if (index < 1 || index > L->length) {
        return 0;
    }
    return L->data[index];
}


- (IBAction)create:(id)sender
{
    SqList L;
    int a[10] = {1,2,3,4,5,6,7,8,9,10};
    createList(&L, a, 10);
    _sl = L;
}

- (IBAction)add:(id)sender
{
    insertList(&_sl, 5, 100);
}

- (IBAction)delete:(id)sender
{
    removeList(&_sl, 5);
}

- (IBAction)update:(id)sender
{
    updateList(&_sl, 5, 200);
}

- (IBAction)look:(id)sender
{
    printf("%d\n", queryList(&_sl, 5));
}

- (IBAction)print:(id)sender
{
    dispalyList(&_sl);
}


@end
