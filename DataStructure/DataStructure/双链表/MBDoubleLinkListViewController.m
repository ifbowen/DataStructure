//
//  MBDoubleLinkListViewController.m
//  DataStructure
//
//  Created by Bowen on 2020/6/18.
//  Copyright © 2020 inke. All rights reserved.
//

#import "MBDoubleLinkListViewController.h"

typedef struct DNode{
    int data;
    struct DNode *pre;
    struct DNode *next;
} DLinkList;


@interface MBDoubleLinkListViewController ()

@property (nonatomic, assign) DLinkList node;

@end

@implementation MBDoubleLinkListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

void headerCreateDLink(DLinkList *list, int a[], int n)
{
    DLinkList *s;
    *list = *(DLinkList *)malloc(sizeof(DLinkList));
    list->pre = NULL;
    list->next = NULL;
    
    for (int i = 0; i < n; i++) {
        
        s = (DLinkList *)malloc(sizeof(DLinkList));
        s->data = a[i];
        s->next = list->next;
        s->pre = list;

        if (list->next != NULL) {
            list->next->pre = s;
        }
        list->next = s;
    }
}

void tailCreateDLink(DLinkList *list, int a[], int n)
{
    DLinkList *s, *p;
    *list = *(DLinkList *)malloc(sizeof(DLinkList));
    list->pre = NULL;
    list->next = NULL;
    p = list;
    for (int i = 0; i < n; i++) {
        
        s = (DLinkList *)malloc(sizeof(DLinkList));
        s->data = a[i];
        s->next = p->next;
        s->pre = p;
        
        if (p->next != NULL) {
            p->next->pre = s;
        }
        p->next = s;
        
        p = s;
    }
}

void insertDLink(DLinkList *list, int data, int index)
{
    int count = 0;
    DLinkList *p = list;
    while (p != NULL && count < index) {
        p = p->next;
        count++;
    }
    
    if (p == NULL) {
        return;
    }
    
    DLinkList *s = (DLinkList *)malloc(sizeof(DLinkList));
    s->data = data;
    s->next = p;
    s->pre = p->pre;
    
    p->pre->next = s;
    p->pre = s;
        
}

void removeDLink(DLinkList *list, int index)
{
    int count = 0;
    DLinkList *p = list;
    while (p != NULL && count < index) {
        p = p->next;
        count++;
    }
    
    if (p == NULL) {
        return;
    }
    
    p->pre->next = p->next;
    p->next->pre = p->pre;
    
    free(p);
}

void displayDlink(DLinkList *list)
{
    DLinkList *p = list->next;
    while (p != NULL) {
        printf("%d ", p->data);
        p = p->next;
    }
    printf("\n====================\n");
}

- (IBAction)headerCreateDoubleLink:(id)sender
{
    int a[10] = {1,2,3,4,5,6,7,8,9,10};
    headerCreateDLink(&_node, a, 10);
}

- (IBAction)tailCreateDoubleLink:(id)sender
{
    int a[10] = {1,2,3,4,5,6,7,8,9,10};
    tailCreateDLink(&_node, a, 10);
}

- (IBAction)add:(id)sender
{
    insertDLink(&_node, 100, 5);
}

- (IBAction)remove:(id)sender
{
    removeDLink(&_node, 5);
}

- (IBAction)print:(id)sender
{
    displayDlink(&_node);
}

@end
