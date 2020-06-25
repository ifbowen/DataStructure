//
//  MBStringViewController.m
//  DataStructure
//
//  Created by BowenCoder on 2020/6/26.
//  Copyright © 2020 inke. All rights reserved.
//

#import "MBStringViewController.h"

@interface MBStringViewController ()

@end

@implementation MBStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - 串的顺序存储结构(顺序串)

typedef struct {
    char data[10];
    int length;
} SequenceString;

void assinSequenceString(SequenceString &s, char cstr[])
{
    int i;
    for (i = 0; cstr[i] != '\0'; i++) {
        s.data[i] = cstr[i];
    }
    s.length = i;
}

void copySequenceString(SequenceString &s1, SequenceString s2)
{
    for (int i = 0; i < s2.length; i++) {
        s1.data[i] = s2.data[i];
    }
    s1.length = s2.length;
}

bool isEqualSequenceString(SequenceString s1, SequenceString s2)
{
    bool isSame = true;
    if (s1.length != s2.length) {
        return false;
    }
    for (int i = 0; i < s1.length; i++) {
        if (s1.data[i] != s2.data[i]) {
            isSame = false;
            break;
        }
    }
    return isSame;
}

SequenceString concatSequenceString(SequenceString s1, SequenceString s2)
{
    SequenceString temp;
    temp.length = s1.length + s2.length;
    for (int i = 0; i < s1.length; i++) {
        temp.data[i] = s1.data[i];
    }
    for (int i = 0; i< s2.length; i++) {
        temp.data[s1.length + i] = s2.data[i];
    }
    return temp;
}

SequenceString subSequenceString(SequenceString s, int start, int length)
{
    SequenceString temp;
    
    if (start < 0 || start > s.length || length <= 0 || start+length-1 > s.length) {
        return temp;
    }
    for (int i = start - 1; i < start + length - 1; i++) {
        temp.data[i - start + 1] = s.data[i];
    }
    temp.length = length;
    
    return temp;
}

SequenceString insertSequenceString(SequenceString s1, SequenceString s2, int index)
{
    SequenceString temp;

    if (index <= 0 || index > s1.length) {
        return temp;
    }
    
    for (int i = 0; i < index - 1; i++) {
        temp.data[i] = s1.data[i];
    }
    for (int i = 0; i < s2.length; i++) {
        temp.data[index + i] = s2.data[i];
    }
    for (int i = index - 1; i < s1.length; i++) {
        temp.data[s2.length + i] = s1.data[i];
    }
    
    temp.length = s1.length + s2.length;
    
    return temp;
}


SequenceString removeSequenceString(SequenceString s, int start, int length)
{
    SequenceString temp;

    if (start < 0 || start > s.length || length <= 0 || start+length-1 > s.length) {
        return temp;
    }
    
    for (int i = 0; i < start - 1; i++) {
        temp.data[i] = s.data[i];
    }
    
    for (int i = start +length - 1; i < s.length; i++) {
        temp.data[i - length] = s.data[i];
    }
    
    temp.length = s.length - length;
    
    return temp;
}

SequenceString replaceSequenceString(SequenceString s1, SequenceString s2, int start, int length)
{
    SequenceString temp;

    if (start < 0 || start > s1.length || length <= 0 || start+length-1 > s1.length) {
        return temp;
    }
    
    for (int i = 0; i < start - 1; i++) {
        temp.data[i] = s1.data[i];
    }
    for (int i = 0; i < s2.length; i++) {
        temp.data[start + i - 1] = s2.data[i];
    }
    for (int i = start + length - 1; i < s1.length; i++) {
        temp.data[s2.length + i - length] = s1.data[i];
    }
    
    temp.length = s1.length - length + s2.length;

    return temp;
}

void dispalySequenceString(SequenceString s)
{
    if (s.length <= 0) {
        return;
    }
    
    for (int i = 0; i < s.length; i++) {
        printf("%c", s.data[i]);
    }
    printf("\n");
}


#pragma mark - 串的链式存储结构(链串)

typedef struct snode {
    char data;
    struct snode *next;
} LinkStrNode;

void StrAssign(LinkStrNode *&s,char cstr[])    //字符串常量cstr赋给串s
{
    int i;
    LinkStrNode *r,*p;
    s=(LinkStrNode *)malloc(sizeof(LinkStrNode));
    r=s;                        //r始终指向尾结点
    for (i=0;cstr[i]!='\0';i++)
    {    p=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        p->data=cstr[i];
        r->next=p;r=p;
    }
    r->next=NULL;
}

void DestroyStr(LinkStrNode *&s)
{    LinkStrNode *pre=s,*p=s->next;    //pre指向结点p的前驱结点
    while (p!=NULL)                    //扫描链串s
    {    free(pre);                    //释放pre结点
        pre=p;                        //pre、p同步后移一个结点
        p=pre->next;
    }
    free(pre);                        //循环结束时,p为NULL,pre指向尾结点,释放它
}

void StrCopy(LinkStrNode *&s,LinkStrNode *t)    //串t复制给串s
{
    LinkStrNode *p=t->next,*q,*r;
    s=(LinkStrNode *)malloc(sizeof(LinkStrNode));
    r=s;                        //r始终指向尾结点
    while (p!=NULL)                //将t的所有结点复制到s
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;
        r->next=q;r=q;
        p=p->next;
    }
    r->next=NULL;
}

bool StrEqual(LinkStrNode *s,LinkStrNode *t)    //判串相等
{
    LinkStrNode *p=s->next,*q=t->next;
    while (p!=NULL && q!=NULL && p->data==q->data)
    {    p=p->next;
        q=q->next;
    }
    if (p==NULL && q==NULL)
        return true;
    else
        return false;
}

int StrLength(LinkStrNode *s)    //求串长
{
    int i=0;
    LinkStrNode *p=s->next;
    while (p!=NULL)
    {    i++;
        p=p->next;
    }
    return i;
}

LinkStrNode *Concat(LinkStrNode *s,LinkStrNode *t)    //串连接
{
    LinkStrNode *str,*p=s->next,*q,*r;
    str=(LinkStrNode *)malloc(sizeof(LinkStrNode));
    r=str;
    while (p!=NULL)                //将s的所有结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;
        r->next=q;r=q;
        p=p->next;
    }
    p=t->next;
    while (p!=NULL)                //将t的所有结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;
        r->next=q;r=q;
        p=p->next;
    }
    r->next=NULL;
    return str;
}

LinkStrNode *SubStr(LinkStrNode *s,int i,int j)    //求子串
{
    int k;
    LinkStrNode *str,*p=s->next,*q,*r;
    str=(LinkStrNode *)malloc(sizeof(LinkStrNode));
    str->next=NULL;
    r=str;                        //r指向新建链表的尾结点
    if (i<=0 || i>StrLength(s) || j<0 || i+j-1>StrLength(s))
        return str;                //参数不正确时返回空串
    for (k=0;k<i-1;k++)
        p=p->next;
    for (k=1;k<=j;k++)             //将s的第i个结点开始的j个结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;
        r->next=q;r=q;
        p=p->next;
    }
    r->next=NULL;
    return str;
}

LinkStrNode *InsStr(LinkStrNode *s,int i,LinkStrNode *t)        //串插入
{
    int k;
    LinkStrNode *str,*p=s->next,*p1=t->next,*q,*r;
    str=(LinkStrNode *)malloc(sizeof(LinkStrNode));
    str->next=NULL;
    r=str;                                //r指向新建链表的尾结点
    if (i<=0 || i>StrLength(s)+1)        //参数不正确时返回空串
        return str;
    for (k=1;k<i;k++)                    //将s的前i个结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;
        r->next=q;r=q;
        p=p->next;
    }
    while (p1!=NULL)                    //将t的所有结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p1->data;
        r->next=q;r=q;
        p1=p1->next;
    }
    while (p!=NULL)                        //将结点p及其后的结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;
        r->next=q;r=q;
        p=p->next;
    }
    r->next=NULL;
    return str;
}

LinkStrNode *DelStr(LinkStrNode *s,int i,int j)    //串删去
{
    int k;
    LinkStrNode *str,*p=s->next,*q,*r;
    str=(LinkStrNode *)malloc(sizeof(LinkStrNode));
    str->next=NULL;
    r=str;                        //r指向新建链表的尾结点
    if (i<=0 || i>StrLength(s) || j<0 || i+j-1>StrLength(s))
        return str;                //参数不正确时返回空串
    for (k=0;k<i-1;k++)            //将s的前i-1个结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;
        r->next=q;r=q;
        p=p->next;
    }
    for (k=0;k<j;k++)                //让p沿next跳j个结点
        p=p->next;
    while (p!=NULL)                    //将结点p及其后的结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;
        r->next=q;r=q;
        p=p->next;
    }
    r->next=NULL;
    return str;
}

LinkStrNode *RepStr(LinkStrNode *s,int i,int j,LinkStrNode *t)    //串替换
{
    int k;
    LinkStrNode *str,*p=s->next,*p1=t->next,*q,*r;
    str=(LinkStrNode *)malloc(sizeof(LinkStrNode));
    str->next=NULL;
    r=str;                            //r指向新建链表的尾结点
    if (i<=0 || i>StrLength(s) || j<0 || i+j-1>StrLength(s))
        return str;                     //参数不正确时返回空串
    for (k=0;k<i-1;k++)              //将s的前i-1个结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;q->next=NULL;
        r->next=q;r=q;
        p=p->next;
    }
    for (k=0;k<j;k++)                //让p沿next跳j个结点
        p=p->next;
    while (p1!=NULL)                //将t的所有结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p1->data;q->next=NULL;
        r->next=q;r=q;
        p1=p1->next;
    }
    while (p!=NULL)                    //将结点p及其后的结点复制到str
    {    q=(LinkStrNode *)malloc(sizeof(LinkStrNode));
        q->data=p->data;q->next=NULL;
        r->next=q;r=q;
        p=p->next;
    }
    r->next=NULL;
    return str;
}

void DispStr(LinkStrNode *s)    //输出串
{
    LinkStrNode *p=s->next;
    while (p!=NULL)
    {    printf("%c",p->data);
        p=p->next;
    }
    printf("\n");
}

@end
