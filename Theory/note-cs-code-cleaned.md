# <center>程序设计与算法基础</center>
<center>(C Language Description)</center>

<center>Mixed Class 2504 of Chu Kochen Honors College</center>
<center>Huantong Deng</center>

---

<center>
<img src="./public/20260323101520_871_96.png" style="zoom: 60%;" />
<img src="./public/20260323101521_872_96.png" style="zoom: 20%;" />
<img src="./public/20260324164217_269_180.jpg" style="zoom: 25%;" />
</center>

---

[TOC]

---

## Foreword
**Stand ready to face all occurrences with a non-zero probability.**
## Some Annoying but Basic Knowledge
### 1. Operator Precedence

|Precedence|Operator|Associativity|
|-|-|-|
|1|`[] () . ->`|L to R|
|2|`++ -- ! ~ + - * & sizeof`|R to L|
|3|`* / %`|L to R|
|4|`+ -`|L to R|
|5|`>> <<`|L to R|
|6|`< <= >= >`|L to R|
|7|`== !=`|L to R|
|8|`&`|L to R|
|9|`^`|L to R|
|10|`\|`|L to R|
|11|`&&`|L to R|
|12|`\|\|`|L to R|
|13|`?:`|R to L|
|14|`= += -= *= /= %= &= ^= \|= <<= >>=`|R to L|
|15|`,`|L to R|
### 2. Some Algorithms
#### 1. Insertion Sort

```c
void insert(int arr[],int n){
    for(int i=0;i<n;i++){
        int key=arr[i];
        int j=i-1;
        while(j>=0&&arr[j]>key){
            arr[j+1]=arr[j];
            j--;
        }
        arr[j+1]=key;
    }
}
```
#### 2. Quick Sort

```c
int part(int arr[],int low,int high){
    int pivot=arr[high];
    int i=low-1;
    for(int j=low;j<=high;j++){
        if(arr[j]<pivot){
            i++;
            int temp=arr[i];
            arr[i]=arr[j];
            arr[j]=temp;
        }
    }
    int temp=arr[i+1];
    arr[i+1]=arr[high];
    arr[high]=temp;
    return i+1;
}

void QuickSort(int arr[],int low,int high){
    if(low<high){
        int pi=part(arr,low,high);
        QuickSort(arr,low,pi-1);
        QuickSort(arr,pi+1,high);
    }
}
```
#### 3. Bubble Sort

```c
void Bubble(int arr[],int n){
    for(int i=0;i<n-1;i++){
        for(int j=0;j<n-i-1;j++){
            if(arr[i+1]>arr[i]){
                int temp=arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=temp;
            }
        }
    }
}
```
#### 4. Merge Sort
```c
void Merge(int arr[],int left,int right){
    int i,j,k;
    int n1=mid-left+1;
    int n2=right-mid;
    int *L=(int *)malloc(n*sizeof(int));
    int *R=(int *)malloc(n*sizeof(int));
    for(int i=0;i<n1;i++){
        L[i]=arr[left+i];
    }
    for(int j=0;j<n;j++){
        R[j]=arr[mid+1+j];
    }
    int i=0,j=0,k=left;
    while(i<n1&&j<n2){
        if(L[i]<=R[j]){
            arr[k]=L[i];
            i++;
        }else{
            arr[k]=R[j];
            j++;
        }
        k++;
    }
    while(i<n1){
        arr[k]=L[i];
        i++;
        k++;
    }
    while(j<n2){
        arr[k]=R[j];
        j++;
        k++;
    }
    free(L);
    free(R);
}

void MergeSort(int arr[],int left,int right){
    if(left<right){
        int mid=left+(right-left)/2;
        MergeSort(arr,left,mid);
        MergeSort(arr,mid+1,right);
        Merge(arr,left,mid,right);
    }
}
```
#### 5. Prime
```c
int isPrime(int n) {
    if (n <= 1) {
        return false;
    }
    if (n == 2) {
        return true;
    }
    if (n % 2 == 0) {
        return false;
    }
    
    int limit = sqrt(n);
    for (int i = 3; i <= limit; i += 2) {
        if (n % i == 0) return false;
    }
    return true;
}
```
#### 6. GCD
```c
int gcd(int a,int b){
    return b==0?a:gcd(b,a%b);
}
```
#### 7. LCM
```c
int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int lcm(int a, int b) {
    return (a / gcd(a, b)) * b;
}
```
### 3. Expression Evaluation
|Infix expression|Postfix expression|
|-|-|
|$5+6*3$|$563*+$|
|$b*c/d$|$bc*d/$|
|$(5+6)*7$|$56+7*$|
|$x/y-z+i*j-x*y$|$xy/z-ij*+xy*-$|
|$x*y-6$|$xy*6-$|

![](https://img2020.cnblogs.com/blog/1341397/202005/1341397-20200525220843412-1696817051.png)
![](https://img-blog.csdnimg.cn/606c221ebdc347e291c81414700bfbd0.png)
### 4. Common Pitfalls
#### 1. Keywords
```c
define(×) but typedef(√)  
```
#### 2. Strings
```c
char str[10]; str="Hello";    (×)
char str[10]="Hello";    (√)
char str[10]; strcpy(str,"Hello");    (√)
```
```c
/*if you want to int put a string in some formats like sentences:*/

#define MAXN 10000
#include<string.h>
char a[MAXN];
fgets(a,sizeof(a),stdin);
a[strcspn(a,"\n")]='\0';
puts(a);          /* you can also use printf("%s",a); */
```
#### 3. Choose
```c
such as:

(a>b?c>a?c-3:c-1:b==c?d-a:d-c)

can be changed to

a>b?(c>a?c-3:c-1):(b==c?d-a:d-c)
```
#### 4. ASCII
```c
'A'->65
'0'->48
'a'->97
'\0'->0
```
#### 5. Function of string.h
```c
strlen( )  ->  return the length of a string(without "\0")
```
```c
strcmp( , )  ->  return 0 if str1=str2.else if str1<str2,return >0.else <0
```
```c
strncmp( , , )  ->  compare the first n elements of a string
```
```c
strcpy( , )  ->  copy something to a string
```
```c
strncpy( , , )  ->  copy the first n elements of something
```
```c
strcat( , )   ->  Concatenate the latter string to the previous one
```
```c
strncat( , , )  ->  Concatenate the first n elements of the latter string to the previous one
```
```c
strchr( , )  ->  first index of the data,else return NULL
```
```c
strrchr( , )  ->  last index of the data,else return NULL
```
#### 6. Array
```c
such as:
a[3][3]={1,2,3,4,5,6,7,8,9};
the value of a[-1][5] is?
like this: 
a[-1]: 0,0,0  //three elements
a[-1][0]->0,0,0,1,2,3<-a[-1][5]

※:so for an array like a[M][N],(a[k]+m)[n] is equal to *((a[k]+m)+n).
that is,shift a[k][0] backward by (m+n) units of int/double/char...
```
```c

some calculation like:
double a[]={1,2,3,4,5};
(int)&a[3]-int&a[0]=24.

another calculation is:
int a[]={1,2,3,4,5};
int *p=a,*q=&a[2];
what is the output of printf("%lu",q-p);?
it is 2,which is different from the one before.
```
```c
some strings like:
char *week[]={"Mon","Tue","Wed","Thu","Fri","Sat","Sun"},**pw=week;
char c1,c2;
c1=(*++pw)[1];
c2=*++pw[1];
so pw points to week[0],and ++pw points to week[1];
c1=week[1][1]=u.
then pw[1] is *(pw+1),that is,pw points to week[2].
so it is week[1][1] to week[2][1].c2=e;
```
#### 7. Documents
```c
define a pointer of a document:FILE *fp;
```
```c
fopen:return the pointer of the document.if failed,return NULL 
```
```c
fclose:return 0.if failed,return EOF
```
```c
fgetc:return the string.if failed,return EOF
```
|Key|Meaning|Condition|
|-|-|-|
|r|read only|document exists|
|w|write only|create new document,or overwrite the original file|
|a|add|add or create something to the end of the documents|
|rb|read only(binary)|document exists|
|wb|write only(binary)|create new document,or overwrite the original file|
|r+|read and write|document exists|
|w+|read and write|clear the original one if existing,else create a new one|
|a+|read or add|if the document don't exist,create a,new one.if,writing,only add something to the end of document.if reading,it is okay to read the whole document|
|rb+|read and write,open the document of binary|document exists|
|wb+|read and write,open the document of binary|clear the original one if existing,else create a new one| 
#### 8. Others
```c
unsigned short->0~65535,so 0-1=65535
```
```c
'\x11':only two numbers
```
```c
'%c':(×)
```
```c
'%' '&' '<<':false when using double
```
```c
if you want to input some elements without inputing n:

#define MAXN 10000
int ch;
int k=0;
int a[MAXN];
while(scanf("%d",&ch)!=EOF){
    a[k++]=ch;
}
```
## Fundamentals of Data Structure
### Complexity
#### Time Complexity
Time complexity is not the running time of the program.

##### Definitions
1.  **Big-O Notation**
    \( T(N) = \mathcal{O}(f(N)) \) if there exist positive constants \( c \) and \( n_0 \) such that
    \[
    T(N) \le c \cdot f(N) \quad \text{for all } N \ge n_0.
    \]

2.  **Big-Omega Notation**
    \( T(N) = \Omega(g(N)) \) if there exist positive constants \( c \) and \( n_0 \) such that
    \[
    T(N) \ge c \cdot g(N) \quad \text{for all } N \ge n_0.
    \]

3.  **Big-Theta Notation**
    \( T(N) = \Theta(h(N)) \) if and only if \( T(N) = \mathcal{O}(h(N)) \) and \( T(N) = \Omega(h(N)) \).

4.  **Little-o Notation**
    \( T(N) = o(p(N)) \) if \( T(N) = \mathcal{O}(p(N)) \) and \( T(N) \neq \Theta(p(N)) \).

---

**Note**

-   For \( 2N + 3 \):
    \[
    2N + 3 = \mathcal{O}(N) = \mathcal{O}(N^{k \ge 1}) = \mathcal{O}(2^N) = \dots
    \]
    We shall always take the **smallest** \( f(N) \).

-   For \( 2^N + N^2 \):
    \[
    2^N + N^2 = \Omega(2^N) = \Omega(N^2) = \Omega(N) = \Omega(1) = \dots
    \]
    We shall always take the **largest** \( g(N) \).

##### Examples
**eg.1** 
[2022]What is the time complexity of the following program?
```c
int sum=0;
for(int i=1;i<n;i*=2){
    for(int j=0;j<i;j++){
        sum++;
    }
}
```
Answer:O(n).
**eg.2.** 
What is the time complexity of the following program?
```c

```
Answer:.
#### Space Complexity
### Liner List
#### 1. Sequential List
Elements that are logically adjacent are also stored in consecutive physical memory locations.
##### (0) Structure
```c
#define MAXSIZE=100
typedef int ElemType;
typedef strcut{
    ElemType data[MAXSIZE];
    int lenth;
}SeqList;
```
##### (1) Initialize
```c
void initList(SeqList *L){
    L->length=0;
}
```
##### (2) Insert at Tail
```c
int appendElem(SeqList *L,ElemType e){
    if(L->length>=MAXSIZE){
        printf("SeqList is full.");
        return 0;
    }

    L->data[L->length]=e;
    L->length++;
    return 1;
}
```
##### (3) Traverse
```c
void listElem(SeqList *L){
    
    for(int i=0;i<L->length;i++){
        if(i!=0){
            printf(" ");
        }
        printf("%d",L->data[i]);
    }

    printf("\n");
}
```
##### (4) Insert Elements
```c
int insertElem(SeqList *L,int pos,ElemType e){
    if(pos<=L->length){
        for(int i=L->length-1;i>=0;i--){
            L->data[i+1]=L->data[i];
        }
        L->data[pos-1]=e;
        L->length++;
    }
    return 1;   
}
```
##### (5) Delete Elements
```c
int deleteElem(SeqList *L,int pos,ElemType *e){
    *e=L->data[pos-1];                //saving the deleted element.
    if(pos<L->length){
        for(int i=pos;i<L->length;i++){
            L->data[i-1]=L->data[i];
        }
    }
    L->length--;
    return 1;
}
```
##### (6) Search for Elements
```c
int findElem(SeqList *L,ElemType e){

    for(int i=0;i<L->length;i++){
        if(L->data[i]==e){
            return i+1;
        }
    
    }
    return 0;
}
```
##### (7) Dynamic Allocation of Memory Address Initialization
```c
SeqList *initList(){
    SeqList *L=(SeqList *)malloc(sizeof(SeqList));
    L->data=(ElemType *)malloc(sizeof(ElemType)*MAXSIZE);
    L->length=0;
    return L;
}
```
#### 2. Linked List
##### (0) Structure
```c
typedef int ElemType

typedef struct node{
    ElemType data;
    struct node* next;
}Node;
```
##### (1) Initialize
```c
Node* InitList(){
    Node *head=(Node *)malloc(sizeof(Node));
    head->data=0;
    head->next=NULL;
    return head;
}

int main(){
    Node *list=InitList();
    return 1;
}
```
##### (2) Head Insertion
```c
int insertHead(Node *L,ElemType e){
    Node *p=(Node*)malloc(sizeof(Node));
    p->data=e;
    p->next=L->next;
    L->next=p;
}

int main(){
    Node *list=initList();
    insertHead(list,10);
    insertHead(list,20);
}
```
##### (3) Tail Insertion
```c
Node *Tailinsert(Node *L,ElemType e){
    Node *p=(Node *)malloc(sizeof(Node));
    p->data=e;
    p->next=NULL;

    if(L==NULL){
        return p;
    }

    Node *q=L;
    while(q->next!=NULL){
        q=q->next;
    }

    q->next=p;
    return L;
}
```
##### (4) Traverse
```c
void listNode(Node *L){
    Node* p=L->next;
    
    int first=1;
    while(p!=NULL){
        if(first==0){
            printf(" ");
        }else{
            printf("%d",p->data);
            first=0;
        }
        p=p->next;
    }

    printf("\n");
}
```
##### (5) Insert at Specific Position
```c
int InsertAtPosition(Node *L,int pos,ElemType e){
    Node* p=L;
    int i=0;

    while(i<pos-1){
        p=p->next;
        i++;
        if(p==NULL){
            return 0;
        }
    }

    Node *q=(Node *)malloc(sizeof(Node));
    q->data=e;
    q->next=p->next;
    p->next=q;

    return 1;
}
```
##### (6) Delete Node
```
int DeleteNode(Node *L,int pos){
    Node *p=L;
    int i=0;

    while(i<pos-1){
        p=p->next;
        i++;
        if(p==NULL){
            return 0;
        }
    }

    if(p->next==NULL){
        return 0;
    }

    Node *q=p->next;
    p->next=q->next;
    free(q);
    return 1;
}
```
##### (7) Get Length
```c
int ListLength(Node *L){
    Node *p=L;
    int len=0;

    while(p!=NULL){
        p=p->next;
        len++;
    }

    return len;
}
```
##### (8) Free List
```c
void FreeList(Node* L){
    Node* p=L->next;
    Node* q;

    while(p!=NULL){
        q=p->next;
        free(p);
        p=q;
    }

    L->next=NULL;
}
```
##### (9) Delete Nodes with the Same Absolute Value
```c
void removeNode(Node *L,int n){
    Node *p=L;
    int index;
    int *q=(int *)malloc(sizeof(int)*(n+1));

    for(int i=0;i<n+1;i++){
        *(q+i)=0;
    }

    while(p->next!=NULL){
        index=abs(p->next->data);  /*Remember to add "#include<stdlib.h>"*/

        if(*(q+index)==0){
            *(q+index)=1;
            p=p->next;
        }else{
            Node *temp=p->next;
            p->next=temp->next;
            free(temp);
        }

    }

    free(q);
}
```
##### (10) Reverse List
```c
Node *reverseList(Node *head){
    Node *first=NULL;
    Node *second=head->next;
    Node *third;

    while(second!=NULL){
        third=second->next;
        second->next=first;
        first=second;
        second=third;
    }

    Node *hd=initList();  /*Create a new node.*/
    hd->next=first;

    return hd;
}
```
##### (11) Determine if a Linked List Has a Cycle
```c
int isCycle(Node *head){

    Node *fsat=head;
    Node *slow=head;

    while(fast!=NULL&&fast->next!=NULL){
        fast=fast->next->next;
        slow=slow->next;

        if(fast==slow){
            return 1;
        }
    }

    return 0;
}
```
##### (12) Find the Entrance of a Linked List Cycle
 ```c
Node *findBegin(Node *head){
    Node *fast=head;
    Node *slow=head;

    while(fast!=NULL&&fast->next!=NULL){
        
        fast=fast->next->next;
        slow=slow->next;

        if(fast==slow){

            Node *p=fast;
            int cnt=1;

            while(p->next!=slow){
                cnt++;
                p=p->next;
            }

            fast=head;
            slow=head;

            for(int i=0;i<cnt;i++){
                fast=fast->next;
            }

            while(fast!=slow){
                fast=fast->next;
                slow=slow->next;
            }

            return slow;
        }
    }

    return NULL;
}
 ```
#### 3. Double Linked List
##### (0) Structure
```c
typedef int ElemType;

typedef struct node{
    ElemType data;
    struct node *prev,*next;
}Node;
```
##### (1) Head Insertion
```c
int insertHead(Node *L,ElemType e){
    Node *p=(Node*)malloc(sizeof(Node));
    p-data=e;
    p->prev=L;
    p->next=L->next;
    if(L->next!=NULL){
        L->next->prev=p;
    }
    L-next=p;
    return 1;
}
```
##### (2) Tail Insertion
```c
Node *insertTail(Node *tail,ElemType e){
    Node *p=(Node*)malloc(sizeof(Node));
    p->data=e;
    p->prev=tail;
    tail->next=p;
    p->next=NULL;
    return p; 
}
```
##### (3) Insert at Specific Position
```c
int insertNode(Node *L,int pos,ElemType e){
    Node *p=L;
    int i=0;
    while(i<pos-1){
        p=p->next;
        i++;
        if(p==NULL){
            return 0;
        }
    }
    Node *q=(Node*)malloc(sizeof(Node));
    q->data=e;
    q->prev=p;
    q->next=p->next;
    p->next->prev=q;
    p->next=q;
    return 1;
}
```
##### (4) Delete Node
```c
int deleteNode(Node *L,int pos){
    Node *p=L;
    int i=0;
    while(i<pos-1){
        p=p->next;
        i++;
        if(p==NULL){
            return 0;
        }
    }
    if(p->next==NULL){
        return 0;
    }
    Node *q=p->next;
    p->next=q->next;
    q->next->prev=p;
    free(q);
    return 1;
}
```
#### 4. Double Pointers
##### (1) Find the K-th Last Node Using the Two-Pointer Technique
```c
int findNodeFS(Node *L,int k){
    Node *fast=L->next;
    Node *slow=L->next;

    for(int i=0;i<k;i++){
        fast=fast->next;
    }

    while(fast!=NULL){
        fast=fast->next;
        slow=slow->next;
    }

    printf("%d\n",slow->data);
}
```
##### (2) Find the Starting Position of Common Storage
```c
Node *findIntersectionNode(Node *headA,Node *headB){
    if(headA==NULL||headB==NULL){
        return NULL;
    }

    int lenA=0;
    int lenB=0;
    
    Node* p=headA;
    while(p!=NULL){
        lenA++;
    }

    Node* q=headB;
    while(q!=NULL){
        lenB++;
    }

    int delta;
    Node *fast;
    Node *slow;
    if(lenA>lenB){
        delta=lenA-lenB;
        fast=headA;
        slow=headB;
    }else{
        delta=lenB-lenA;
        fast=headB;
        slow=headA;
    }

    for(int i=0;i<delta;i++){
        fast=fast->next;
    }

    while(fast!=slow){
        fast=fast->next;
        slow=slow->next;
    }

    return fast;     /*"return slow"is Ok too.*/
}
```
##### (3) Delete the Middle Node
```c
int deleteMiddleNode(Node *head){
    Node *first=head->next;
    Node *slow=head;

    while(fast!=NULL&&fast->next!=NULL){
        fast=fast->next->next;
        slow=slow->next;
    }

    Node *q=slow->next;
    slow->next=q->next;
    free(q);

    return 1;
}
```
#### 5. Middle Node
##### (1) Reorder the Linked List
```c
void reOrderList(Node *head){
    Node *fast=head->next;
    Node *slow=head;

    while(fast!=NULL&&fast->next!=NULL){
        fast=fast->next->next;
        slow=slow->next;
    }

    Node *first=NULL;
    Node *second=slow->next;
    slow->next=NULL;
    Node *third=NULL;

    while(second!=NULL){
        third=second->next;
        second->next=first;
        first=second;
        second=fist;
    }

    Node *p1=head->next;
    Node *q1=first;
    Node *p2,*q2;

    while(p1!=NULL&&q1!=NULL){
        p2=p1->next;
        q2=q1->next;

        p1->next=q1;
        q1->next=p2;

        p1=p2;
        q1=q2;
    }

}
```
### Stacks and Queues
#### 1. Sequential Stack
##### (0) Structure
```c
#define MAXNSIZE = 100
typedef int ElemType;

typedef struct{
    ElemType data[MAXNSIZE];
    int top;
}Stack;
```
##### (1) Initialize
```c
void initStack(Stack *s){
    s->top=-1;
}
```
##### (2) Check if the Stack Is Empty
```c
int isEmpty(Stack *s){
    if(s->top==-1){
        printf("Empty!");
        return 1;
    }else{
        return 0;
    }
}
```
##### (3) Push
```c
int push(Stack *s,ElemType e){
    if(s->top>=MAXNSIZE-1){
        printf("Full!");
        return 0;
    }
    s->top++;
    s->data[s->top]=e;
    return 1;
}
```
##### (4) Pop
```c
ElemType pop(Stack *s,ElemType *e){
    if(t->top==-1){
        printf("Empty!");
        return 0;
    }
    *e=s->data[s->top];
    s->top--;
    return 1;
}
```
##### (5) Get the Element of Top
```c
int getTop(Stack *s,ElemType *e){
    if(s->top==1){
        printf("Empty!");
        return 0;
    }
    *e=s->data[s->top];
    return 1;
}
```
##### (6) Dynamic Memory Allocation
```c
Stack *initStack(){
    Stack *s=(Stack*)malloc(sizeof(Stack));
    s->data=(ElemType*)malloc(MAXNSZIE*sizeof(ElemType));
    s->top=-1;
    return s;
}
```
#### 2. Linked Stack
##### (0) Structure
```
typedef int ElemType;

typedef struct stack{
    ElemType data;
    struct stack *next;
}Stack;
```
##### (1) Initialize
```
Stack *initStack(){
    Stack *s=(Stack*)malloc(sizeof(Stack));
    s->data=0;
    s->naet=NULL;
    return s;
}
```
##### (2) Check if the Stack Is Empty
```
int isEmpty(Stack *s){
    if(s->next==NULL){
        printf("Empty!");
        return 1;
    }else{
        return 0;
    }
}
```
##### (3) Push
```
int push(Stack *s,ElemType e){
    Stack *p=(Stack*)mallic(sizeof(Stack));
    p->data=e;
    p->next=s->next;
    s->next=p;
    return 1;
}
```
##### (4) Pop
```
int pop(Stack *s,ElemType *e){
    if(s->next=NULL){
        printf("Empty!");
        return 0;
    }
    *e=s->next->data;
    Stack *q=s->next;
    s->next=q->next;
    free(q);
    return 1;
}
```
##### (5) Get the Top Element of Stack
```
int getTop(Stack *s,ElemType *e){
    if(s->next==NULL){
        printf("Empty!");
        return 0;
    }
    *e=s->next->data;
    return 1;
}
```
#### 3. Sequential Queue
##### (0)Structure
```
#define MAXNSIZE 100
typedef int ElemType
typedef struct{
    ElemType data[MAXNSIZE];
    int front;
    int rear;
}Queue;
```
##### (1) Initialize
```
void initQueue(Queue *Q){
    Q->front=0;
    Q->rear=0;
}
```
##### (2) Check if the Queue Is Empty
```
int isEmpty(Queue *Q){
    if(Q->front==Q->rear){
        printf("Empty!");
        return 1;
    }else{
        return 0;
    }
}
```
##### (3) Dequeue
```
ElemType dequeue(Queue *Q){
    if(Q->front==Q->rear){
        printf("Empty!");
        return 0;
    }
    ElemType e=Q->data[Q->front];
    Q->front++;
    return e;
}
```
##### (4) Enqueue
```
int queueFull(Queue *Q){
    if(Q->front>0){
        int step=Q->front;
        for(int i=Q->front;i<=Q->rear;i++){
            Q->data[i-step]=Q->data[i];
        }
        Q->front=0;
        Q->rear=Q->rear-step;
        return 1;
    }else{
        printf("Really Full");
        return 0;
    }
}

int enqueue(Queue *Q,ElemType e){
    if(Q->rear>=MAXNSIZE){
        if(!queueFull(Q)){
            return 0;
        }
    }
    Q->data[Q->rear]=e;
    Q->rear++;
    return 1;
}
```
##### (5) Get the Head Element
```
int getHead(Queue *Q,ElemType *e){
    if(Q->front==Q->rear){
        printf("Empty!");
        return 0;
    }
    *e=Q->data[Q->front];
    return 1;
}
```
##### (6) Dynamic Memory Allocation
```
Queue *initQueue(){
    Queue *q=(Queue*)malloc(sizeof(Queue));
    q->data=(ElemType*)malloc(sizeof(ElemType)*MAXNSIZE);
    q->front=0;
    q->rear=0;
    return q;
}
```
#### 4. Circular Queue
##### (0) Structure
```
typedef int ElemType;

typedef struct{
    ElemType *data;
    int front;
    int rear;
}Queue;
```
##### (1) Enqueue
```
int equeue(Queue *Q,ElemType e){
    if((Q->rear+1)%MAXNSIZE==Q->front){
        printf("Full!\n");
        return 0;
    }
    Q->data[Q->rear]=e;
    Q->rear=(Q->rear+1)%MAXNSIZE;
    return 1;
}
```
##### (2) Dequeue
```
int dequeue(Queue *Q,ElemType *e){
    if(Q->front==Q->rear){
        printf("Empty!\n");
        return 0;
    }
    *e=Q->data[Q->front];
    Q->front=(Q->front+1)%MAXNSIZE;
    return 1;
}
```
##### (3) Initialize
```
Queue *initQueue(){
    Queue *q=(Queue*)malloc(sizeof(Queue));
    q->data=(ElemType*)malloc(sizeof(ElemType));
    q->front=0;
    q->rear=0;
    return q;
}
```
##### (4) Check if the Queue Is Empty
```
int isEmpty(Queue *Q){
    if(Q->front==Q->rear){
        printf("Empty!\n");
        return 1;
    }else{
        return 0;
    }
}
```
##### (5) Get the Head Element of Queue
```
int getHead(Queue *Q,ElemType *e){
    if(Q->front==Q->rear){
        printf("Empty!\n");
        return 0;
    }
    *e=Q->data[Q->front];
    return 1;
}
```
#### 5. Linked Queue
##### (0) Structure
```
typedef struct QueueNode{
    ElemType data;
    struct QueueNode *next;
}QueueNode;

typedef struct{
    QueueNode *front;
    QueueNode *rear;
}Queue;
```
##### (1) Initialize
```
Queue *initQueue(){
    Queue *q=(Queue*)malloc(sizeof(Queue));
    QueueNode *node=(QueueNode*)malloc(sizeof(QueueNode));
    node->data=0;
    node->next=NULL;
    q->front=node;
    q->rear=node;
    return q;
}
```
##### (2) Check if the Queue Is Empty
```
int isEmpty(Queue *q){
    if(q->front==q->rear){
        return 1;
    }else{
        return 0;
    }
}
```
##### (3) Enqueue
```
void equeue(Queue *q,ElemType e){
    QueueNode *node=(QueueNode*)malloc(sizeof(QueueNode));
    node->data=e;
    node->next=NULL;
    q->rear->next=node;
    q->rear=node;
}
```
##### (4) Dequeue
```
int dequeue(Queue *q,ElemType *e){
    QueueNode *node=q->front->next;
    *e=node->data;
    q->front->next=node->next;
    if(q->rear==node){
        q->rear=q->front;
    }
    free(node);
    return 1;
}
```
##### (5) Get the Head Element of Queue
```
int isEmpty(Queue *q){
    if(q->front==q->rear){
        return 1;
    }else{
        return 0;
    }
}                       /*See it in "(2) Check if the Queue Is Empty" */

ElemType getFront(Queue *q){
    if(isEmpty(q)){
        printf("Empty!\n");
        return 0;
    }
    return q->front->next->data;
}
```
### Recursion
#### 1. Some Sequences
##### (1) Arithmetic Sequence
```
/*Non-recursive Way*/
int fun(int n){
    int sum=0;
    for(int i=1;i<=n;i++){
        sum+=i;
    }
    return sum;
}

/*Recursive Way*/
int fun(int n){
    if(n==1){
        return 1;
    }else{
        return fun(n-1)+n;
    }
}
```
##### (2) Fibonacci sequence
```
/*Non-recursive Way*/
int fibonacci(int n){
    int last1=1;
    int last2=1;
    int result=0;
    for(int i=3;i<=n;i++){
        result=last1+last2;
        last2=last1;
        last1=result;
    }
    return result;
}

/*Recuersive Way*/
int fibonacci(int n){
    if(n==1||n==2){
        return 1;
    }else{
        return fibonacci(n-1)+fibonacci(n-2);
    }
}
```
### Enumeration
#### 1. Basic Part
##### (0) Structure
```
/*Core Syntax Framework*/
enum EnumName {
    Constant1,  // Default value: 0
    Constant2   // Default value: 1 (auto-increment)
};

/*Custom version*/
enum EnumName {
    Constant1 = 1,  // Default value: 1
    Constant2   // Default value: 2 (auto-increment)
};
```
### Trees and Binary Trees
#### 1. Trees
##### (1) Definition
>- **Node:** An independent unit in a tree.
>- **Degree of a node:** The number of subtrees a node has.
>- **Degree of a tree:** The maximum degree of all nodes within the tree.
>- **Leaf:** A node with degree 0, also called a terminal node.
>- **Non-terminal node:** A node with a degree not equal to 0.
>- **Parent and child:** The root of a node's subtree is called its child; correspondingly, the node is called the parent of its child.
>- **Level:** The level of a node is defined starting from the root. The root is at level 1, the children of the root are at level 2, and so on.
##### (2) Properties
>** Property 1:** The total number of nodes in a tree is equal to the sum of the degrees of all nodes plus one.

>**Property 2:** For a tree of degree $m$, the $i$-th level can have at most $m^{i−1}$ nodes.

>**Property 3:** For a tree with height \(h\) and degree \(m\), the maximum number of nodes is \(\frac{m^h - 1}{m - 1}\).
#### 2. Binary Trees
##### (1)Definition
A binary tree is a collection of \(n\) (\(n \ge 0\)) nodes. It is either an empty tree (\(n = 0\)) or a non-empty tree. For a non-empty tree \(T\):

>**1.** There is exactly one node called the root node.

>**2.** All other nodes except the root are divided into two disjoint subsets \(T_1\) and \(T_2\), called the left subtree and right subtree of \(T\), respectively, and both \(T_1\) and \(T_2\) are themselves binary trees.

>**3.** Each node in a binary tree has at most two subtrees.

>**4.** The subtrees of a binary tree are distinguished as left and right, and their order cannot be arbitrarily reversed.
##### (2) Properties
>**Property 1:** The \(i\)-th level of a binary tree can have at most \(2^{i-1}\) nodes, where \(i \ge 1\).

>**Property 2:** A binary tree with depth \(k\) can have at most \(2^k - 1\) nodes, where \(k \ge 1\).

>**Property 3:** For any non-empty binary tree \(T\), if the number of leaf nodes is \(n_0\) and the number of nodes with degree 2 is \(n_2\), then \(n_0 = n_2 + 1\).
##### (3) Full Binary Tree
A binary tree with depth \(k\) and exactly \(2^k - 1\) nodes.

- All leaf nodes can only appear on the last level.
- Among all binary trees of the same depth, a full binary tree has the maximum number of nodes and the maximum number of leaf nodes.
- If we number the nodes of a full binary tree starting from 1 at the root, proceeding top to bottom and left to right, then for a node numbered \(i\):
  - If it has a left child, the left child's number is \(2i\).
  - If it has a right child, the right child's number is \(2i + 1\).
##### (4) Complete Binary Tree
A binary tree with depth \(k\) and \(n\) nodes is called a complete binary tree if and only if each of its nodes corresponds one-to-one with the nodes numbered from 1 to \(n\) in a full binary tree of depth \(k\).

The characteristics of a complete binary tree are:
- **Property 1:** Leaf nodes can only appear on the two levels with the largest depth.
- **Property 2:** For any node, if the maximum level of its descendants in its right subtree is \(l\), then the maximum level of its descendants in its left subtree must be \(l\) or \(l+1\).
- **Property 3:** If there is no left subtree, there can be no right subtree; if the upper level is not fully filled, there can be no next level.
- **Property 4:** The depth of a complete binary tree with \(n\) nodes is \(\lfloor \log_2 n \rfloor + 1\) (floor value).
- **Property 5:** If the nodes of a complete binary tree with \(n\) nodes (its depth is \(\lfloor \log_2 n \rfloor + 1\)) are numbered level by level (from level 1 to level \(\lfloor \log_2 n \rfloor + 1\), left to right within each level), then for any node \(i\) (\(1 \le i \le n\)), the following conclusions hold:

   - If \(i = 1\), node \(i\) is the root of the binary tree and has no parent; if \(i > 1\), its parent is node \(\lfloor i/2 \rfloor\) (floor value).
   - If \(2i > n\), node \(i\) has no left child (node \(i\) is a leaf node); otherwise, its left child is node \(2i\).
   - If \(2i + 1 > n\), node \(i\) has no right child; otherwise, its right child is node \(2i + 1\).
#### 3. Linked Storage Structure of Binary Tree
##### (0) Structure
The **linked storage structure of a binary tree** uses a linked list to represent a binary tree.
Each node contains:
1. A data field
2. A pointer to the left child
3. A pointer to the right child

This structure is called a **binary linked list**.
```
typedef char ElemType

typedef struct TreeNode{
    ElemType data;
    TreeNode *lchild;
    TreeNode *rchild;
}TreeNode;

typedef TreeNode *BiTree;
```
##### (1) Pre-order Traversal
First, visit the root node, then visit every node encountered on the left branch, continuing this process until an empty node is reached. At this point, return to the nearest ancestor node that has a right child and continue the traversal starting from the right child of that node.
```
void preOrder(BiTree T){
    if(T==NULL){
        return;
    }
    printf("%c",T->data);
    preOrder(T->lchild);
    preOrder(T->rchild);
}
```
##### (2) In-order Traversal
First, visit the root node and move to the lower-left of the tree until an empty node is encountered. Then visit the parent node of the empty node. Next, continue to traverse the right subtree of this node. If there are no more subtrees of the right subtree to traverse, continue to traverse the last unvisited node from the previous level.
```
void inOrder(BiTree T){
    if(T==NULL){
        return;
    }
    inOrder(T->lchild);
    printf("%c",T->data);
    inOrder(T->rchild);
}
```
##### (3) Post-order Traversal
Starting from the root node, first visit the left and right children of the node, and then visit the node itself. This means that the children of a node will be output before the node.
```
void postOrder(BiTree T){
    if(T==NULL){
        return;
    }
    postOrder(T->lchild);
    postOrder(T->rchild);
    printf("%c",T->data);
}
```
##### (4) Non-Recursive Preorder Traversal
```
void iterPreOrder(Stack *s,BiTree T){
    while(T!=NULL||isEmpty(s)!=0){
        while(T!=NULL){
            printf("%c",T->data);
            push(s,T);
            T=T->lchild;
        }
        pop(s,&T);
        T=T->rchild;
    }
}
```
---

## Digital Logic Design
### Number Systems
Converting from 2, 8, 16:

>1.  The right expansion method
>2.  Fractional shift method
>3.  Digital replacement method
---

## Code
### Summary of Methods
>Below is a description of each category along with universal C code templates.
---

#### 1. Dynamic Programming
Interpretation: Suitable for problems with overlapping subproblems and optimal substructure, such as knapsack, path counting, and sequence problems. The core steps are defining the state, writing the state transition equation, determining boundaries, and computing in order.

**Universal Code (0-1 Knapsack):**
```c
#include <stdio.h>
#define max(a,b) ((a)>(b)?(a):(b))

int knapsack(int capacity, int n, int w[], int v[]) {
    int dp[capacity+1];
    for (int i = 0; i <= capacity; i++) dp[i] = 0;
    for (int i = 0; i < n; i++) {
        for (int j = capacity; j >= w[i]; j--) {
            dp[j] = max(dp[j], dp[j - w[i]] + v[i]);
        }
    }
    return dp[capacity];
}
```
---

#### 2. Sorting
Interpretation: Rearrange data according to specified rules to facilitate subsequent processing (e.g., deduplication, ranking, statistics). In C, qsort is commonly used with a custom comparison function supporting multiple keys.

**Universal Code:**
```c
#include <stdlib.h>
typedef struct { int key1; int key2; } Item;
int cmp(const void *a, const void *b) {
    Item *pa = (Item*)a, *pb = (Item*)b;
    if (pa->key1 != pb->key1) return pb->key1 - pa->key1; // descending
    return pa->key2 - pb->key2;                           // ascending
}
// Usage: qsort(arr, n, sizeof(Item), cmp);
```
---

#### 3. Simulation
Interpretation: Strictly follow the procedure described in the problem, using loops and branches to handle each step. Pay attention to boundary conditions and special rules.

**Universal Code Framework:**
```c
#include <stdio.h>
int main() {
    // Initialize state variables
    while (/* not finished */) {
        // Get next input or operation
        // Update state
        // Check termination condition
    }
    // Output result
    return 0;
}
```
---

#### 4. Search / Enumeration
Interpretation: Traverse all possible states (e.g., combinations, permutations) and check if they satisfy conditions. DFS recursion is often used, with pruning when possible.

**Universal Code (Combination Enumeration):**
```c
void dfs(int start, int depth, int sum) {
    if (depth == k) { // k items selected
        if (/* condition holds */) count++;
        return;
    }
    for (int i = start; i < n; i++) {
        dfs(i+1, depth+1, sum + a[i]);
    }
}
```
---

#### 5. Mathematical / Insight
Interpretation: Use mathematical laws, formulas, or properties to solve directly, avoiding complex simulation. Examples include finding patterns, base conversion, number theory, etc.

**Universal Code (Binary Thinking):**
```c
long long solve(int base, int N) {
    long long res = 0, pow = 1;
    while (N) {
        if (N & 1) res += pow;
        pow *= base;
        N >>= 1;
    }
    return res;
}
```
---

#### 6. Greedy
Interpretation: At each step, make the locally optimal choice, hoping to achieve a global optimum. The correctness of the greedy strategy must be proven. Often used in grouping and scheduling problems.

**Universal Code (Two‑Pointer Pairing):**
```c
#include <stdlib.h>
int cmp_int(const void *a, const void *b) { return *(int*)a - *(int*)b; }
int greedy(int *arr, int n, int limit) {
    qsort(arr, n, sizeof(int), cmp_int);
    int l = 0, r = n-1, ans = 0;
    while (l <= r) {
        if (l == r) { ans++; break; }
        if (arr[l] + arr[r] <= limit) { l++; r--; }
        else r--;
        ans++;
    }
    return ans;
}
```
---

#### 7. Binary Search
Interpretation: Quickly approximate a solution by repeatedly halving a monotonic interval. Often used for root finding or boundary searching. Must define a monotonic function and a predicate.

**Universal Code (Root Finding):**
```c
double f(double x) { /* define function */ }
double binary(double L, double R, double eps) {
    while (R - L > eps) {
        double mid = (L + R) / 2;
        if (f(L) * f(mid) <= 0) R = mid;
        else L = mid;
    }
    return (L + R) / 2;
}
```
---

### Fundamentals of Programming and Algorithms Part
#### Overall Format
```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main(){

    return 0;
}
```
---

#### 1. Calculate the time difference.
How many hours and minutes are there between $10:30$ and $11:45$?
Here is a program that reads two times, calculates the time difference between them, and outputs the difference in hours and minutes.
``` 
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main(){
    int hour1,hour2;
    int minute1,minute2;
    
    scanf("%d:%d",&hour1,&minute1);
    scanf("%d:%d",&hour2,&minute2);
    
    int hd=hour2-hour1;
    int md=minute2-minute1;

    if(md<0){
        hd-=1;
        md+=60;
    }

    printf("%d %d",hd,md);
    
    return 0;
}
```
---

#### 2. Break when inputing $-1$.
Write a program that reads a lot of integers in and prints out the sum of all the integers and the number of the integers read. The input ends with a $-1$ which is not part of the data.
```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main(){
    int sum=0;
    int cut=0;

    while(1){
        int x;
        scanf("%d",&x);

        if(x==-1){
            break;
        }
        sum+=x;
        cnt+=1;
    }

    printf("%d %d\n",sum,cnt);
    return 0;
}
```
---

#### 3. Calculate $x×y$.
Write a program that inputs two numbers separated by a comma in the same line, calculates the product of these two numbers, and outputs the result.

**Input Format:**
 $x,y$

**Output Format:**
 $x*y=product$
```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main(){
    int x,y;

    scanf("%d,%d",&x,&y);

    printf("%d*%d=%d",x,y,x*y);

    return 0;
}
```
---

#### 4. 30 students for a group.
Write a program that predicts how many whole sections of a batch would need to be created given the number of students enrolled in the batch. Assume that each section accommodates $30$ students. Prompt the user to enter the number of students enrolled. Echo print the number of students enrolled and then display both the number of sections that will be required and the number of students that will be left over.

**Input format:**
One nature number, for the number of the students, less than $10000$.

**Output format:**
One line of two integer numbers, for the number of sections and the number of students left over, separated by a space.
```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main(){
    int a,ys,bs;
    scanf("%d",&a);
    
    ys=a%30;
    bs=a/30;

    printf("%d %d",bs,ys);
    return 0;
}
```
#### 5. Developing toilets in city.
Metro City Planners proposes that a community conserve its water supply by replacing all the community’s toilets with low-flush models that use only $2$ liters per flush. Assume that there is about $1$ toilet for every $3$ persons, that existing toilets use an average of $15$ liters per flush, that a toilet is flushed on average $14$ times per day, and that the cost to install each new toilet is $150$-$yuan$.
Write a program that would estimate the magnitude (liters/day) and cost of the water saved based on the community’s population.

**Input format:**
One integer number for the population in the community.

**Output format:**
A whole number representing the magnitude (liters/day) and another whole number for the cost of the water saved.
```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main(){
    int jm,mt,daywater,total,save;
    scanf("%d",&jm);

    mt=jm/3;

    if(jm%3!=0){
        mt+=1;
    }

    daywater=mt*13;
    total=daywater*14;
    save=mt*150;

    printf("%d %d\n",total,save);
    return 0;
}
```
#### 6. Positive and nagetive numbers.
Count the number of integers greater than $zero$ and the number of integers less than $zero$ from the read integer data. Use inputting $zero$ to end the input. In the program, use the variable i to count the number of integers greater than $zero$, and use the variable j to count the number of integers less than $zero$.

**Input format:**
Input $n (n<20)$ integers separated by a single space in one line, and finally input $0$ to end the input. There is only one space between each piece of data.

**Output format:**
Output the results in two lines according to the formats "$i=$number of positive integers" and "$j=$number of negative integers" respectively. The counts are output as they are, with no column width control.
```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main(){
    int a;
    int i=0;
    int j=0;
    while(1){
        scanf("%d",&a);

        if(a==0){
            break;
        }
        
        if(a>0){
            i+=1;
        }

        if(a<0){
            j+=1;
        }
    }

    printf("i=%d,j=%d",i,j);
    return 0;
}
```
#### 7. Number of leading zeros in binary.
All values inside a computer are represented in binary. For example, the decimal number $24$ is expressed as $00000000000000000000000000011000$ in a $32$-bit computer. As you can see, there are $27$ zeros before the first $1$ when counting from the left. We call these zeros leading zeros.
Now, your task is to write a program that reads an integer and outputs the number of leading zeros in its $32$-bit binary representation.

**Input format:**
An integer within the range that can be represented by a $32$-bit integer.

**Output format:**
An integer representing the number of zeros before the first $1$ when the input is expressed as a $32$-bit binary number.
```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main(){
    int num;
    scanf("%d",&num);
    int leading_zeros=0;

    for(int i=31;i>=0;i--){
        int bit=(num>>i)&1;

        if(bit==0){
            leading_zeros++;
        }else{
            break;
        }

    }

    printf("%d",leading_zeros);
    return 0;
}
```
#### 8. Find the highest score among a group of students.
This problem requires you to write a program to find the maximum score.

**Input format:** 
A sequence of non-negative integers is given in a single line, separated by spaces. The input ends when a negative integer is read, and this integer should not be processed.

**Output format:** 
Output the maximum score in a single line.
```
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
int main()
{
    int a,b;
    b=-1;
    while(1){
        scanf("%d",&a);
        if(a<0){
            break;
        }
        if(a>b){
            b=a;
        }
    }
    printf("%d",b);
    return 0;
}
```
#### 9. The leading digit of a natural number (loop)
Write a function to find the leading digit of a natural number using an iterative method.
```
#include <stdio.h>

int TopDigit(int number);

int main()
{
    int n;
    scanf("%d", &n);
    printf("%d\n", TopDigit(n));
    return 0;
}

/* Your code will be embedded here */

int TopDigit(int number){
    int a=0;
    while(number!=0){
        a=number%10;
        number=number/10;
    }
    return a;
}
```
#### 10. Decompose an integer
The function of the following program is to separate each digit of a positive integer from the least significant digit to the most significant digit and output them in this order.
```
#include <stdio.h> 

int main() 
{ 
    int x;
    scanf("%d",&x);         
    while (1) {
        int d = x%10;          
        printf("%d\n",d);     
        x = x/10;                  
        if (x==0) {
            break;
        }
    }
}
```
#### 11. Calculate the average
The following program reads in a sequence of positive integers until a negative integer is encountered, which is not part of the valid data. The program calculates the average of these positive integers and outputs their total sum, count and average value. The total sum and count are printed as integers, while the average value is printed as a floating-point number with two decimal places reserved.
```
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main(){
    int sum=0;
    int cnt=0;
    
    while(1){
        int a;
        scanf("%d",&a);
        if(a>=0){
            sum+=a;
            cnt++;
        }else{
            break;
        }
    
    }
    float ave;
    ave=(float)sum/cnt;

    printf("%d %d %.2f\n",sum,cnt,ave);
    return 0;
}
```
#### 12. Sum of the digits of a natural number (loop)
Write a function to calculate the sum of the digits of a natural number.
```
#include <stdio.h>

int SumDigit(int number);

int main()
{
    int n;
    scanf("%d", &n);
    printf("%d\n", SumDigit(n));
    return 0;
}

/* Your code will be embedded here. */

int SumDigit(int number){
    int b=0;
    while(number>0){
            b+=number%10;
            number=number/10;
        }
    return b;
}
```
#### 13. $3n+1$
There is a conjecture: for any natural number $n$ greater than $1$, if $n$ is odd, change $n$ to $3n+1$.Otherwise, change $n$ to half of itself. After several such transformations, $n$ will definitely become $1$. For example, $3→10→5→16→8→4→2→1$. For the case where $n=1$, no transformation is needed of course.
```
#include <stdio.h>

int xxx(int n);

int main()
{
    int n,cnt=0;
    scanf("%d",&n);
    while(n!=1){
        n=xxx(n);
        cnt+=1;
    }
    printf("%d",cnt);
    return 0;
}

int xxx(int n){
    if(n%2==0){
        n=n/2;
    }else{
        n=3*n+1;
    }
    return n;
}
```
#### 14. Output the reversed number of an integer
For a given integer $N$, output its reversed number.
```
#include <stdio.h>
int main()
{
    int n;
    scanf("%d",&n);
    int g=0;
    int m;
    while(n!=0){
        m=n%10;
        g=g*10+m;
        n=n/10;
    }
    printf("%d",g);
    return 0;
}
```
#### 15. Jet fighter from a carrier
Write a program that calculates the acceleration ($m/s²$) of a jet fighter launched from an aircraft-carrier catapult, given the jet’s takeoff speed in $km/h$ and the distance (meters) over which the catapult accelerates the jet from rest to takeoff. Assume constant acceleration. Also calculate the time (seconds) for the fighter to be accelerated to takeoff speed. 

Relevant formulas ($v$ = velocity, $a$ = acceleration, $t$ = time, and $s$ = distance):
$v=at$;
$s=(1/2)at²$; 
```
#include <stdio.h>
int main()
{
    int x,s;
    double a,v,t;
    scanf("%d %d",&x,&s);
    v=x/3.6;
    t=2.0*s/v;
    a=1.0*v/t;
    printf("%.2f %.2f",a,t);
    return 0;
}
```
#### 16. Is it a multiple
Implement a function to determine whether an integer $a$ is a multiple of another integer $b$ (meaning there exists an integer $c$ such that $a==b∗c$).
```
#include <stdio.h>

int isMultipleOf ( int a, int b );

int main() {
  int a, b;
  scanf("%d%d", &a, &b);
  printf("%d\n", isMultipleOf(a, b));
  return 0;
}

/* Your code will be embedded here. */

int isMultipleOf (int a,int b){
    if(a==0&&b==0){
        return 1;
    }
    if(b==0){
        return 0;
    }
    if(b==1){
        return 1;
    }
    if(b==-1){
        return 1;
    }
    if(a%b==0){
        return 1;
    }
    if(a%b!=0){
        return 0;
    }
}
```
#### 17. Not telling you.
When you’re doing homework, the kid sitting next to you asks: “What’s five times seven?” You should smile politely and tell them: “Fifty-three.” This problem requires you to reverse and output the product of any given pair of positive integers.

**Input format:** 
Two positive integers $A$ and $B$ (each no more than $1000$) are given in the first line, separated by a space.

**Output format:** 
Reverse and output the product of $A$ and $B$ in a single line.
```
#include <stdio.h>
int main()
{
    int a,b;
    scanf("%d %d",&a,&b);
    int c=a*b;
    int r=0;
    while(c!=0){
        int d=c%10;
        r=r*10+d;
        c=c/10;
    }
    printf("%d",r);
    return 0;
}
```
#### 18. The trapped number
For any natural number $N$<sub>$0$</sub>​, first calculate the sum of its digits, then multiply the sum by $3$ and add $1$ to form a new natural number $N$<sub>$1$</sub>​. Then repeat this operation on $N$<sub>$1$</sub>​ to generate a new natural number $N$<sub>$2$</sub>​; … After repeating this operation multiple times, the result will eventually become a fixed number $N$<sub>$k$</sub>​, just like falling into a digital "trap".
This problem requires you to output the process of a given natural number falling into the "trap".

**Input format:** 
A natural number $N$<sub>$0$</sub>​ ($N$<sub>$0$</sub>​<30000) is given in a single line.

**Output format:** 
For the input $N$<sub>$0$</sub>​, output the steps of falling into the trap line by line. The $i$-$th$ line describes the $i$-$th$ step of the number falling into the trap in the format: $i$:$N$<sub>$i$</sub> ($i$≥1). Stop the output when the natural number result $N$<sub>$k$</sub>​ ($k$≥1) obtained in a certain step is the same as $N$<sub>$k$$−$$1$</sub>​ from the previous step.
```
#include <stdio.h>
int sss(int num){
    int sum=0;
    while(num>0){
        sum+=num%10;
        num/=10;
    }
    return sum;
}
int main()
{
    int n0;
    scanf("%d",&n0);
    int step=1;
    int now=n0;
    int next;
    while(1){
        int sum=sss(now);
        next=sum*3+1;
        printf("%d:%d\n",step,next);
        if(next==now){
            break;
        }
        now=next;
        step++;
    }
    return 0;
}
```
#### 19. Dividing a repunit
The so-called "repunit" here doesn't mean a single person at all—it refers to numbers consisting entirely of the digit 1, such as 1, 11, 111, 1111, and so on. It's said that every repunit is divisible by any odd number that does not end with 5. For example, 111111 is divisible by 13. Now, your program should read an integer x, which is definitely an odd number and does not end with 5. After calculation, output two numbers: the first number s, meaning that x multiplied by s equals a repunit; the second number n is the number of digits of this repunit. Such a solution is certainly not unique, and the problem requires you to output the smallest one.

**Note:** 
An obvious method is to gradually increase the number of digits of the repunit until it is divisible by x. The difficulty, however, is that s can be an extremely large number—for example, if the program inputs 31, it should output 3584229390681 and 15, because the product of 31 and 3584229390681 is 111111111111111, which has 15 ones in total.

**Input format:** 
A positive odd integer x (x < 1000) that does not end with 5 is given in a single line.

**Output format:** 
Output the corresponding smallest s and n in a single line, separated by one space.
```
#include<stdio.h>
int main()
{
    int x;
    scanf("%d",&x);
    int cnt=0;
    long long number=0;
    int st=0;
    while(1){
        number=number*10+1;
        cnt++;
    if(number>=x){
        if(!st){
            st=1;
        }
        printf("%lld",number/x);
        number=number%x;
    }else if(st){
        printf("0");
    }
    if(number==0){
        break;
    }
}
    printf(" %d\n",cnt);
    return 0;
}
```
#### 20. Taxi fare
Write a program that calculates taxi fare at a rate of 3.50-yuan per kilometer. Your program should read two odometer reading for the begin and end of the travel, then output the distance traveled and the fare to be charged.

**Input format:** 
Two real numbers in one line, representing the two odometer readings.

**Output format:** 
Two real numbers in one line, separated by one space, for distance and fare. The two numbers both have two decimal places.
```
#include <stdio.h>
int main(){
    double start,end;
    scanf("%lf %lf",&start,&end);
    double distance=end-start;
    double fare=distance*3.50;
    printf("%.2f %.2f\n",distance,fare);
    return 0;
}
```
#### 21. Search for a specified element in an array
This problem requires you to implement a simple function that searches for a specified element in an array.

**Note:** 
Among them, $list[]$ is the array passed in by the user; $n$ (n≥0) is the number of elements in $list[]$; $x$ is the element to be searched for. If the element is found, the function search returns the smallest index of the corresponding element (indices start from $0$); otherwise, it returns $-1$.
```
#include <stdio.h>
#define MAXN 10

int search( int list[], int n, int x );
    
int main()
{
    int i, index, n, x;
    int a[MAXN];

    scanf("%d", &n);
    for( i = 0; i < n; i++ )
        scanf("%d", &a[i]);
    scanf("%d", &x);
    index = search( a, n, x );
    if( index != -1 )
        printf("index = %d\n", index);
    else
        printf("Not found\n");
            
    return 0;
}

/* Your code will be embedded here. */

int search( int list[], int n, int x )
{
    for(int i=0;i<n;i++){
        if(list[i]==x){
            return i;
        }
    }
    return -1;
}
```
#### 22. Calculate the sum of prime numbers by using a function
This problem requires you to implement a simple function for judging prime numbers and a function for calculating the sum of prime numbers within a given interval using this function.

**Note:** 
A prime number is a positive integer that is divisible only by $1$ and itself. Note: $1$ is not a prime number, while $2$ is a prime number. 
The function prime returns $1$ if the parameter p passed in by the user is a prime number, and $0$ otherwise; the function PrimeSum returns the sum of all prime numbers in the interval $[m,n]$. The problem guarantees that the parameters passed in by the user satisfy $m≤n$.
```
#include <stdio.h>
#include <math.h>

int prime( int p );
int PrimeSum( int m, int n );
    
int main()
{
    int m, n, p;

    scanf("%d %d", &m, &n);
    printf("Sum of ( ");
    for( p=m; p<=n; p++ ) {
        if( prime(p) != 0 )
            printf("%d ", p);
    }
    printf(") = %d\n", PrimeSum(m, n));

    return 0;
}

/* Your code will be embedded here. */

int prime( int p ){
    if(p<2){
        return 0;
    }
    if(p==2){
        return 1;
    }
    for(int i=2;i<=sqrt(p);i++){
        if(p%i==0){
            return 0;
        }
    }
    return 1;
}
int PrimeSum( int m, int n ){
    int sum=0;
    for(int i = m;i <= n;i++){
        if(prime(i)){
            sum+=i;
        }
    }
    return sum;
}
```
#### 23. Output the area and perimeter of a triangle
This problem requires you to write a program that calculates and outputs the area and perimeter of a triangle based on the input three sides $a, b, c$ of the triangle. 

**Note:** 
In a triangle, the sum of any two sides must be greater than the third side. The formula for calculating the area of a triangle is: $area=$$\sqrt{s(s−a)(s−b)(s−c)}$​, where $s=(a+b+c)/2$.

**Input format:** 
The input consists of $3$ positive integers, representing the three sides $a, b, c$ of the triangle respectively.

**Output format:** 
If the input sides can form a triangle, output in a single line in the format: 
$area =$ area_value; $perimeter =$ perimeter_valueretaining two decimal places. 
Otherwise, output: 
These sides do not correspond to a valid triangle
```
#include <stdio.h>
#include <math.h>
int main()
{
    int a,b,c;
    scanf("%d %d %d",&a,&b,&c);
    if(a+b>c&&b+c>a&&a+c>b){
        double s=(a+b+c)*1.0/2;
        double area=sqrt(s*(s-a)*(s-b)*(s-c));
        double perimeter=a+b+c;
        printf("area = %.2f; perimeter = %.2f\n",area,perimeter);
    }else{
        printf("These sides do not correspond to a valid triangle");
    }
    return 0;
}
```
#### 24. Output leap years
Output all leap years from the start of the $21st$ century up to a given year. Note: The criteria for a leap year are that the year is divisible by $4$ but not by $100$, or divisible by $400$.

**Input format:** 
A cut-off year of the $21st$ century is given in a single line.

**Output format:** 
Output all qualifying leap years line by line, with each year on a separate line. If the input is not a year of the $21st$ century, output "Invalid year!". If there are no leap years that meet the criteria, output "None".
```
#include<stdio.h>
int main()
{
    int a;
    scanf("%d",&a);
    if(a<2001||a>2100){
        printf("Invalid year!");
    }else{
        int d=0;
        for(int c=2001;c<=a;c++)
{
            if(c%4==0&&c%100!=0||c%400==0){
                printf("%d\n",c);
                d=1;
            }
        }
        if(!d){
            printf("None\n");
        }
    }
    return 0;
}
```
#### 25. Euclid's GCD
Your program reads two integers and prints the greatest common divisor.
```
#include <stdio.h>
int main()
{
    int a, b;
    scanf("%d %d", &a, &b);
    while ( b!=0 ) {
        int r = a%b;
        a=b;
        b=r;
    }
    printf("%d\n",a);
}
```
#### 26. Height above average
Students in primary and secondary schools have a physical examination every semester, during which their height is measured, because height can reflect a child's growth status.
Now that the heights of a class have been measured, please output the heights that are above the average height.

The input data consists of two lines: the first line is an integer $N$, indicating the number of data points in the second line; the second line contains $N$ integers representing heights in centimeters.

The program shall output all height data of students that exceed the average height, in the same order as the input, with a space following each data point.

You are required to implement three functions:
(1) $print$: Traverse the array $a$ and print all data points greater than average, with a space following each data point. A new line shall be printed after all data points are output. The parameters are $a$ (the array containing data), $size$ (the number of data points in the array), and $average$ (the average value). The function returns the number of data points printed.
(2) $read$: Read data from the input. The parameters are $a$ (the array to which data is to be written) and $size$ (the number of data points to be read). The function returns the number of data points read (i.e., size).
(3) $average$: Calculate the average value of the array $a$. The parameters are $a$ (the array containing data) and $size$ (the number of data points in the array). The function returns the average value of the data in the array.
```
#include <stdio.h>

int read(int a[], int size);
double average(int a[], int size);
int print(int a[], int size, double average);

int main()
{
    int N;
    scanf("%d", &N);
    int a[N];
    int n = read(a, N);
    n = print(a, n, average(a,n));
    printf("%d\n", n);
}

int read(int a[], int size)
{
    for ( int i=0; i<size; i++ ) {
        scanf("%d", &a[i]);
    }
    return size;
}

double average(int a[], int size)
{
    double s = 0;
    for ( int i=0; i<size; i++ ) {
        s += a[i];
    }
    return s/size;
}

/* Your code will be embedded here. */

int print(int a[], int size, double average){
    int num=0;
    for(int i=0;i<size;i++){
        if(a[i]>average){
            printf("%d ",a[i]);
            num++;
        } 
    }
    printf("\n");
    return num;
}
```
#### 27. Index of the minimum value
Write a function to find the position (index) of the minimum value in the data. If there are multiple identical minimum values, take the position of the first occurrence of the minimum value.

The parameter $a$ is the data array to be searched, and size is the number of data elements in it. The function returns the index of the first minimum value.
The function $read$ is used to read data from the input. The parameter $a$ is the array to which data is to be written, and $size$ is the number of data elements to be read. The function returns the number of data elements read (i.e., size).
```c
#include <stdio.h>

int read(int a[], int size);
int min(int a[], int size);

int main()
{
    int N;
    scanf("%d", &N);
    int a[N];
    read(a, N);
    printf("%d\n", min(a,N));
}

int read(int a[], int size) 
{ 
    for ( int i=0; i<size; i++ ) { 
        scanf("%d", &a[i]); 
    } 
    return size; 
}

/* Your code will be embedded here. */

int min(int a[], int size)
{
    int k=0;
    for(int i=0;i<size;i++){
        if(a[i]<a[k]){
            k=i;
        }
    }
    return k;
}
```
#### 28. Delete Data
Write a delete function for array operations to delete a specific value from an array $a$ is the array to be processed, $size$ is the number of elements in the array, and $value$ is the data to be deleted.The function shall find all occurrences of value in a and delete them from the array.The function returns the number of elements deleted in this operation.

The $read$ function is used to read data from the input.Its parameters are $a$ (the array to which data is to be written) and $size$ (the number of data elements to be read).The function returns the number of elements read (i.e., size).
The $prt$ function prints the elements of an array.Its parameters are $a$ (the array to be printed) and $size$ (the number of elements in the array).The function returns the number of elements printed.
```c
#include <stdio.h>

int read(int a[], int size);
int prt(int a[], int size);
int delete(int a[], int size, int value);

int main()
{
    int N;
    scanf("%d", &N);
    int a[N];
    N = read(a, N);
    int D;
    scanf("%d", &D);
    int n = delete(a, N, D);
    prt(a, N-n);
}

int read(int a[], int size) 
{ 
    for ( int i=0; i<size; i++ ) { 
        scanf("%d", &a[i]); 
    } 
    return size; 
}

int prt(int a[], int size)
{
    for ( int i=0; i<size; i++ ) {
        printf("%d ", a[i]);
    }
    printf("\n");
    return size;
}

/* Your code will be embedded here. */

int delete(int a[], int size, int value){
    int number=0;
    for(int k=0;k<size;k++){
        if(a[k]==value){
            for(int l=k;l<size-1;l++){
                a[l]=a[l+1];
            }
            size--;
            k--;
            number++;
        }
    }
    return number;
}
```
#### 29. Approximate the sine function sin(x) by using a polynomial.
In mathematics, for some complex functions, polynomials are commonly used to approximate them. For example, the sine function $sin(x)$  can be approximately expressed by the following polynomial:

$sin(x)$≈$x$$-$$x^3$$/3!$$+$$x^5$$/5!$$-$$x^7$$/7!$$+$$···$+$(-1)^{n-1}$$x^{2n-1}$$/(2n-1)!$$+$$···$

In actual calculations, the computation can be terminated when the absolute value of the last term of the polynomial $(−1)^{n−1}x^{2n−1}/(2n−1)!$​ is less than a predetermined value $ε$ (e.g., $10^{−5}$ or $10^{−6}$), as this is deemed to meet the required calculation accuracy. Please write a function to calculate the value of the sine function at $x∈[0,π]$ according to the problem description.

**Programming Requirements:** 
Write two functions: one is $MySin(x)$ for calculating sinx, and the other is $fact(n)$ for calculating $n!$. The $MySin(x)$ function shall call the $fact(n)$ function. The term $x^n$ in the formula can be implemented using the library function $pow(x, n)$.

**Interface for the factorial function (calculating $n!$):**
```c
double fact ( int n );  
```
The parameter $n$ is an integer for which the factorial is to be calculated, and the function returns a value of type double.

**Interface for the sine function (calculating $sinx$):**
```c
double MySin(double x,double epsilon);
```
where $x$ is the independent variable of $sinx$, and $ϵ$ is the parameter specifying the required calculation accuracy.
```c
#include "stdio.h"
#include <math.h>

/* Your code will be embedded here. */

double fact ( int n ){
    double last=1.0;
    int i;
    for (i=1;i<=n;i++){
        last*=i;
    }
    return last;
}
double MySin(double x,double epsilon){
    int k;
    double sum=0.0,t=x;
    for (k=2;fabs(t)>=epsilon;k++){
        sum+=t;
        double fuhao=pow(-1,k-1);
        double fenzi=pow(x,2*k-1);
        double fenmu=fact(2*k-1);
        t=fuhao*fenzi/fenmu;
    }
    return sum;
} 

int main()
{
    double x,epsilon;
    scanf("%lf%lf",&x,&epsilon);
    printf("%.15f\n",MySin(x,epsilon));
    return 0;
}
```
#### 30. 666
Chinese people are very fond of the number $6$, as the phrase "$66$ dashun" (meaning everything goes smoothly) is always on everyone's lips. Li, a math fanatic, likes to digitize everything, so she even defined a magnitude for the word "smoothness": $6$ represents level $1$ smoothness, $66$ represents level $2$ smoothness, $666$ represents level $3$ smoothness, and so on. You see, the world of a math fanatic is always beyond understanding. Today, Li has decided to take math to the extreme. Now she defines $S$<sub>n</sub>​ as the sum of the first $n$ levels of smoothness.
$S$<sub>n</sub>$​=6+66+666+..​.$
Given the number n, can you help Li calculate $S$<sub>n</sub>​?

**Input Format:**
Enter a positive integer n, where n is in the range $[0, 10)$.

**Output Format:**
Output the value of $S$<sub>n</sub>​.
```c
#include<stdio.h>
int main()
{
	int n;
	scanf("%d",&n);
	long long number=0;
	long long sn=0;
	for(int i=0;i<n;i++){
		number=number*10+6;
		sn=sn+number;
	}
	printf("%d",sn);
	return 0;
}
```
#### 31. Upper Triangular Numeric Triangle
Enter a positive integer n, and output an upper triangular numeric triangle with n layers.

**Input Format:**
There is only one positive integer n, where 1≤n≤100.

**Output Format:**
An upper triangular numeric triangle, with each digit occupying four character positions.
```c
#include<stdio.h>
int main()
{
	int n;
	int s=1;
	scanf("%d",&n);
	for(int i=1;i<=n;i++){
		for(int a=1;a<=n-i+1;a++){
			printf("%4d",s);
			s++;	
		}
	    printf("\n");
	}
	return 0;
}
```
#### 32. All Lined up or Not
This problem requires you to write a program that stores the n input integers in an array $a$, and determines whether they are arranged in descending order.

**Input Format:**
In the first line, enter a positive integer $n (1 ≤ n ≤ 100)$. In the second line, enter $n$ integers separated by spaces. It is guaranteed that the data do not exceed the range of long integers.

**Output Format:**
If the $n$ integers are arranged in descending order, print "Yes" in one line; otherwise, print "No" in one line.
```c
#include<stdio.h>
int main()
{
    int n;
    scanf("%d",&n);
    int arr[n];
    for(int i=0;i<n;i++){
        scanf("%d",&arr[i]);
    }
    int x=0;
    int y=0;
    while(x<n-1){
        if(arr[x]<arr[x+1]){
            printf("No");
            y+=1;
            break;
        }
        x++;
    }
    if(y!=1){
        printf("Yes");
    }
    return 0;
}
```
#### 33. Find the Maximum Value and the Second Maximum Value in a Set of Numbers
Write a program to find the maximum value and the second maximum value in a one-dimensional array containing 10 elements.

**Input Format:**
Enter 10 integers separated by a single space in one line; there must be exactly one space between each pair of data.

**Output Format:**
Output the result in one line in the format of "max=maximum value, cmax=second maximum value". Both the maximum value and the second maximum value shall be output as they are, with no column width control.
```c
#include<stdio.h>
int main()
{
    int arr[10];
    for(int i=0;i<10;i++){
        scanf("%d",&arr[i]);
    }
    int max=arr[0];
    int cmax=arr[0];
    for(int i=1;i<10;i++){
        if(arr[i]>max){
            max=arr[i];
        }
    }
    for(int i=0;i<10;i++){
        if(arr[i]>cmax&&arr[i]<max){
            cmax=arr[i];
        }
    }
    printf("max=%d,cmax=%d",max,cmax);
    return 0;
}
```
#### 34. Split into Two Rows
A straight line during class can cause a lot of trouble. The physical education teacher's usual method is to have the students count off as 1 or 2, and then the students who count as 2 take a step back. Now, given the student numbers in the straight line, can you output the student numbers after they are split into two rows?

**Input Format:**
The first line contains a number n, representing the number of students in the class. The number of students is at least 1 and does not exceed 100. The second line contains n numbers, representing the student numbers in the straight line.

**Output Format:**
Please output the student numbers of the two rows after the split, separated by spaces. Each row of students occupies two lines, with the students who counted off as 1 in the first row.
```c
#include<stdio.h>
int main()
{
	int n;
	int arr[n];
	scanf("%d",&n);
	if(n==1){
		scanf("%d",&arr[n]);
		printf("%d\n",arr[n]);
		printf("\n");	
		}else{
			for(int i=0;i<n;i++){
				scanf("%d",&arr[i]);
			}
			if(n%2==0){
				for(int i=0;i<n;i+=2){
					printf("%d",arr[i]);
					if(i!=n-2){
						printf(" ");
					}
				}
				printf("\n");
				for(int i=1;i<n;i+=2){
					printf("%d",arr[i]);
					if(i!=n-1){
						printf(" ");
					}
				}
			}
			if(n%2!=0){
				for(int i=0;i<n;i+=2){
					printf("%d",arr[i]);
					if(i!=n-1){
						printf(" ");
					}
				}
				printf("\n");
				for(int i=1;i<n;i+=2){
					printf("%d",arr[i]);
					if(i!=n-2){
						printf(" ");
					}
				}
			}
		}
	return 0;
}
```
#### 35. Reverse the Storage Order of the First $n$ Elements of the Array
Store the $n$ integers in array $a$ in reverse order (the length of array $a$ is $20$, and $1<n<21$). First, store any $n$ integers in the first $n$ elements, then output the values of the $n$ elements as required.

**Input Format:**
Enter the value of $n$ in the first line, and enter $n$ integers in the second line.

**Output Format:**
Output $n$ integers in one line, with a comma after each integer.
```c
#include<stdio.h>
int main()
{
    int n;
    scanf("%d",&n);
    int arr[n];
    for(int i=0;i<n;i++){
        scanf("%d",&arr[i]);
    }
    int brr[n];
    printf("The array has been inverted:\n");
    for(int i=0;i<n;i++){
        brr[i]=arr[n-i-1];
        printf("%d",brr[i]);
        printf(",");
    }
    return 0;
}
```
#### 36. The Smallest Prime Number Greater Than $m$
Write a program to find the smallest prime number greater than $m$.

**Input Format:**
Enter a positive integer directly.

**Output Format:**
Output the result directly with no additional format control.
```c
#include <stdio.h>
#include <math.h>

int isPrime(int number) {
    if (number <= 1) {
        return 0;
    }
    if (number == 2) {
        return 1;
    }
    if (number % 2 == 0) {
        return 0;
    }
    for (int i = 3; i <= sqrt(number); i += 2) {
        if (number % i == 0) {
            return 0;
        }
    }
    return 1;
}

int main() {
    int m;
    scanf("%d", &m);

    int num = m + 1;
    while (1) {
        if (isPrime(num)) {
            printf("%d", num);
            break;
        }
        num++;
    }

    return 0;
}
```
#### 37. Calculate the Sum of the First $N$ Terms of an Alternating Sequence
This problem requires you to write a program to calculate the sum of the first N terms of the alternating sequence: $1−2/3​+3/5​−4/7​+5/9​−6/11​+...$

**Input Format:**
Enter a positive integer N in one line.

**Output Format:**
Output the value of the partial sum in one line, with the result rounded to three decimal places.
```c
#include<stdio.h>
int main()
{
    int N;
    scanf("%d",&N);
    double sum=0.00;
    for(int i=1;i<=N;i++){
        double fuhao=pow(-1,i+1);
        double fenzi=i;
        double fenmu=2*i-1;
        double num=fuhao*fenzi/fenmu;
        sum=sum+num;
    }
    printf("%.3f",sum);
    return 0;
}
```
#### 38. Find Perfect Numbers
A perfect number is a number that is exactly equal to the sum of its proper divisors (excluding itself). For example: $6 = 1 + 2 + 3$, where $1$, $2$, and $3$ are the proper divisors of $6$. This problem requires you to write a program to find all perfect numbers between any two positive integers $m$ and $n$.

**Input Format:**
Enter two positive integers $m$ and $n (1 < m ≤ n ≤ 10000)$ in one line, separated by a space.

**Output Format:**
Output the decomposition formula of each perfect number in the given range in the form of cumulative addition of its divisors, with each perfect number on a separate line. The format is "$perfect number = divisor$<sub>1</sub>$ + divisor$<sub>2</sub>$ + ... + divisor$<sub>k</sub>", where both the perfect number and its divisors are given in ascending order. If there are no perfect numbers in the interval, output "None".
```c
#include<stdio.h>
int main()
{
    int m,n;
    scanf("%d %d",&m,&n);
    int number=0;
    for(int a=m;a<=n;a++){
    	int sum=0;
    	for(int i=1;i<a;i++){
    		if(a%i==0){
    			sum+=i;
			}
		}
		if(sum==a){
			printf("%d = 1",a);
			for(int i=2;i<a;i++){
				if(a%i==0){
					printf(" + %d",i);
				}
			}
			printf("\n");
			number=1;
		}
	}
	if(number==0){
		printf("None");
	}
	return 0;
}
```
#### 39. Simplify a Fraction to the Simplest Form
A fraction can be expressed in the form of numerator/denominator. Write a program that requires the user to input a fraction and then reduces it to its lowest terms. A fraction in lowest terms means that the numerator and denominator have no common factors that can be cancelled out. For example, 6/12 can be reduced to 1/2. When the numerator is greater than the denominator, there is no need to express it as a mixed number (e.g., 11/8 remains 11/8); when the numerator is equal to the denominator, it should still be expressed as a fraction in the form of 1/1.

**Input Format:**
Enter a fraction in one line, with the numerator and denominator separated by a slash $/$ (e.g., $12/34$ represents twelve thirty-fourths). Both the numerator and denominator are positive integers ($0$ is not included; refer to the definition of positive integers if unclear).

**Note:**
For the C language: Add $/$ to the format string of scanf and let scanf handle this slash.
For the Python language: Use code like $a,b=map$(int, input().split('$/$')) to handle this slash.

**Output Format:**
Output the fraction in its lowest terms corresponding to the input in one line, in the same format as the input (i.e., express the fraction as numerator/denominator). For example, $5/6$ represents five sixths.
```c
#include <stdio.h>
int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int main() {
    int fenzi, fenmu;
    scanf("%d/%d", &fenzi, &fenmu);

    int maxgongyue = gcd(fenzi, fenmu);

    int simfenzi = fenzi / maxgongyue;
    int simfenmu = fenmu / maxgongyue;

    printf("%d/%d\n", simfenzi, simfenmu);

    return 0;
}
```
### Fundamentals of Data Structure Part
#### 1. Reverse a Singly Linked List (PTA)
This problem requires implementing a function to reverse the given singly linked list.
```c
#include <stdio.h>
#include <stdlib.h>

typedef int ElementType;
typedef struct Node *PtrToNode;
struct Node {
    ElementType Data;
    PtrToNode   Next;
};
typedef PtrToNode List;

List Read(); /* The details are omitted here. */
void Print( List L ); /* The details are omitted here. */

List Reverse( List L );

int main()
{
    List L1, L2;
    L1 = Read();
    L2 = Reverse(L1);
    Print(L1);
    Print(L2);
    return 0;
}

/* Your code will be embedded here. */

List Reverse( List L ){
    List p=L;
    List q=NULL;
    List temp;
    while(p!=NULL){
        temp=p->Next;
        p->Next=q;
        q=p;
        p=temp;
    }
    return q;
}
```
#### 2. Calculate the length of a linked list (PTA)
This problem requires implementing a function to calculate the length of a linked list.
```c
#include <stdio.h>
#include <stdlib.h>

typedef int ElementType;
typedef struct LNode *PtrToLNode;
struct LNode {
    ElementType Data;
    PtrToLNode Next;
};
typedef PtrToLNode List;

List Read(); /* The details are omitted here. */

int Length( List L );

int main()
{
    List L = Read();
    printf("%d\n", Length(L));
    return 0;
}

/* Your code will be embedded here. */

int Length( List L ){
    int len=0;
    List p=L;
    while(p!=NULL){
        p=p->Next;
        len++;
    }
    return len;
}
```
#### 3. Search a linked list by index (PTA)
This problem requires implementing a function to find and return the K-th element of a linked list.
```c
#include <stdio.h>
#include <stdlib.h>

#define ERROR -1
typedef int ElementType;
typedef struct LNode *PtrToLNode;
struct LNode {
    ElementType Data;
    PtrToLNode Next;
};
typedef PtrToLNode List;

List Read(); /* The details are omitted here. */

ElementType FindKth( List L, int K );

int main()
{
    int N, K;
    ElementType X;
    List L = Read();
    scanf("%d", &N);
    while ( N-- ) {
        scanf("%d", &K);
        X = FindKth(L, K);
        if ( X!= ERROR )
            printf("%d ", X);
        else
            printf("NA ");
    }
    return 0;
}

/* Your code will be embedded here */

ElementType FindKth( List L, int K ){
    if(L==NULL||K<=0){
        return ERROR;
    }
    List p=L;
    int i=0;
    while(p!=NULL&&i<K-1){
        p=p->Next;
        i++;
    }
    if(p==NULL){
        return ERROR;
    }
    ElementType x=p->Data;
    return x;
}
```
#### 4. Balloon Popping (PTA)
![](https://images.ptausercontent.com/6b53b1a2-7325-4de6-8dd5-bc403552b751.jpg)
Balloon popping is a fun game for kids.  Now $n$ balloons are positioned in a line. The goal of the game is very simple: to pop as many balloons as possible.  Here we add a special rule to this game -- that is, you can only make $ONE$ jump.  Assume that a smart baby covers his/her body by thorns（刺）, jumps to some position and lies down (as shown by the figures below), so that the balloons will be popped as soon as they are touched by any part of the baby's body.  Now it is your job to tell the baby at which position he/she must jump to pop the most number of balloons.
![](https://images.ptausercontent.com/8ac137cc-1253-42d6-ba2f-3da93df331bc.jpg)
![](https://images.ptausercontent.com/7a0b9adf-ee5a-45ed-81e3-4ad970784ff2.jpg)
**Input Specification:**
Each input file contains one test case. For each case, two positive integers are given in the first line: $n (≤$$10^5$), the number of balloons in a line, and $h (≤$$10^3)$, the height of the baby with his/her arms stretched up.  Then $n$ integers are given in the next line, each corresponds to the coordinate of a balloon on the axis of the line.  It is guaranteed that the coordinates are given in ascending order, and are all in the range $[−10^6,10^6]$.

**Output Specification:**
Output in a line the coordinate at which the baby shall jump, so that if the baby jumps at this position and then lie down, the maximum number of the balloons can be popped beneath his/her body.  Then also print the maximum number of balloons that can be popped.  If the coordinate is not unique, output the smallest one.

The numbers must be separated by $1$ space, and there must be no extra space at the beginning or the end of the line.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int main() {
	int n, h;
	scanf("%d %d", &n, &h);
	long long* b = (long long*)malloc(n * sizeof(long long));
	for (int i = 0; i < n; i++) {
		scanf("%lld", &b[i]);
	}
	int L = 0;
	int R = 0;
	long long Mpos = 0;
	int Mcnt = 0;
	while (R < n) {
		int cnt = 0;
		long long pos = 0;
		if (b[R] - b[L] > h) {
			L += 1;
		}
		else {
			cnt = R - L + 1;
			pos = b[R] - h;
			if (Mcnt < cnt) {
				Mcnt = cnt;
				Mpos = pos;
			}
			else if (Mcnt == cnt) {
				if (Mpos > pos) {
					Mpos = pos;
				}
			}
		}
		R += 1;
	}
	printf("%lld %d", Mpos, Mcnt);
	return 0;
}
```
#### 5. Add Two Polynomials (PTA)
Write a function to add two polynomials.  Do not destroy the input.  Use a linked list implementation with a dummy head node.

**Note:** 
The zero polynomial is represented by an empty list with only the dummy head node.

**Format of functions:**
```c
Polynomial Add( Polynomial a, Polynomial b );
```
where `Polynomial` is defined as the following:
```c
typedef struct Node *PtrToNode;
struct Node {
    int Coefficient;
    int Exponent;
    PtrToNode Next;
};
typedef PtrToNode Polynomial;
/* Nodes are sorted in decreasing order of exponents.*/  
```
The function `Add` is supposed to return a polynomial which is the sum of `a` and `b`.

**Sample program of judge:**
```c
#include <stdio.h>
#include <stdlib.h>
typedef struct Node *PtrToNode;
struct Node  {
    int Coefficient;
    int Exponent;
    PtrToNode Next;
};
typedef PtrToNode Polynomial;

Polynomial Read(); /* details omitted */
void Print( Polynomial p ); /* details omitted */
Polynomial Add( Polynomial a, Polynomial b );

int main()
{
    Polynomial a, b, s;
    a = Read();
    b = Read();
    s = Add(a, b);
    Print(s);
    return 0;
}

/* Your function will be put here */
```

**Sample Input:**
```
4
3 4 -5 2 6 1 -2 0
3
5 20 -7 4 3 1
```

**Sample Output:**
```
5 20 -4 4 -5 2 9 1 -2 0
```
**Answer:**
```c
Polynomial Add(Polynomial a, Polynomial b) {
    Polynomial p = a;
    Polynomial q = b;
    Polynomial real = (Polynomial)malloc(sizeof(struct Node));
    Polynomial tail = real;
    while (p != NULL && q != NULL) {
        if (p->Exponent > q->Exponent) {
            Polynomial node = (Polynomial)malloc(sizeof(struct Node));
            node->Coefficient = p->Coefficient;
            node->Exponent = p->Exponent;
            node->Next = NULL;
            tail->Next = node;
            tail = node;
            p = p->Next;
        }
        else if (p->Exponent < q->Exponent) {
            Polynomial node = (Polynomial)malloc(sizeof(struct Node));
            node->Coefficient = q->Coefficient;
            node->Exponent = q->Exponent;
            node->Next = NULL;
            tail->Next = node;
            tail = node;
            q = q->Next;
        }
        else {
            int sum = p->Coefficient + q->Coefficient;
            if (sum != 0) {
                Polynomial node = (Polynomial)malloc(sizeof(struct Node));
                node->Coefficient = sum;
                node->Exponent = p->Exponent;
                node->Next = NULL;
                tail->Next = node;
                tail = node;
            }
            p = p->Next;
            q = q->Next;
        }
    }
    while (p != NULL) {
        Polynomial node_ = (Polynomial)malloc(sizeof(struct Node));
        node_->Coefficient = p->Coefficient;
        node_->Exponent = p->Exponent;
        node_->Next = NULL;
        tail->Next = node_;
        tail = node_;
        p = p->Next;
    }
    while (q != NULL) {
        Polynomial node__ = (Polynomial)malloc(sizeof(struct Node));
        node__->Coefficient = q->Coefficient;
        node__->Exponent = q->Exponent;
        node__->Next = NULL;
        tail->Next = node__;
        tail = node__;
        q = q->Next;
    }
    return real;
}
```
#### 6. Reverse Linked List (PTA)
Write a nonrecursive procedure to reverse a singly linked list in $O(N)$ time using constant extra space.

**Format of functions:**
```c
List Reverse( List L );
```
where `List` is defined as the following:
```c
typedef struct Node *PtrToNode;
typedef PtrToNode List;
typedef PtrToNode Position;
struct Node {
    ElementType Element;
    Position Next;
};
```
The function `Reverse` is supposed to return the reverse linked list of `L`, with a dummy header.
```c
#include <stdio.h>
#include <stdlib.h>

typedef int ElementType;
typedef struct Node *PtrToNode;
typedef PtrToNode List;
typedef PtrToNode Position;
struct Node {
    ElementType Element;
    Position Next;
};

List Read(); /* details omitted */
void Print( List L ); /* details omitted */
List Reverse( List L );

int main()
{
    List L1, L2;
    L1 = Read();
    L2 = Reverse(L1);
    Print(L1);
    Print(L2);
    return 0;
}

/* Your function will be put here */
```
**Sample Input:**
```
5
1 3 4 5 2
```
**Sample Output:**
```
2 5 4 3 1
2 5 4 3 1
```
**Answer:**
```c
List Reverse(List L) {
    List p = L->Next;
    List q = NULL;
    List temp;
    while (p != NULL) {
        temp = p->Next;
        p->Next = q;
        q = p;
        p = temp;
    }
    L->Next = q;
    return L;
}
```
#### 7. Queue Using Two Stacks (PTA)
A queue (FIFO structure) can be implemented by two stacks (LIFO structure) in the following way:
- Start from two empty stacks $s_1$ and $s_2$.
- When element $e$ is enqueued, it is actually pushed onto $s_1$.
- When we are supposed to dequeue, $s_2$ is checked first. If $s_2$ is empty, everything in $s_1$ will be transferred to $s_2$ by popping from $s_1$ and immediately pushing onto $s_2$ . Then we just pop from $s_2$ —— the top element of $s_2$ must be the first one to enter $s_1$ thus is the first element that was enqueued.

Assume that each operation of push or pop takes $1$ unit of time.  You job is to tell the time taken for each dequeue.

**Input Specification:**
Each input file contains one test case. For each case, the first line gives a positive integer $(N \le 10^3)$, which are the number of operations. Then $N$ lines follow, each gives an operation in the format
`Operation Element`
where `Operation` being `I` represents enqueue and `O` represents dequeue.  For each `I`, Element is a positive integer that is no more than $10^6$. No Element is given for `O` operations.
It is guaranteed that there is at least one `O` operation.

**Output Specification:**
For each dequeue operation, print in a line the dequeued element and the unites of time taken to do this dequeue.  The numbers in a line must be separated by $1$ space, and there must be no extra space at the beginning or the end of the line.
In case that the queue is empty when dequeue is called, output in a line `ERROR` instead.

**Sample Input:**
```
10
I 20
I 32
O
I 11
O
O
O
I 100
I 66
O
```

**Sample Output:**
```
20 5
32 1
11 3
ERROR
100 5
```

**Answer:**
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>

int main() {
	int N;
	scanf("%d", &N);
	int i = 0;
	int flag_el = 0;
	int front = 0;
	int end = 0;
	int* a = (int*)malloc(N * sizeof(int));
	int* b = (int*)malloc(N * sizeof(int));
	while (i < N) {
		char c[2];
		scanf("%s", c);
		int num;
		if (c[0] == 'I') {
			scanf("%d", &num);
			a[front++] = num;
		}
		else {
			int time = 0;
			if (end == 0) {
				while (front > 0) {
					front--;
					time++;
					b[end++] = a[front];
					time++;
				}
			}
			if (end > 0) {
				end--;
				int num = b[end];
				time++;
				printf("%d %d\n", num, time);
			}
			else {
				printf("ERROR\n");
			}
		}
		i++;
	}
	free(a);
	free(b);
	return 0;
}
```
---

### Fundamentals of Data Structure Projects
#### 1. Normal-1 Performance Measurement (Search)
Given a list of ordered $N$ integers, numbered from $0$ to $N−1$, checking to see that $N$ is not in this list provides a worst case for many search algorithms.

Consider two algorithms: one is called “sequential search” which scans through the list from left to right; and the other is “binary search” which is introduced in your textbook.  Your tasks are:

- Implement an iterative version and a recursive version of binary search, together with an iterative version and a recursive version of sequential search;
- Analyze the worst case complexities of the above four versions of searching methods;
- Measure and compare the worst case performances of the above four functions for $N = 100, 500, 1000, 2000, 4000, 6000, 8000, 10000$.

To measure the performance of a function, we may use C's standard library `time.h` as the following:

![alt text](./public/image.png)

**Note:** 
If a function runs so quickly that it takes less than a tick to finish, we may repeat the function calls for $K$ times to obtain a total run time, and then divide the total time by $K$ to obtain a more accurate duration for a single run of the function.  The repetition factor must be large enough so that the number of elapsed ticks is at least $10$ if we want an accuracy of at least $10$%.

The test results must be listed in the following table:

![alt text](./public/image-1.png)

The performances of the four functions must be plotted in the same $N$–run_time coordinate system for illustration.

**Grading Policy:**
- Programmer: Implement the four functions ($30$ pts.) and a testing program ($20$ pts.) with sufficient comments.

- Tester: Decide the iteration number $K$ for each test case and fill in the table of results ($8$ pts.).  Plot the run times of the functions ($12$ pts.).  Write analysis and comments ($10$ pts.).

- Report Writer: Write Chapter $1$ ($6$ pts.), Chapter $2$ ($12$ pts.), and finally a complete report ($2$ pts. for overall style of documentation).

**Code:**
```c
#include<stdio.h>
#include<math.h>
#include<time.h>
#include<stdlib.h>

/*设置栈大小为16MB*/
#pragma comment(linker, "/STACK:33554432")

typedef int ElemType;

/*顺序查找迭代版*/
int Sequential_Search_Iterative_(int a[], int n, int element) {
    /*从第一个元素开始遍历，如果找到，返回下标 + 1，并退出改函数*/
    for (int i = 0; i < n; i++) {
        if (a[i] == element) {
            return i + 1;
        }
    }
    /*如果没有找到，返回 - 1*/
    return -1;
}

/*顺序查找递归版*/
int Sequential_Search_Recursive(int a[], int n, int element, int index) {
    /*如果当前下标已经超过了数组长度，说明没有查找到所求元素，返回-1*/
    if (index >= n) {
        return -1;
    }
    /*如果找到了所需元素，返回下标+1*/
    if (a[index] == element) {
        return index + 1;
    }
    /*如果暂时未找到所需元素，则下标 + 1，继续查找*/
    return Sequential_Search_Recursive(a, n, element, index + 1);
}


/*二分查找迭代版*/
int Binary_Search_Iterative_(int a[], int n, int element) {
    //定义左、右边界*/
    int left = 0;
    int right = n - 1;
    /*将当前数组分成两个区间，取得中间坐标，减半查找*/
    while (left <= right) {
        int mid = (left + right) / 2;
        /*当前数组中间下标对应元素即为所需元素，返回下标 + 1，退出*/
        if (element == a[mid]) {
            return mid + 1;
        }
        /*所需元素在当前数组的右半区间*/
        else if (a[mid] < element) {
            left = mid + 1;
        }
        /*所需元素在当前数组的左半区间*/
        else {
            right = mid - 1;
        }
    }
    /*循环结束仍未找到，说明该、所需元素不在该数组内，返回-1*/
    return -1;
}

/*二分查找递归版*/
int Binary_Search_Recursive(int a[], int left, int right, int element) {
    /*检查边界条件是否满足，不满足返回-1*/
    if (left > right) {
        return -1;
    }
    /*将当前数组分半，取得中间坐标，折半查找*/
    int mid = (left + right) / 2;
    /*如果中间坐标对应元素即为所求，返回下标+1，退出该函数*/
    if (a[mid] == element) {
        return mid + 1;
    }
    /*如果所求元素大于当前数组中间下标值所对应的元素，说明所求元素在右半区间*/
    else if (a[mid] < element) {
        return Binary_Search_Recursive(a, mid + 1, right, element);
    }
    /*如果所求元素小于当前数组中间下标值所对应的元素，说明所求元素在左半区间*/
    else {
        return Binary_Search_Recursive(a, left, mid - 1, element);
    }
}

/*对两个递归版函数进行封装,统一接口更好地测量时间*/
int Sequential_Search_Recursive_(int a[], int n, int element) {
    return Sequential_Search_Recursive(a, n, element, 0);
}

int Binary_Search_Recursive_(int a[], int n, int element) {
    return Binary_Search_Recursive(a, 0, n - 1, element);
}
/*测试用例结构体：包含算法名称、函数指针、储存测量结果的数组*/
typedef struct {
    const char* name;     /*算法名称*/
    int (*fun)(int[], int, int);     /*函数指针*/
    double* results;     /*储存测量结果的数组*/
}test;

/*测量结果结构体：包含单次执行时间、循环次数K、时钟滴答数*/
typedef struct {
    double duration;     /*单次执行时间*/
    int K;     /*循环次数K*/
    long ticks;     /*时钟滴答数*/
}Measurement;

Measurement Measure(int (*fun)(int[], int, int), int a[], int n, int element) {
    int K = 1;
    clock_t begin;
    clock_t end;
    double ticks;
    const int target = 20;     /*目标时钟滴答数，用于确定合适的K*/
    do {
        K *= 2;
        begin = clock();
        for (int i = 0; i < K; i++) {
            fun(a, n, element);
        }
        end = clock();
        ticks = (double)(end - begin);
    } while (ticks < target && K < 100000000);     /*防止无限循环*/

    int dummy = 0;     /*用于累加返回值*/
    begin = clock();
    for (int i = 0; i < K; i++) {
        dummy += fun(a, n, element);     /*累加返回值*/
    }
    end = clock();
    long ticks_ = end - begin;     /*实际测量的总时钟滴答数*/
    double second = (double)(end - begin) / CLOCKS_PER_SEC;     /*转换为秒*/
    Measurement Data;
    Data.duration = second / K;     /*平均每次执行时间*/
    Data.K = K;
    Data.ticks = ticks_;
    return Data;
}

int main() {
    /*待测试的数组大小列表*/
    int N_element[] = { 100,500,1000,2000,4000,6000,8000,10000 };
    int N_number = sizeof(N_element) / (sizeof(N_element[0]));

    /*为四种算法分别分配存储时间的数组*/
    double* TimeSeqIter = (double*)malloc(N_number * sizeof(double));
    double* TimeSeqRecur = (double*)malloc(N_number * sizeof(double));
    double* TimeBinIter = (double*)malloc(N_number * sizeof(double));
    double* TimeBinRecur = (double*)malloc(N_number * sizeof(double));

    /*定义四种测试，每个包含名称、函数指针和对应的时间存储数组*/
    test tests[4] = {
        {"SeqIter",Sequential_Search_Iterative_,TimeSeqIter},
        {"SeqRecur",Sequential_Search_Recursive_,TimeSeqRecur},
        {"BinIter",Binary_Search_Iterative_,TimeBinIter},
        {"BinRecur",Binary_Search_Recursive_,TimeBinRecur}
    };

    /*对每个数组大小进行测试*/
    for (int i = 0; i < N_number; i++) {
        int N = N_element[i];
        int* a = (int*)malloc(N * sizeof(int));
        if (a == NULL) {
            return 1;     /*内存分配失败，退出*/
        }
        /*初始化数组为0,1,2,...,N-1，确保有序，便于二分查找*/
        for (int j = 0; j < N; j++) {
            a[j] = j;
        }
        int value = N;     /*查找一个不存在的元素（值为N），以模拟最坏情况（查找失败）*/
        printf("数组大小 N = %d:\n", N);
        /*对四种算法分别进行测量*/
        for (int k = 0; k < 4; k++) {
            Measurement Value = Measure(tests[k].fun, a, N, value);
            tests[k].results[i] = Value.duration;     /*保存平均时间*/
            printf("  %s: duration=%.10f sec  (K=%d, ticks=%ld, total=%.6f sec)\n", tests[k].name, Value.duration, Value.K, Value.ticks, (double)Value.ticks / CLOCKS_PER_SEC);
        }
        free(a);     /*释放当前数组*/
    }

    /*释放动态分配的内存*/
    free(TimeBinIter);
    free(TimeBinRecur);
    free(TimeSeqIter);
    free(TimeSeqRecur);
    return 0;
}
```
---

### Video GalGames
#### 1. Robber
Afu is an experienced master thief. Under the cover of darkness on a moonless night, he plans to rob the shops on a street tonight.There are a total of $N$ shops on this street, and each shop contains some cash.
Afu has learned from his prior investigation that the street's alarm system will only be triggered if he robs two adjacent shops at the same time, after which the police will swarm in immediately.

**Note:**
As a thief who always commits crimes cautiously, Afu is unwilling to steal at the risk of being chased by the police. He wants to know the maximum amount of cash he can get tonight without alerting the police.

**Input Format:**
The first line of input is an integer $T$, indicating the total number of test cases. For each subsequent test case:
The first line contains an integer $N$, representing the number of shops.
The second line contains $N$ positive integers separated by spaces, denoting the amount of cash in each shop. The cash amount in each shop does not exceed $1000$.

**Output Format:**
For each test case, output one line containing an integer, which is the maximum amount of cash Afu can obtain without alerting the police.
```c
/*From Doubao*/

#include <stdio.h>
#include <stdlib.h>

// Calculate the maximum amount for each test case
int maxMoney(int* money, int n) {
    if (n == 0) return 0;
    if (n == 1) return money[0];
    
    int prev = money[0];
    int curr = (money[0] > money[1]) ? money[0] : money[1];
    
    for (int i = 2; i < n; i++) {
        int temp = curr;
        curr = (curr > prev + money[i]) ? curr : prev + money[i];
        prev = temp;
    }
    return curr;
}

int main() {
    int T;
    scanf("%d", &T);
    
    while (T--) {
        int N;
        scanf("%d", &N);
        
        // Dynamically allocate an array to store the cash of each shop
        int* money = (int*)malloc(N * sizeof(int));
        if (money == NULL) {
            printf("Memory allocation failed.\n");
            return 1;
        }
        
        for (int i = 0; i < N; i++) {
            scanf("%d", &money[i]);
        }
        
        // Calculate the final result
        printf("%d\n", maxMoney(money, N));
        
        // Free memory
        free(money);
    }
    return 0;
}
```
#### 2. Laying Carpets
To prepare a unique awards ceremony, the organizers lay several rectangular carpets on a rectangular area of the venue (regarded as the first quadrant of the plane Cartesian coordinate system). There are $n$ carpets, numbered from $1$ to $n$. These carpets are laid, in increasing order of their indices, axis-parallel; a later carpet is placed on top of those already laid.

After all carpets have been laid, the organizers want to know the index of the topmost carpet that covers a given point on the floor. Note: points on the boundary and at the four vertices of a rectangular carpet are also considered covered.

**Input Format:**
The input contains $n+2$ lines.

The first line contains an integer $n$, indicating that there are $n$ carpets in total.

Each of the next n lines, the $(i+1)-th$ line, describes carpet i with four integers $a,b,g,k$, separated by single spaces, representing the coordinates of the lower-left corner $(a,b)$ and the lengths of the carpet in the $x$- and $y$-directions, respectively.

The $(n+2)-th$ line contains two integers $x$ and $y$, representing the coordinates $(x,y)$ of the query point.

**Output Format:**
Output a single line containing one integer, the index of the required carpet; if the point is not covered by any carpet, output $-1$.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#define MAXN 100000

struct clo {
	int x;
	int y;
	int length;
	int hight;
};

typedef struct clo C;

int main() {
	int n;
	scanf("%d", &n);
	C* tan = (C*)malloc(n * sizeof(C));
	for (int i = 0; i < n; i++) {
		scanf("%d %d %d %d", &tan[i].x, &tan[i].y, &tan[i].length, &tan[i].hight);
	}

	int x_, y_;
	scanf("%d %d", &x_, &y_);
	int last = -1;
	for (int k = n - 1; k >= 0; k--) {
		if (x_ >= tan[k].x && x_ <= tan[k].x + tan[k].length && y_ >= tan[k].y && y_ <= tan[k].y + tan[k].hight) {
			last = k + 1;
			break;
		}
	}
	
	printf("%d", last);
	
	
	return 0;
}
```
#### 3. River-Crossing Pawn
On a chessboard, there is a river-crossing pawn at point $A$ that needs to reach the target point $B$. The pawn moves according to the rules: it may move either downward or rightward. There is also an opposing knight at point $C$ on the board; the knight’s own square and all squares reachable by a single knight move are called the knight’s controlled squares. Therefore, this is called “the knight blocks the river-crossing pawn.”

The board is represented using coordinates: point $A$ is at $(0, 0)$, point $B$ is at $(n, m)$, and the knight’s position is also given.

![](https://cdn.luogu.com.cn/upload/image_hosting/ipmwl52i.png)

You are to compute the number of distinct paths by which the pawn can travel from point $A$ to point $B$, assuming the knight’s position is fixed and does not move in response to the pawn’s moves.

**Input Format:**
One line contains four integers, representing the coordinates of point $B$ and the coordinates of the knight, in order: $n$, $m$, $x$, $y$.

**Output Format:**
Output a single integer, the total number of valid paths.

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>

int m, n;

void horse(int** bl, int x, int y) {
    if (x <= n && x >= 0 && y <= m && y >= 0) {
        bl[x][y] = 1;
    }
}

int main() {
    int a, b, c, d;
    scanf("%d %d %d %d", &a, &b, &c, &d);
    n = a;
    m = b;
    long long** pawn = (long long**)malloc((n + 1) * sizeof(long long*));
    int** bl = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        pawn[i] = (long long*)malloc((m + 1) * sizeof(long long));
        bl[i] = (int*)malloc((m + 1) * sizeof(int));
        for (int j = 0; j <= m; j++) {
            pawn[i][j] = 0;
            bl[i][j] = 0;
        }
    }

    horse(bl, c, d);
    horse(bl, c + 2, d + 1);
    horse(bl, c + 1, d + 2);
    horse(bl, c + 1, d - 2);
    horse(bl, c + 2, d - 1);
    horse(bl, c - 2, d + 1);
    horse(bl, c - 2, d - 1);
    horse(bl, c - 1, d + 2);
    horse(bl, c - 1, d - 2);

    if (bl[0][0] == 1) {
        printf("0\n");
        return 0;
    }
    else {
        pawn[0][0]=1;
    }
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            if (i == 0 && j == 0) {
                continue;
            }
            if (bl[i][j] == 1) {
                pawn[i][j] = 0;
                continue;
            }
            if (i > 0 && bl[i - 1][j] == 0) {
                pawn[i][j] += pawn[i - 1][j];
            }
            if (j > 0 && bl[i][j - 1] == 0) {
                pawn[i][j] += pawn[i][j - 1];
            }
        }
    }
    printf("%lld", pawn[n][m]);
    return 0;
}
```
#### 4. Station
A train departs from the origin (called station $1$). At the origin, $a$ people board. It then arrives at station $2$; at station $2$ some people board and alight, but the numbers boarding and alighting are equal, so when departing station $2$ (i.e., before arriving at station $3$), there remain $a$ people on the train. From station $3$ onward (including station $3$), the numbers boarding and alighting follow a rule: the number boarding at each station equals the sum of the numbers who boarded at the previous two stations, and the number alighting equals the number who boarded at the previous station. This holds through the penultimate station, station $n-1$. You are given that there are $n$ stations in total, $a$ people board at the origin, and at the last station the number of people alighting is $m$ (everyone gets off). Find the number of people on the train when departing station $x$.

**Input Format:**
A single line containing four integers: the number of people boarding at the origin $a$, the number of stations $n$, the number of people alighting at the terminal station $m$, and the station index to query $x$.

**Output Format:**
Output a single integer: the number of people on the train when departing station $x$.
```c
#define _CRT_SECURE_NO_WARNINGS

int second;


int geton(int n, int a) {
    if (n == 1) {
        return a;
    }
    if (n == 2) {
        return second;
    }
    return geton(n - 1, a) + geton(n - 2, a);
}

int getoff(int n, int a) {
    if (n == 1) {
        return 0;
    }
    if (n == 2) {
        return second;
    }
    return getoff(n - 1, a);
}

int retain(int sta, int a) {
    if (sta == 1 || sta == 2) {
        return a;
    }
    int t = second;
    int geton_ = 0;
    int getoff_ = 0;
    int reta = a;
    for (int i = 2; i <= sta; i++) {
        int on = (i == 1) ? a : ((i == 2) ? t : (geton(i - 1,a) + geton(i - 2,a)));
        int off = (i == 1) ? 0 : ((i == 2) ? t : geton(i - 1,a));
        reta = reta + on - off;
    }

    return reta;
}

#include<stdio.h>
int main() {
    int a;
    scanf("%d", &a);
    int n;
    scanf("%d", &n);
    int m;
    scanf("%d", &m);
    int x;
    scanf("%d", &x);
    if (x == 1 || x == 2) {
        printf("%d", a);
        return 0;
    }
    if (x == n) {
        printf("0");
        return 0;
    }
    int found = 0;
    int result_t = 0;

    for (second = -1000; second <= 1000; second++) {
        int people_n_minus_1 = retain(n-1, a);
        if (people_n_minus_1 == m) {
            found = 1;
            result_t = second;
            break;
        }
    }
    second = result_t;
    int people = retain(x, a);
    printf("%d", people);
    return 0;
}
```
#### 5. Who Got the Most Scholarship Money
It is customary at this school to award scholarships after each semester’s final exams. There are five types of scholarships, each with different requirements:

1. Academician Scholarship: $8000$ yuan per person. Students whose final average score is greater than $80$ ($>80$) and who have published $1$ or more papers during this semester are eligible.
2. May Fourth Scholarship: $4000$ yuan per person. Students whose final average score is greater than $85$ ($>85$) and whose class evaluation score is greater than $80$ ($>80$) are eligible.
3. Outstanding Performance Award: $2000$ yuan per person. Students whose final average score is greater than $90$ ($>90$) are eligible.
4. Western Scholarship: $1000$ yuan per person. Students from western provinces whose final average score is greater than $85$ ($>85$) are eligible.
5. Class Contribution Award: $850$ yuan per person. Student cadres whose class evaluation score is greater than $80$ ($>80$) are eligible.

As long as the conditions are met, the scholarship will be awarded. There is no limit on the number of recipients for each scholarship, and each student may receive multiple scholarships simultaneously. For example, if Yao Lin’s final average score is $87$ and the class evaluation score is $82$, and he is also a student cadre, then he can receive both the May Fourth Scholarship and the Class Contribution Award, for a total of $4850$ yuan.

Now, given data for several students, calculate which student(s) received the highest total amount of scholarship money (assume there is always at least one student who meets some scholarship condition).

**Input Format:**
The first line contains $1$ integer $N$, the total number of students.

Each of the following $N$ lines contains one student’s data, in order: name, final average score, class evaluation score, whether the student is a student cadre, whether the student is from a western province, and the number of published papers. The name is a string of uppercase and lowercase English letters with length at most $20$ (no spaces). The final average score and the class evaluation score are integers between $0$ and $100$ (inclusive). Whether the student is a student cadre and whether the student is from a western province are each represented by $1$ character: $\tt Y$ means yes, and $\tt N$ means no. The number of published papers is an integer between $0$ and $10$ (inclusive). Each pair of adjacent data items is separated by a single space.

**Output Format:**
Output $3$ lines.

Line $1$: the name of the student who received the most scholarship money. If two or more students tie for the most, output the one who appears earliest in the input.

Line $2$: the total amount of scholarship money this student received.

Line $3$: the total amount of scholarship money received by all $N$ students.

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdlib.h>
#include<string.h>
#include<string.h>
#include<stdio.h>

struct student {
	char name[20];
	int endterm;
	int classcom;
	char greatstu;
	char weststu;
	int article;
	int prize;
};

typedef struct student Stu;

int main() {
	int N;
	scanf("%d", &N);
	Stu* stu = (Stu*)malloc(N * sizeof(Stu));

	if (stu == NULL) {
		return 1;
	}
	for (int i = 0; i < N; i++) {
		scanf(" %s %d %d %c %c %d",
			stu[i].name,
			&stu[i].endterm,
			&stu[i].classcom,
			&stu[i].greatstu,
			&stu[i].weststu,
			&stu[i].article);
	}
	for (int i = 0; i < N; i++) {
		stu[i].prize = 0;
	}
	for (int i = 0; i < N; i++) {
		if (stu[i].endterm > 80&&stu[i].article>=1) {
			stu[i].prize += 8000;
		}
		if (stu[i].endterm > 85 && stu[i].classcom > 80) {
			stu[i].prize += 4000;
		}
		if (stu[i].endterm > 90) {
			stu[i].prize += 2000;
		}
		if (stu[i].endterm > 85 && stu[i].weststu == 'Y') {
			stu[i].prize += 1000;
		}
		if (stu[i].classcom > 80 && stu[i].greatstu == 'Y') {
			stu[i].prize += 850;
		}
	}
	int max = 0;
	int index = 0;
	int sum = 0;
	for (int i = 0; i < N; i++) {
		if (stu[i].prize > max) {
			max = stu[i].prize;
			index = i;
		}
		sum += stu[i].prize;
	}
	printf("%s\n", stu[index].name);
	printf("%d\n", max);
	printf("%d\n", sum);

	free(stu);
	return 0;
}
```
#### 6. Birthday
cjf wants to collect the birthdays of every student in the school OI group and sort them by age in descending order (older first). However, cjf has a lot of homework recently and has no time, so please help her sort them.

**Input Format:**
The input contains $n + 1$ lines.

The first line contains the total number $n$ of people in the OI group.

Lines $2$ to $n + 1$ each contain one person's name $s$, birth year $y$, month $m$, and day $d$.

**Output Format:**
Output $n$ lines.

Print the names of the students in descending order of age. (If two students share the same birthday, print the one that appears later in the input first.)

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
struct student {
	char name[20];
	int year;
	int month;
	int date;
};

typedef struct student Stu;

void old(Stu* stu, int n) {
	for (int i = 0; i < n - 1; i++) {
		for (int j = 0; j < n - i - 1; j++) {
			if (stu[j].year < stu[j + 1].year) {
				Stu temp = stu[j];
				stu[j] = stu[j + 1];
				stu[j + 1] = temp;
			}
			if (stu[j].year == stu[j + 1].year && stu[j].month < stu[j + 1].month) {
				Stu temp = stu[j];
				stu[j] = stu[j + 1];
				stu[j + 1] = temp;
			}
			if (stu[j].year == stu[j + 1].year && stu[j].month == stu[j + 1].month && stu[j].date < stu[j + 1].date) {
				Stu temp = stu[j];
				stu[j] = stu[j + 1];
				stu[j + 1] = temp;
			}
		}
	}
}


int main() {
	int n;
	scanf("%d", &n);
	Stu* stu = (Stu*)malloc(n * sizeof(Stu));
	for (int i = 0; i < n; i++) {
		scanf("%s %d %d %d", stu[i].name, &stu[i].year, &stu[i].month, &stu[i].date);
	}
	old(stu, n);
	for (int i = n-1; i >= 0; i--) {
		printf("%s\n", stu[i].name);
	}
	return 0;
}
```
#### 7. The k-th Smallest Integer
You are given $n$ positive integers. Find the $k$-th smallest integer among the distinct values (count equal integers only once).

**Input Format:**
The first line contains $n$ and $k$; starting from the second line are the $n$ positive integers, separated by spaces.

**Output Format:**
Output the value of the $k$-th smallest integer; if there is no solution, output `NO RESULT`.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#define MAXN 10000

void BubbleSort(int* a, int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (a[j + 1] < a[j]) {
                int temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }
}

int main() {
    int n, m;
    scanf("%d %d", &n, &m);
    int a[MAXN];
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }
    BubbleSort(a, n);
    
    int b[MAXN];
    b[0] = a[0];
    int k = 1;
    for (int i = 1; i < n; i++) {
        if (a[i] != a[i - 1]) {
            b[k++] = a[i];
        }
    }
    
    int K = m;
    if (K > k) {
        printf("NO RESULT");
    }
    else {
        printf("%d", b[K - 1]);
    }
    return 0;
}
```
#### 8. Single-Plank Bridge
The war has reached a critical juncture. As the leader of a transport squad, you are leading your unit to deliver supplies to the front lines. The transport mission is as tedious as doing homework. Seeking some excitement, you order your soldiers to enjoy the scenery on a narrow wooden bridge ahead, while you stay under the bridge to watch them. The soldiers are furious because the bridge is extremely narrow and can only accommodate $1$ person at a time. If $2$ people meet on the bridge while walking towards each other, they cannot get around each other. Instead, $1$ person must turn back and get off the bridge to let the other pass first. However, multiple people can stay in the same position simultaneously.

Suddenly, you receive a message from headquarters: enemy bombers are flying toward the single-plank bridge where you are located. For safety, your unit must evacuate the bridge. The bridge has length $L$, and soldiers can only stay at positions with integer coordinates. All soldiers move at speed $1$, and once a soldier reaches coordinate $0$ or $L+1$ at any moment, he leaves the bridge.

Each soldier has an initial facing direction and will walk uniformly in that direction without changing it on his own. However, if two soldiers meet face to face, they cannot pass through each other, so they both turn around and keep walking. Turning around takes no time.

Due to earlier anger, you can no longer control your soldiers. You do not even know each soldier’s initial facing direction. Therefore, you want to know the minimum possible time for your unit to completely evacuate the bridge. In addition, as headquarters is arranging to block the enemy’s advance, you also need to know the maximum possible time for your unit to completely evacuate the bridge.

**Input Format:**
The first line contains a single integer $L$, the length of the bridge. The coordinates on the bridge are $1, 2, \cdots, L$.

The second line contains a single integer $N$, the number of soldiers initially on the bridge.

The third line contains $N$ integers, the initial coordinate of each soldier.

**Output Format:**
Output a single line with $2$ integers: the minimum and maximum time for the unit to evacuate the bridge. The $2$ integers are separated by a space.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>

int max(int *a, int *b) {
	if (*a > *b) {
		return *a;
	}
	return *b;
}

int min(int* a, int* b) {
	if (*a < *b) {
		return *a;
	}
	return *b;
}

int main() {
	int L;
	scanf("%d", &L);
	int N;
	scanf("%d", &N);
	int MAXN=max(&N,&L);
	if (N == 0) {
		printf("0 0");
		return 0;
	}
	int* a = (int*)malloc(MAXN * sizeof(int));
	for (int i = 0; i < N; i++) {
		scanf("%d", &a[i]);
	}
	int* b = (int*)malloc(MAXN * sizeof(int));
	for (int i = 0; i < N; i++) {
		b[a[i]] = 1;
	}

	int min_time = 0;
	int max_time = 0;
	int* min1 = (int*)malloc(MAXN * sizeof(int));
	int* max1 = (int*)malloc(MAXN * sizeof(int));
	int MIN = 0;
	int MAX = 0;
	for (int j = 1; j <= L;j++) {
		if (b[j] == 1) {
			int jude = abs(j - (L + 1));
			min1[MIN++] = min(&jude, &j);
		}
	}
	for (int i = 0; i < MIN; i++) {
		if (min1[i] > min_time) {
			min_time = min1[i];
		}
	}
	for (int j = 1; j <= L ; j++) {
		if (b[j] == 1) {
			int jude = abs(j - (L + 1));
			max1[MAX++] = max(&jude, &j);
		}
	}
	for (int i = 0; i < MAX; i++) {
		if (max_time < max1[i]) {
			max_time = max1[i];
		}
	}
	printf("%d ", min_time);
	printf("%d", max_time);
	return 0;
}
```
#### 9. Triple Hit
Partition the $9$ numbers $1, 2, \ldots , 9$ into $3$ groups to form $3$ three-digit numbers, such that these $3$ three-digit numbers are in the ratio $1 : 2 : 3$. Find all triplets of three-digit numbers that satisfy this condition.

**Input Format:**
None.

**Output Format:**
Several lines, each containing 3 numbers. Sort the lines in ascending order by the first number in each line.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
int main() {
	for (int a = 123; 3 * a < 1000; a++) {
		int b = 2 * a;
		int c = 3 * a;
		
		int valid = 1;
		int count[10] = { 0 };
		
		int temp1 = a;
		while (temp1 > 0) {
			int num = temp1 % 10;
			count[num]++;
			temp1 = temp1 / 10;
		}

		int temp2 = b;
		while (temp2 > 0) {
			int num = temp2 % 10;
			count[num]++;
			temp2 = temp2 / 10;
		}

		int temp3 = c;
		while (temp3 > 0) {
			int num = temp3 % 10;
			count[num]++;
			temp3 = temp3 / 10;
		}

		for (int i = 1; i <= 9; i++) {
			if (count[i] != 1) {
				valid = 0;
				break;
			}
		}

		if (count[0] != 0) {
			valid = 0;
		}

		if (valid == 1) {
			printf("%d %d %d\n", a, b, c);
		}
	}
	
	return 0;
}
```
#### 10. Series Summation
Given: $S_n= 1+\dfrac{1}{2}+\dfrac{1}{3}+…+\dfrac{1}{n}$. It is obvious that for any integer $k$, when $n$ is sufficiently large, $S_n>k$.
Given an integer $k$, compute the smallest $n$ such that $S_n>k$.

**Input Format:**
A positive integer $k$.

**Output Format:**
A positive integer $n$.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define MAXN 10000

int main() {
	int k;
	scanf("%d", &k);
	double Sn = 0;
	int n = 1;
	while (1) {
		Sn += 1.0 * 1 / n;
		if (Sn > k) {
			break;
		}
		n++;
	}
	printf("%d", n);
	return 0;
}
```
#### 11. Choosing Numbers
Given $n$ integers $x_1, x_2, \cdots, x_n$, and one integer $k$ ($k<n$). Choose any $k$ integers from the $n$ integers and add them up to obtain a set of sums. For example, when $n=4$, $k=3$, and the four integers are $3, 7, 12, 19$, all combinations and their sums are:

$3+7+12=22$.

$3+7+19=29$.

$7+12+19=38$.

$3+12+19=34$.

Now, you are required to compute how many of these sums are prime numbers.

For example, in the case above, only one sum is prime: $3+7+19=29$.

**Input Format:**
The first line contains two integers $n, k$ separated by a space ($1 \le n \le 20$, $k<n$).

The second line contains $n$ integers $x_1, x_2, \cdots, x_n$ ($1 \le x_i \le 5\times 10^6$).

**Output Format:**
Output a single integer representing the number of ways.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define MAXN 10000

int n, k;
int a[MAXN];
int cnt = 0;

int prime(int n) {
	if (n == 2) {
		return 1;
	}
	if (n < 2) {
		return 0;
	}
	int flag = 1;
	for (int i = 2; i * i <= n; i++) {
		if (n % i == 0) {
			flag = 0;
			break;
		}
	}
	return flag;
}

void dfs(int start, int depth, int sum) {
	if (depth == k) {
		if (prime(sum) == 1) {
			cnt++;
		}
		return;
	}
	for (int i = start; i < n; i++) {
		dfs(i + 1, depth + 1, sum + a[i]);
	}
}

int main() {
	scanf("%d %d", &n, &k);
	for (int i = 0; i < n; i++) {
		scanf("%d", &a[i]);
	}
	dfs(0, 0, 0);
	printf("%d", cnt);
	return 0;
}
```
#### 12. Herb Picking
Chenchen is a gifted child whose dream is to become the greatest physician in the world. To this end, he wants to apprentice with the most respected physician nearby. To assess his aptitude, the physician gave him a challenge. He took him to a cave full of herbs and said, “Child, there are different kinds of herbs in this cave. Picking each herb takes some time, and each has its own value. I will give you a period of time. During this time, you can pick some herbs. If you are clever, you should be able to maximize the total value of the herbs you pick.”

If you were Chenchen, could you complete this task?

**Input Format:**
The first line contains $2$ integers $T$ ($1 \le T \le 1000$) and $M$ ($1 \le M \le 100$), separated by a space. $T$ is the total time available for picking, and $M$ is the number of herbs in the cave.

Each of the next $M$ lines contains two integers between $1$ and $100$ inclusive, representing the time to pick a herb and the value of that herb.

**Output Format:**
Output the maximum total value of herbs that can be picked within the given time.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

int max(int a, int b) {
	if (a > b) {
		return a;
	}
	return b;
}

int main() {
	int T, M;
	scanf("%d %d", &T, &M);
    
	int* t = (int*)malloc((M+1) * sizeof(int));
	int* money = (int*)malloc((M+1) * sizeof(int));
	
	int dp[101][1001] = { 0 };

	for (int i = 1; i <= M; i++) {
		scanf("%d %d", &t[i], &money[i]);
	}

	for (int i = 1; i <= M; i++) {
		for (int j = 1; j <= T; j++) {
			if (j < t[i]) {
				dp[i][j] = dp[i-1][j];
			}
			else {
				dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - t[i]] + money[i]);
			}
		}
	}

	printf("%d", dp[M][T]);
	return 0;
}
```
#### 13. Cantor Table
One of the famous proofs in modern mathematics is Georg Cantor's proof that the rational numbers are countable. He used the following table to prove this statement:

![](https://cdn.luogu.com.cn/upload/image_hosting/jdjdaf73.png)

We number each entry of the table in a Z-shaped order. The first entry is $1/1$, then $1/2$, $2/1$, $3/1$, $2/2$, …

**Input Format:**
An integer $N$ ($1 \leq N \leq 10^7$).

**Output Format:**
The $N$-th term in the table.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

int main() {
	long long N;
	scanf("%lld", &N);
	long long sum = 0;
	long long sum1 = 0;
	long long index = 0;
	for (int i = 0;; i++) {
		sum += i;
		sum1 += i;
		index++;

		if (sum == N) {
			int ceng = index - 1;
			if (ceng % 2 == 0) {
				printf("%d/1", ceng);
			}
			else {
				printf("1/%d", ceng);
			}
			return 0;
		}

		if (sum > N) {
			sum1 = sum1 - i;
			break;
		}
	}
	int ceng = index - 1;

	int mom;
	int son;
	if (ceng % 2 == 0) {
		mom = ceng - (N - sum1 - 1);
		son = index - mom;
	}
	else {
		son = ceng - (N - sum1 - 1);
		mom = index - son;
	}
	printf("%d/%d", son, mom);
	return 0;
}
```
#### 14. Box Packing Problem
There is a box with capacity $V$, and there are $n$ items. Each item has a volume.

Now choose any number of items from the $n$ items (possibly none) to put into the box, so that the remaining space in the box is minimized. Output this minimum value.

**Input Format:**
The first line contains a single integer $V$, indicating the capacity of the box.

The second line contains a single integer $n$, indicating the total number of items.

The next $n$ lines each contain a positive integer, where the $i$-th line gives the volume of the $i$-th item.

**Output Format:**
Output a single integer in one line, indicating the minimal remaining space in the box.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

int main() {
	int V;
	scanf("%d", &V);
	int n;
	scanf("%d", &n);
	int* a = (int*)malloc(35 * sizeof(int));
	for (int i = 0; i < n; i++) {
		scanf("%d", &a[i]);
	}
	int dp[20005] = { 0 };
	for (int i = 0; i < n; i++) {
		for (int j = V; j >= a[i]; j--) {
			if (dp[j - a[i]] + a[i] > dp[j]) {
				dp[j] = dp[j - a[i]] + a[i];
			}
		}
	}
	printf("%d", V - dp[V]);
	return 0;
}
```
#### 15. Solving a Univariate Cubic Equation
Given a cubic equation of the form $a x^3 + b x^2 + c x + d = 0$. You are given the coefficients of the equation (where $a, b, c, d$ are real numbers). It is guaranteed that the equation has three distinct real roots, the roots lie in the range $-100$ to $100$, and the absolute difference between any two roots is $\ge 1$. Output the three real roots in increasing order on a single line (separated by spaces), each to exactly 2 decimal places.

Hint: Let the equation be $f(x) = 0$. If there exist two numbers $x_1$ and $x_2$ with $x_1 < x_2$ and $f(x_1) \times f(x_2) < 0$, then there is a root in the interval $(x_1, x_2)$.

**Input Format:**
One line containing $4$ real numbers $a, b, c, d$.

**Output Format:**
One line containing $3$ real roots in increasing order, each to exactly $2$ decimal places.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

double f(double a,double b,double c,double d,double x) {
	return a * pow(x, 3) + b * pow(x, 2) + c * pow(x, 1) + d;
}
  
int main() {
	double a, b, c, d;
	scanf("%lf %lf %lf %lf", &a, &b, &c, &d);
	double root[3];
	int cnt = 0;
	for (double x = -100.0; x < 100.0 && cnt < 3; x += 1.0) {
		double left = x;
		double right = x + 1.0;
		double fleft = f(a, b, c, d, left);
		double fright = f(a, b, c, d, right);

		if (fabs(fleft) < 1e-6) {
			root[cnt++] = left;
			continue;
		}
		if (fleft * fright < 0) {
			double mid;
			while (right - left > 1e-7) {
				mid = (left + right) / 2;
				if (f(a, b, c, d, left) * f(a, b, c, d, mid) <= 0) {
					right = mid;
				}
				else {
					left = mid;
				}
			}
			root[cnt++] = (left + right) / 2;
			x += 0.5;
		}
	}
	if (cnt < 3 && f(a, b, c, d, 100.0) < 1e-6) {
		root[cnt++] = 100.0;
	}
	printf("%.2f %.2f %.2f", root[0], root[1], root[2]);
	return 0;
}
```
#### 16. Table Tennis
Since taking office, Adham Sharara, the current President of the International Table Tennis Federation (ITTF), has been committed to implementing a series of reforms to promote the global popularization of table tennis. Among these reforms, the $11$-point scoring system has sparked considerable controversy, and some players have had to retire as they failed to adapt to the new rules. Huahua is one of them. After his retirement, he took up research on table tennis, aiming to figure out the different impacts of the $11$-point and $21$-point scoring systems on players. Before launching his research, he first needs to conduct some analysis on the statistical data from his years of competitions, and thus he needs your help.

Huahua analyzes the match in the following way: first, list the outcome of each rally, then compute the match results under the $11$-point system and the $21$-point system (up to the end of the record).

For example, consider the following record (where $\texttt W$ means Huahua scores a point, and $\texttt L$ means Huahua’s opponent scores a point):

$$\texttt{WWWWWWWWWWWWWWWWWWWWWWLW}$$

Under the $11$-point system, Huahua wins game $1$ by $11$ to $0$, wins game $2$ by $11$ to $0$, and game $3$ is in progress with the current score $1$ to $1$. Under the $21$-point system, Huahua wins game $1$ by $21$ to $0$, and game $2$ is in progress with the score $2$ to $1$. If a game has just started, the score is $0$ to $0$. A game ends only when the point difference is greater than or equal to $2$.

**Note:**
Once a game ends, the next one starts immediately.

Your program should read a sequence of match information in the form of $\texttt{WL}$ and output the correct results.

Each line contains at most 25 letters, and there are at most 2500 lines.

**Inout Format:**
The input consists of several lines, each being a string of uppercase $\texttt W$, $\texttt L$, and $\texttt E$. The character $\texttt E$ indicates the end of the match information; the program should ignore everything after $\texttt E$.

**Output Format:**
The output has two parts. Each part contains several lines, and each line corresponds to the score of one game (in the order implied by the input record). The first part is the result under the $11$-point system, and the second part is the result under the $21$-point system. The two parts are separated by one blank line.

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 65026

void GalGame_11(char* real_score) {
	int length = strlen(real_score);
	int num_W = 0;
	int num_L = 0;
	for (int i = 0; i < length; i++) {
		if (real_score[i] == 'E') {
			printf("%d:%d\n", num_W, num_L);
			num_W = 0;
			num_L = 0;
			break;
		}
		if (real_score[i] == 'W') {
			num_W++;
		}
		if (real_score[i] == 'L') {
			num_L++;
		}
		if ((num_W >= 11 || num_L >= 11) && abs(num_W - num_L) >= 2) {
			printf("%d:%d\n", num_W, num_L);
			num_W=0;
			num_L=0;
		}
		
	}
}

void GalGame_21(char* real_score) {
	int length = strlen(real_score);
	int num_W = 0;
	int num_L = 0;
	for (int i = 0; i < length; i++) {
		if (real_score[i] == 'E') {
			printf("%d:%d\n", num_W, num_L);
			num_W = 0;
			num_L = 0;
			break;
		}
		if (real_score[i] == 'W') {
			num_W++;
		}
		if (real_score[i] == 'L') {
			num_L++;
		}
		if ((num_W >= 21 || num_L >= 21) && abs(num_W - num_L) >= 2) {
			printf("%d:%d\n", num_W, num_L);
			num_W = 0;
			num_L = 0;
		}
		
	}
}

int main() {
	char* real_score = (char*)malloc(MAXN * sizeof(char));
	char ch;
	int length = 0;
	while ((ch = getchar()) != EOF) {
		if (ch != '\n') {
			real_score[length++] = ch;
		}
		if (ch == 'E') {
			break;
		}
	}
	real_score[length] = '\0';
	GalGame_11(real_score);
	printf("\n");
	GalGame_21(real_score);
	free(real_score);
	return 0;
}
```
#### 17. Stack
The stack is a classic data structure in computer science. Simply put, a stack is a linear list that restricts insertions and deletions to only one end.
A stack has two of the most important operations: pop (removing an element from the top of the stack) and push (adding an element onto the top of the stack).
The importance of stacks is self-evident, and every data structure course will cover them. While reviewing the basic concepts of stacks, student Ningning came up with a problem that is not discussed in textbooks, and he cannot figure out the answer on his own, so he needs your help.

![](https://cdn.luogu.com.cn/upload/image_hosting/5qxy9fz2.png)

Ningning considers the following problem: given an operand sequence $1, 2, \ldots, n$ (the figure illustrates the case for $1$ to $3$), stack A has depth greater than $n$.

Two operations are allowed:

1. Move a number from the head of the operand sequence to the top of the stack (corresponding to the stack push operation).
2. Move a number from the top of the stack to the end of the output sequence (corresponding to the stack pop operation).

Using these two operations, one operand sequence can produce a set of output sequences. The following figure shows the process of generating the sequence `2 3 1` from `1 2 3`.

![](https://cdn.luogu.com.cn/upload/image_hosting/8uwv2pa2.png)

(The initial state is as shown above.)

For a given $n$, your program should compute and output the total number of output sequences that can be obtained from the operand sequence $1, 2, \ldots, n$ through these operations.

**Input Format:**
The input contains a single integer $n$ ($1 \leq n \leq 18$).

**Output Format:**
Output a single line containing the total number of possible output sequences.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 65026

long long Catalan(int n) {
	if (n <= 1) {
		return 1;
	}
	return Catalan(n-1)*(4*n-2)/(n+1);
}

int main() {
	int n;
	scanf("%d", &n);
	long long data=Catalan(n);
	printf("%lld", data);
}
```
#### 18. Happy Jinming
Jinming is very happy today because his family is about to receive the keys to their new home, which has a spacious room just for him. What makes him even happier is that his mom told him yesterday: “You decide which items to buy and how to furnish your room, as long as the total cost does not exceed $N$ yuan.” Early this morning, Jinming started making a budget, but there are too many things he wants to buy, so the total will definitely exceed the limit $N$. Therefore, he assigns an importance level to each item, divided into 5 levels, represented by integers 1–5, with level 5 being the most important. He also found the price of each item on the Internet (all in integer yuan). He hopes to maximize the sum of price times importance for the selected items, under the constraint that the total cost does not exceed $N$ yuan (it may be equal to $N$ yuan).

Let the price of item $j$ be $v_j$ and its importance be $w_j$. If $k$ items are selected with indices $j_1, j_2, \dots, j_k$, then the desired total is:
$$v_{j_1} \times w_{j_1} + v_{j_2} \times w_{j_2} + \cdots + v_{j_k} \times w_{j_k}.$$

Please help Jinming design a shopping list that meets the requirements.

**Input Format:**
The first line contains $2$ positive integers separated by a space: $n, m$ ($n < 30000, m < 25$), where $n$ is the total amount of money and $m$ is the number of items.

From line $2$ to line $m+1$, the $i$-th of these lines (corresponding to item $i$) contains two non-negative integers $v, p$, where $v$ is the price ($v \le 10000$) and $p$ is the importance ($1 \le p \le 5$).

**Output Format:**
Output $1$ positive integer: the maximum possible value of the sum of price times importance for the selected items without exceeding the total amount of money (this value is $< 100000000$).
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 65026

int main() {
	int n,m;
	scanf("%d %d", &n, &m);
	int* money = (int*)malloc(m * sizeof(int));
	int* import = (int*)malloc(m * sizeof(int));
	for (int i = 0; i < m; i++) {
		scanf("%d %d", &money[i], &import[i]);
	}
	int dp[MAXN] = { 0 };
	for (int i = 0; i < m; i++) {
		int value = money[i] * import[i];
		for (int j = n ; j >= money[i]; j--) {
			if (dp[j - money[i]] + value > dp[j]) {
				dp[j] = dp[j - money[i]] + value;
			}
		}
	}
	printf("%d", dp[n]);
	return 0;
}
```
#### 19. Sequence
Given a positive integer $k$ ($3 \leq k \leq 15$), form an increasing sequence consisting of all powers of $k$ and all sums of finitely many distinct powers of $k$. For example, when $k = 3$, the sequence is:

$1, 3, 4, 9, 10, 12, 13, \ldots$

(This sequence is in fact: $3^0,3^1,3^0+3^1,3^2,3^0+3^2,3^1+3^2,3^0+3^1+3^2,…$.)

Please compute the value of the $N$-th term of this sequence and output it in base $10$ (decimal).

For example, for $k = 3$ and $N = 100$, the correct answer is $981$.

**Input Format:**
Two positive integers $k$ and $N$ separated by a space ($3 \leq k \leq 15$, $10 \leq N \leq 1000$).

**Output Format:**
A single positive integer. Do not print any spaces or other symbols before the integer.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 65026

int main() {
	int k, N;
	scanf("%d %d", &k, &N);
	long long sum = 0;
	long long p = 1;
	while (N > 0) {
		if (N & 1) {
			sum += p;
		}
		p *= k;
		N >>= 1;
	}
	printf("%lld", sum);
	return 0;
}
```
#### 20. Determining the Cutoff Score
The selection of volunteers for the World Expo is in full swing in City A. To choose the most suitable candidates, City A held a written test for all applicants. Only those whose written scores reach the interview cutoff can enter the interview. The interview cutoff is set at $150\%$ of the planned admission number. That is, if the plan admits $m$ volunteers, the cutoff score is the score of the contestant ranked at $m \times 150\%$ (rounded down), and all contestants whose written scores are not lower than the cutoff will enter the interview.

Please write a program to determine the interview cutoff score and output the registration IDs and written scores of all contestants who enter the interview.

**Input Format:**
- Line 1: Two integers $n, m$ ($5 \leq n \leq 5000, 3 \leq m \leq n$), separated by a space. Here $n$ is the total number of contestants who registered for the written test, and $m$ is the planned number of volunteers to admit. It is guaranteed that $m \times 150\%$, after rounding down, is less than or equal to $n$.
- Lines $2$ to $n+1$: Each line contains two integers separated by a space: the contestant’s registration ID $k$ ($1000 \leq k \leq 9999$) and written score $s$ ($1 \leq s \leq 100$). It is guaranteed that all registration IDs are distinct.

**Output Format:**
- Line 1: Two integers separated by a space. The first integer is the interview cutoff score; the second integer is the actual number of contestants who enter the interview.
- From line 2 onward: Each line contains two integers separated by a space, the registration ID and written score of a contestant who enters the interview. Output contestants in descending order of written score; for equal scores, sort by ascending registration ID.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

struct people {
	int number;
	int score;
};

typedef struct people Peo;

void Sort(Peo* get, int n) {
	for (int i = 0; i < n - 1; i++) {
		for (int j = 0; j < n - i - 1; j++) {
			if (get[j].score < get[j + 1].score) {
				Peo temp = get[j];
				get[j] = get[j + 1];
				get[j + 1] = temp;
			}
			else if (get[j].score == get[j + 1].score) {
				if (get[j].number > get[j + 1].number) {
					Peo temp = get[j];
					get[j] = get[j + 1];
					get[j + 1] = temp;
				}
			}
		}
	}
}

void pass(Peo* get, int n,int m) {
	int cnt = 0;
	int total = m * 3 / 2;
	int* pass1 = (int*)malloc(n * sizeof(int));
	for (int i = 0; i < n; i++) {
		pass1[i] = 0;
	}
	int score_line = get[total - 1].score;
	for (int i = 0; i < n; i++) {
		if (get[i].score >= score_line) {
			cnt++;
		}
	}
	printf("%d %d\n", score_line, cnt);
	for (int j = 0; j < cnt; j++) {
		printf("%d %d\n", get[j].number, get[j].score);
	}
}

int main() {
	int n, m;
	scanf("%d %d", &n, &m);
	Peo* get = (Peo*)malloc(n * sizeof(Peo));
	for (int i = 0; i < n; i++) {
		scanf("%d %d", &get[i].number, &get[i].score);
	}
	Sort(get, n);
	pass(get, n, m);
	return 0;
}
```
#### 21. The Infiltrator
Countries R and S are at war and have sent spies into each other’s territory. After many hardships, Xiao C (pinyin) from country R, who is undercover in country S, finally figured out the encoding rules of country S’s military cipher:

1. The plaintext to be sent by country S’s military is encrypted and then sent over the network. Both the plaintext and the ciphertext consist only of uppercase letters $\texttt{A}\sim\texttt{Z}$ (no spaces or other characters).
2. For each letter, country S specifies a corresponding cipher letter. Encryption replaces every letter in the plaintext with its corresponding cipher letter.
3. Each letter corresponds to exactly one unique cipher letter, and different letters correspond to different cipher letters. A letter may map to itself.

For example, if the cipher letter for $\tt A$ is $\tt A$, and for $\tt B$ is $\tt C$ (others omitted), then the plaintext $\tt ABA$ is encrypted as $\tt ACA$.

Now Xiao C has, via an inside source, one encrypted message together with its corresponding plaintext. He wants to break the cipher based on this information. His process is: scan the plaintext; for a plaintext letter $x$ (any uppercase letter), find the corresponding letter $y$ at the same position in the ciphertext, and conclude that in the cipher, $y$ is the cipher letter for $x$. Continue until one of the following states occurs:

1. All information has been scanned, and all $26$ letters $\texttt{A}\sim\texttt{Z}$ have appeared in the plaintext and obtained their corresponding cipher letters.
2. All information has been scanned, but there exists at least one letter that does not appear in the plaintext.
3. During scanning, an obvious contradiction or error is found (violating the encoding rules of country S’s cipher).

**Example:**

If some plaintext $\tt XYZ$ is translated as $\tt ABA$, it violates the rule “different letters correspond to different cipher letters.”

While Xiao C is overwhelmed, the headquarters of country R sends another telegram asking him to translate a newly intercepted encrypted message from country S. Please help Xiao C: deduce the cipher from the known pair, and then use the deduced cipher to translate the encrypted message in the telegram.

**Input Format:**
There are three lines. Each line is a string with length between $1$ and $100$.

- The first line is an encrypted message known to Xiao C.
- The second line is the plaintext corresponding to the first line.
- The third line is the encrypted message that country R’s headquarters asks Xiao C to translate.

The testdata guarantees that all strings consist only of uppercase letters $\texttt{A}\sim\texttt{Z}$, and that the lengths of the first and second lines are equal.

**Output Format:**
Output one line.

If the cipher deduction stops in cases $2$ or $3$, output $\tt Failed$. Otherwise, output the plaintext obtained by translating the encrypted message using the deduced cipher.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

int main() {
	char sec[MAXN];
	scanf("%s", sec);
	getchar();
	char ori[MAXN];
	scanf("%s", ori);
	getchar();
	char need[MAXN];
	scanf("%s", need);
	getchar();

	int len_sec = strlen(sec);
	int len_ori = strlen(ori);
	int len_need = strlen(need);

	if (len_sec != len_ori) {
		return 0;
	}

	int mape[26];
	int mapo[26];
	
	for (int i = 0; i < 26; i++) {
		mape[i] = -1;
		mapo[i] = -1;
	}


	int letter[26] = { 0 };
	int letter_sec[26] = { 0 };

	for (int i = 0; i < len_sec; i++) {
		int o = ori[i] - 'A';
		int e = sec[i] - 'A';

		if (mapo[o] != -1 && mapo[o] != e) {
			printf("Failed");
			return 0;
		}

		if (mape[e] != -1 && mape[e] != o) {
			printf("Failed");
			return 0;
		}

		mapo[o] = e;
		mape[e] = o;

		letter[o]++;
		letter_sec[e]++;
	}

	for (int i = 0; i < 26; i++) {
		if (letter[i] == 0) {
			printf("Failed");
			return 0;
		}
	}

	for (int i = 0; i < 26; i++) {
		if (letter_sec[i] == 0) {
			printf("Failed");
			return 0;
		}
	}

	for (int i = 0; i < len_need; i++) {
		int e = need[i] - 'A';
		int o = mape[e];
		printf("%c", 'A' + o);
	}

	return 0;
}
```
#### 22. Prime Factorization
Given a positive integer $n$ that is the product of two distinct primes, find the larger prime.

**Input Format:**
Input a positive integer $n$.

**Output Format:**
Output a positive integer $p$, the larger prime.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

int IsPrime(long long a) {
	if (a < 2) {
		return 0;
	}
	if (a == 2||a == 3 ) {
		return 1;
	}
	if (a % 2 == 0 || a % 3 == 0) {
		return 0;
	}
	for (long long i = 5; i <= sqrt(a); i += 6) {
		if (a % i == 0) {
			return 0;
		}
	}
	return 1;
}

int main() {
	long long n;
	scanf("%lld", &n);
	long long ori = n;
	long long prime = 0;
	if (n % 2 == 0) {
		prime = 2;
		while (n % 2 == 0) {
			n = n / 2;
		}
	}
	for (long long i = 3; i * i <= ori; i += 2) {
		if (n % i == 0) {
			if (IsPrime(i)) {
				prime = i;
				while (n % i == 0) {
					n = n / i;
				}
			}
		}
	}
	if (n > 1 && IsPrime(n)) {
		prime = n;
	}
	if (prime == 0) {
		prime = ori;
	}
	printf("%lld", prime);
	return 0;
}
```
#### 23. Scholarship
An elementary school recently received sponsorship and plans to award scholarships to the top $5$ students with the best academic performance. At the end of the term, each student has scores in $3$ subjects: Chinese, Mathematics, and English. First, sort by total score in descending order. If two students have the same total score, sort by Chinese score in descending order. If both the total score and the Chinese score are the same, the student with the smaller student ID comes first. In this way, each student's ranking is uniquely determined.

Task: First compute the total score from the $3$ subject scores in the input, then sort according to the rules above, and finally output the student IDs and total scores of the top five students in rank order.

**Note:**
Note that among the top $5$ students, each person's scholarship is different, so you must strictly follow the rules above for sorting. For example, in a correct answer, if the first two lines of output data (each line outputs two numbers: student ID and total score) are:

```plain
7 279  
5 279
```

these two lines mean that the student IDs of the two students with the highest total scores are $7$ and $5$ in order. Both students have a total score of $279$ (the total score equals the sum of the scores in Chinese, Mathematics, and English), but the student with ID $7$ has a higher Chinese score.

If your first two lines of output are:

```plain
5 279  
7 279
```

then it will be judged as wrong output and you will receive no score.

**Input Format:**
There are $n+1$ lines.

- The first line contains a positive integer $n \le 300$, representing the number of students participating in the selection.
- Lines $2$ to $n+1$ each contain $3$ space-separated integers, each between $0$ and $100$ inclusive. On line $j$, the $3$ integers are the scores of the student with ID $j-1$ in this order: Chinese, Mathematics, English. Each student's ID is numbered from $1$ to $n$ according to the input order (exactly the line number minus $1$).

The given testdata are guaranteed to be valid; no need to validate.

**Output Format:**
Output $5$ lines. Each line contains two space-separated positive integers, representing the student ID and the total score of the top $5$ students, in order.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

struct score {
	int Chinese;
	int Math;
	int English;
	int sum;
	int number;
};

typedef struct score Score;

void Sort(Score* stu, int n) {
	for (int i = 0; i < n - 1; i++) {
		for (int j = 0; j < n - 1 - i; j++) {
			if (stu[j].sum < stu[j + 1].sum) {
				Score temp = stu[j];
				stu[j] = stu[j + 1];
				stu[j + 1] = temp;
			}
			if (stu[j].sum == stu[j + 1].sum && stu[j].Chinese < stu[j + 1].Chinese) {
				Score temp = stu[j];
				stu[j] = stu[j + 1];
				stu[j + 1] = temp;
			}
			else if (stu[j].sum == stu[j + 1].sum && stu[j].Chinese < stu[j + 1].Chinese && stu[j].number>stu[j + 1].number) {
				Score temp = stu[j];
				stu[j] = stu[j + 1];
				stu[j + 1] = temp;
			}
		}
	}
}

int main() {
	int n;
	scanf("%d", &n);
	Score* stu = (Score*)malloc(sizeof(Score) * n);
	for (int i = 0; i < n; i++) {
		stu[i].number = i + 1;
		scanf("%d %d %d", &stu[i].Chinese, &stu[i].Math, &stu[i].English);
		stu[i].sum = stu[i].Chinese + stu[i].Math + stu[i].English;
	}
	Sort(stu, n);
	for (int i = 0; i < 5; i++) {
		printf("%d %d\n", stu[i].number, stu[i].sum);
	}
	return 0;
}
```
#### 24. Mingming's Random Numbers
Mingming wants to invite some classmates at school to fill out a questionnaire. For objectivity, he first uses a computer to generate $N$ random integers between $1$ and $1000$ ($N \leq 100$). For any duplicates, keep exactly one occurrence and remove the rest; different numbers correspond to different students' ID numbers. Then sort these numbers in ascending order, and visit the classmates in the sorted order. Please help Mingming remove duplicates and sort the numbers.

**Input Format:**
The input has two lines.  
The first line contains a positive integer, the number $N$ of generated random integers.  
The second line contains $N$ positive integers separated by spaces, which are the generated random integers.

**Output Format:**
The output also has two lines.  
The first line contains a positive integer $M$, the number of distinct random integers.  
The second line contains $M$ positive integers separated by spaces, which are the distinct random integers in ascending order.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

void BubbleSort(int* a, int n) {
	for (int i = 0; i < n - 1; i++) {
		for (int j = 0; j < n - 1 - i; j++) {
			if (a[j] > a[j + 1]) {
				int temp = a[j];
				a[j] = a[j + 1];
				a[j + 1] = temp;
			}
		}
	}
}

int main() {
	int n;
	scanf("%d", &n);
	int* a = (int*)malloc(n * sizeof(int));
	for (int i = 0; i < n; i++) {
		scanf("%d", &a[i]);
	}
	BubbleSort(a, n);
	int* b = (int*)malloc(n * sizeof(int));
	b[0] = a[0];
	int k = 1;
	for (int i = 1; i < n; i++) {
		if (a[i - 1] != a[i]) {
			b[k++] = a[i];
		}
	}
	printf("%d\n", k);
	for (int i = 0; i < k; i++) {
		if (i != 0) {
			printf(" ");
		}
		printf("%d", b[i]);
	}
	return 0;
}
```
#### 25. Polynomial Output
A univariate polynomial of degree $n$ can be written as:
$$f(x)=a_nx^n+a_{n-1}x^{n-1}+\cdots +a_1x+a_0,a_n\ne 0$$
Here, $a_ix^i$ is called the $i$-th degree term, and $a_i$ is its coefficient. Given the degree and coefficients of a univariate polynomial, output the polynomial in the following format:

1. The indeterminate is $x$. List the terms from left to right in descending order of degree.
2. Include only terms whose coefficients are nonzero.
3. If the leading (degree-$n$) coefficient is positive, the polynomial must not start with a `+` sign; if it is negative, the polynomial must start with a `-` sign.
4. For any non-leading term, connect it to the previous term with `+` or `-`, indicating a positive or negative coefficient, respectively. Immediately follow with the absolute value of the coefficient as a positive integer (for terms of degree greater than $0$, omit the $1$ if the coefficient’s absolute value is $1$). If the exponent of $x$ is greater than $1$, write it as “$x^b$”, where $b$ is the exponent; if the exponent is $1$, write it as $x$; if the exponent is $0$, output only the coefficient.
5. There must be no extra spaces at the beginning or the end of the polynomial.

**Input Format:**
There are $2$ lines of input.

- The first line contains one integer $n$, the degree of the polynomial.
- The second line contains $n+1$ integers. The $i$-th integer is the coefficient of the term of degree $n-i+1$. Integers are separated by single spaces.

**Output Format:**
Output one line: the polynomial formatted as described above.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#define MAXN 10000

int main() {
	int n;
	scanf("%d", &n);
	int* a = (int*)malloc((n + 1) * sizeof(int));
	int cnt_0 = 0;
	for (int i = n; i >= 0; i--) {
		scanf("%d", &a[i]);
		if (a[i] == 0) {
			cnt_0++;
		}
	}
	if (cnt_0 == n + 1) {
		printf("0");
		return 0;
	}
	int head = 1;
	for (int i = n; i >= 0; i--) {
		if (a[i] == 0) {
			continue;
		}
		if (a[i] < 0) {
			printf("-");
		}
		if (i != n && a[i] > 0 && head == 0) {
			printf("+");
		}
		if (abs(a[i]) != 1 || i == 0) {
			printf("%d", abs(a[i]));
		}
		if (a[i] != 0) {
			head = 0;
		}
		if (i == 0) {
			break;
		}
		if (i == 1) {
			printf("x");
			continue;
		}
		printf("x^%d", i);
		if (a[i] != 0) {
			head = 0;
		}
	}
	return 0;
}
```
#### 26. ISBN Number
Every formally published book has an ISBN number associated with it. An ISBN consists of $9$ digits, $1$ check digit, and $3$ separators. Its prescribed format is `x-xxx-xxxxx-x`, where the symbol `-` is the separator (the minus sign on the keyboard), and the last character is the check digit. For example, `0-670-82162-4` is a standard ISBN. The first digit indicates the publication language of the book (for example, $0$ represents English); the three digits after the first separator `-` indicate the publisher (for example, $670$ represents Viking Press); the five digits after the second separator indicate the book’s identifier at that publisher; the last character is the check digit.

The check digit is computed as follows:

Multiply the first digit by $1$, add the second digit multiplied by $2$, and so on. Take the resulting sum $\bmod 11$; the remainder is the check digit. If the remainder is $10$, then the check digit is the uppercase letter $X$. For example, in the ISBN `0-670-82162-4`, the check digit $4$ is obtained as follows: take the nine digits `067082162` from left to right, multiply them by $1,2,\dots,9$ respectively and sum, i.e., $0\times 1 + 6\times 2 + \cdots + 2\times 9 = 158$, then take $158 \bmod 11$, whose result $4$ is the check digit.

Your task is to write a program to determine whether the check digit in the input ISBN number is correct. If it is correct, output `Right` only; if it is incorrect, output the ISBN number you believe to be correct.

**Input Format:**
A character sequence representing a book’s ISBN number (the input is guaranteed to conform to the format requirements of ISBN numbers).

**Output Format:**
One line. If the check digit of the input ISBN number is correct, output `Right`; otherwise, output the correct ISBN number in the prescribed format (including the separator `-`).
```c
int main() {
	char a[20];
	int num[20] = { 0 };
	int j = 0;
	scanf("%s", a);
	for (int i = 0; i < 13; i++) {
		if (i != 1 && i != 5 && i != 11) {
			num[j++] = a[i] - '0';
		}
	}
	long long sum = 0;   /* j=10 */
	int x;
	if (a[12] == 'X') {
		x = 10;
	}
	else {
		x = a[12] - '0';
	}
	for (int i = 0; i < j; i++) {
		if (i < j - 1) {
			int number = num[i] * (i + 1);
			sum += number;
		}
	}
	int x1 = sum % 11;
	if (x == x1) {
		printf("Right");
		return 0;
	}
	int k = 0;
	for (int i = 0; i < 12; i++) {
		if (i == 1 || i == 5 || i == 11) {
			printf("-");
		}
		else {
			printf("%d", num[k]);
			k++;
		}
	}
	if (x1 == 10) {
		printf("X");
	}
	else {
		printf("%d", x1);
	}
	return 0;
}
```
#### 27. Hankson's Fun Problem
Dr. Hanks is a renowned expert in BT (Bio-Tech). His son is named Hankson. Now, just home from school, Hankson is thinking about an interesting problem.

Today in class, the teacher explained how to find the greatest common divisor and least common multiple of two positive integers $c_1$ and $c_2$. Now that Hankson believes he has mastered these topics, he starts considering an "inverse problem" to problems like "finding a common divisor" and "finding a common multiple". The problem is as follows: given positive integers $a_0, a_1, b_0, b_1$, let an unknown positive integer $x$ satisfy:

1. The greatest common divisor of $x$ and $a_0$ is $a_1$.
2. The least common multiple of $x$ and $b_0$ is $b_1$.

Hankson's "inverse problem" is to find all positive integers $x$ that satisfy the conditions. After a little thought, he realizes such $x$ are not necessarily unique and may even not exist. Therefore, he turns to counting how many $x$ satisfy the conditions. Please help him write a program to solve this problem.

**Input Format:**
The first line contains a positive integer $n$, indicating there are $n$ sets of input. Each of the next $n$ lines contains one set of input: four positive integers $a_0, a_1, b_0, b_1$, separated by single spaces. It is guaranteed that $a_0$ is divisible by $a_1$, and $b_1$ is divisible by $b_0$.

**Output Format:**
Output $n$ lines. For each set of input, output a single integer on one line.

For each set: if no such $x$ exists, print $0$; if such $x$ exist, print the number of $x$ that satisfy the conditions.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int gcd(int a, int b) {
	return b == 0 ? a : gcd(b, a % b);
}

int gcd_1(int a, int b) {
	while (b != 0) {
		int temp = b;
		b = a % b;
		a = temp;
	}
	return a;
}

int lcm(int a, int b) {
	return (a / gcd_1(a, b)) * b;
}

int main() {
	int n;
	scanf("%d", &n);
	int a0, a1, b0, b1;
	for (int i = 0; i < n; i++) {
		scanf("%d%d%d%d", &a0, &a1, &b0, &b1);
		int max = b1 / b0;
		int min = a1;
		int cnt = 0;
		for (int x = 1; x*x <= b1; x++) {
			if (b1 % x == 0) {
				if (x%a1==0&&gcd(x, a0) == a1 && lcm(x, b0) == b1) {
				    cnt++;
			    }
				int y = b1 / x;
				if (y!=x&&y % a1 == 0 && gcd(y, a0) == a1 && lcm(y, b0) == b1) {
					cnt++;
				}
			}
		}
		printf("%d\n", cnt);
	}
	return 0;
}
```
#### 28. Souvenir Grouping
New Year’s Day is coming, and the student council has tasked Lele with distributing souvenirs at the New Year’s party. To keep the value of souvenirs received by participants relatively balanced, he wants to group the purchased souvenirs by price. Each group can contain at most two souvenirs, and the sum of prices in a group cannot exceed a given integer $w$. To finish the distribution as quickly as possible, Lele wants to minimize the number of groups.

Your task is to write a program that finds a grouping scheme with the minimal number of groups and outputs that minimal number.

**Constraints:**
- $50\%$ of the testdata: $1 \le n \le 15$.
- $100\%$ of the testdata: $1 \le n \le 3\times 10^4$, $80 \le w \le 200$, $5 \le P_i \le w$.

**Input Format:**
A total of $n+2$ lines:

- The first line contains an integer $w$, the upper bound on the sum of prices in each group.
- The second line contains an integer $n$, the total number of souvenirs.
- Lines 3 to $n+2$: each line contains a positive integer $P_i$ representing the price of the corresponding souvenir.

**Output Format:**
A single integer: the minimal number of groups.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int cmp(const void* a, const void* b) {
	return *(int*)a - *(int*)b;
}

int main() {
	int w, n;
	scanf("%d %d", &w, &n);
	int* price = (int*)malloc(n * sizeof(int));
	for (int i = 0; i < n; i++) {
		scanf("%d", &price[i]);
	}
	qsort(price, n, sizeof(int), cmp);
	int left = 0;
	int right = n - 1;
	int groups = 0;
	while (left <= right) {
		if (left == right) {
			groups++;
			break;
		}
		if (price[left] + price[right] <= w) {
			left++;
			right--;
		}
		else {
			right--;
		}
		groups++;
	}
	printf("%d", groups);
	return 0;
}
```
#### 29. Peanut Picking
Mr. Robinson has a pet monkey named Dodo. One day, while they were walking along a country road, they found a small note on a roadside sign: “Welcome to taste my peanuts for free! — Xiong.”

They were happy because peanuts are their favorite. Behind the sign, there is indeed a peanut field by the roadside, where peanut plants are arranged in a rectangular grid (see Figure 1). Experienced Dodo can tell how many peanuts are under each plant at a glance. To train Dodo’s arithmetic, Mr. Robinson says: “First find the plant with the most peanuts and pick its peanuts; then among the remaining plants, find the one with the most peanuts and pick it; and so on. But you must return to the roadside within the time limit I set.”

![](https://cdn.luogu.com.cn/upload/image_hosting/unwk7hd0.png)

We assume that in each unit of time, Dodo can do exactly one of the following four actions:
1) Jump from the roadside to some peanut plant in the first row (i.e., the row closest to the roadside).
2) Jump from one plant to another plant adjacent to it in the up, down, left, or right direction.
3) Pick the peanuts under the current plant.
4) Jump from some plant in the first row back to the roadside.

Given the size of the peanut field and the distribution of peanuts, compute the maximum number of peanuts Dodo can pick within the time limit. Note that only some plants may have peanuts under them. Assume that the numbers of peanuts on those plants are pairwise distinct.

For example, in the peanut field shown in Figure 2, only the plants at $(2, 5), (3, 7), (4, 2), (5, 4)$ have peanuts, in quantities $13, 7, 15, 9$, respectively. Along the illustrated route, Dodo can pick at most $37$ peanuts within $21$ units of time.

**Note:** 
You may not return to the roadside during the picking process.

**Input Format:**
The first line contains three integers $M, N, K$, separated by spaces, indicating that the field size is $M \times N$ and the time limit is $K$ units.

The next $M$ lines each contain $N$ non-negative integers, also separated by spaces. In the $(i + 1)$-th line, the $j$-th integer $P_{i,j}$ denotes the number of peanuts under plant $(i, j)$; $0$ means that plant has no peanuts.

**Output Format:**
Output a single integer: the maximum number of peanuts Dodo can pick within the time limit.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int main() {
	int M, N, K;
	scanf("%d %d %d", &M, &N, &K);
	int feild[25][25];
	memset(feild, 0, sizeof(feild));
	for (int i = 1; i <= M; i++) {
		for (int j = 1; j <= N; j++) {
			scanf("%d", &feild[i][j]);
		}
	}
	int total = 0;
	int cur_x = 0;
	int cur_y = 0;
	int cur_time = 0;
	while (1) {
		int max = 0;
		int target_x = 0;
		int target_y = 0;
		for (int i = 1; i <= M; i++) {
			for (int j = 1; j <= N; j++) {
				if (feild[i][j] > max) {
					max = feild[i][j];
					target_x = i;
					target_y = j;
				}
			}
		}
		if (max == 0) {
			break;
		}
		int need_time;
		if (cur_x == 0) {
			need_time = target_x + 1;
		}
		else {
			need_time = abs(target_x - cur_x) + abs(target_y - cur_y) + 1;
		}
		if (cur_time + need_time + target_x <= K) {
			total += max;
			cur_time += need_time;
			cur_x = target_x;
			cur_y = target_y;
			feild[target_x][target_y] = 0;
		}
		else {
			break;
		}
	}
	printf("%d\n", total);
	return 0;
}
```
#### 30. Counting Numbers
In a research survey, $n$ natural numbers were collected, each not exceeding $1.5 \times 10^9$. It is known that the number of distinct values does not exceed $10^4$. Now you need to count how many times each natural number appears and output the results in ascending order of the numbers.

**Input Format:**
There are $n+1$ lines in total.

- The first line contains an integer $n$, the number of natural numbers.
- Lines $2$ to $n+1$ each contain one natural number.

**Output Format:**
Output $m$ lines in total (where $m$ is the number of distinct numbers among the $n$ natural numbers), in ascending order of the numbers.

Each line outputs $2$ integers: the natural number and the number of times it appears, separated by a single space.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int cmp(const void* a, const void* b) {
	return *(long long*)a - *(long long*)b;
}

int main() {
	long long n;
	scanf("%lld", &n);
	long long* a = (long long*)malloc(n * sizeof(long long));
	for (long long i = 0; i < n; i++) {
		scanf("%lld", &a[i]);
	}
	qsort(a, n, sizeof(long long), cmp);
	long long cnt = 1;
	for (long long i = 1; i <= n; i++) {
		if (i == n || a[i] != a[i - 1]) {
			printf("%lld %lld\n", a[i - 1], cnt);
			cnt = 1;
		}
		else {
			cnt++;
		}
	}
	free(a);
	return 0;
}
```
#### 31. Swap High and Low Bits
You are given a non-negative integer less than $2^{32}$. This number can be represented as a 32-bit binary number (pad with leading zeros if it has fewer than 32 bits). We call the first 16 bits the high 16 bits, and the last 16 bits the low 16 bits. Swap its high and low 16 bits to obtain a new number. What is this new number (in decimal)?

For example, the number $1314520$ is represented in binary as $0000\,0000\,0001\,0100\,0000\,1110\,1101\,1000$ (with $11$ leading zeros added to make it 32 bits), where the high 16 bits are $0000\,0000\,0001\,0100$, and the low 16 bits are $0000\,1110\,1101\,1000$. After swapping the high and low bits, we get a new binary number $0000\,1110\,1101\,1000\,0000\,0000\,0001\,0100$. This is $249036820$ in decimal.

**Input Format:**
A non-negative integer less than $2^{32}$.

**Output Format:**
Output the new number.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int main() {
	unsigned int n;
	scanf("%u", &n);
	unsigned int low = n & 0xFFFF;
	unsigned int high = (n >> 16) & 0xFFFF;
	unsigned int result = (low << 16) | high;
	printf("%u\n", result);
	return 0;
}
```
#### 32. Platforms
There are several platforms in space. Given the position of each platform, determine which platform you will land on after stepping off each platform’s edges.

**Note:** 
If the x-coordinates of some edge of two platforms are the same, then an object falling from the upper platform will not land on the lower one (i.e., each platform covers an open interval, excluding endpoints). Platforms may overlap.

When stepping off a platform, the fall is considered to start just below that platform, so you will not land on a platform of the same height. If there are two platforms with the same height that are both eligible to be landed on, you will land on the one with the smaller index.

**Input Format:**
The first line contains an integer $N$, the number of platforms.

Each of the next $N$ lines contains three integers: the height $H_i$, the left endpoint’s $X$-coordinate $L_i$, and the right endpoint’s $X$-coordinate $R_i$.

**Output Format:**
Output $N$ lines. For each $i$, output two integers: the index of the platform reached by falling from the left edge of platform $i$, and the index reached by falling from the right edge of platform $i$.

Platforms are numbered from $1$ in the input. If there is no platform below a given edge, output $0$.

**Constraints:** 
$1 \le N \le 10^3$, $0 \le H, L, R \le 2 \times 10^4$.

**Tip:**
![](https://cdn.luogu.com.cn/upload/image_hosting/qeknowf7.png)
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

struct platform {
	int height;
	int left;
	int right;
};

typedef struct platform Plat;
int main() {
	int n;
	scanf("%d", &n);
	Plat* plat = (Plat*)calloc((n + 1) , sizeof(Plat));
	for (int i = 1; i <= n; i++) {
		scanf("%d %d %d", &plat[i].height, &plat[i].left, &plat[i].right);
	}
	for (int i = 1; i <= n; i++) {
		int maxH_l = 0;
		int maxH_r = 0;
		int index_l = 0;
		int index_r = 0;
		for (int j = 1; j <= n; j++) {
			int left_i = 0;
			int right_i = 0;

			//Not possible landing on the higher platform
			if (plat[i].height <= plat[j].height || i == j) {
				continue;
			}

			//Find the max height below plat[i]
			if (plat[i].left > plat[j].left && plat[i].left < plat[j].right) {
				if (maxH_l < plat[j].height || (maxH_l == plat[j].height && j < index_l)) {
					maxH_l = plat[j].height;
					index_l = j;
				}
			}
			if (plat[i].right < plat[j].right && plat[i].right > plat[j].left) {
				if (maxH_r < plat[j].height || (maxH_r == plat[j].height && j < index_r)) {
					maxH_r = plat[j].height;
					index_r = j;
				}
			}
		}
		printf("%d %d\n", index_l, index_r);
	}
	free(plat);
	return 0;
}
```
#### 33. Student Grouping
There are $n$ groups of students. You are given the initial number of students in each group, and the upper bound $R$ and lower bound $L$ for each group size (with $L \le R$). In one operation, you may select one student from a group and move them to another group. What is the minimum number of operations required to make the sizes of all $n$ groups fall within $[L, R]$?

**Input Format:**
The first line contains an integer $n$, the number of student groups.
The second line contains $n$ integers, the number of students in each group.
The third line contains two integers $L, R$, the lower and upper bounds.

**Output Format:**
Output a single integer, the minimum number of moves. If it is impossible to satisfy the condition, output -1.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int main() {
	int n;
	scanf("%d", &n);
	int sum = 0;
	int* now = (int*)malloc(n * sizeof(int));
	for (int i = 0; i < n; i++) {
		scanf("%d", &now[i]);
		sum += now[i];
	}
	int left, right;
	scanf("%d %d", &left, &right);
	if (right * n < sum || left * n > sum) {
		printf("-1");
		free(now);
		return 0;
	}
	int a = 0;
	int b = 0;
	for (int i = 0; i < n; i++) {
		if (now[i] < left) {
			a += (left - now[i]);
		}
		else if (now[i] > right) {
			b += (now[i] - right);
		}
	}
	int total = a > b ? a : b;
	printf("%d\n", total);
	free(now);
	return 0;
}
```
#### 34. Maximum Subarray Sum
Given a sequence $a$ of length $n$, choose a non-empty contiguous subarray whose sum is maximized.

**Input Format:**
The first line contains an integer $n$, the length of the sequence.
The second line contains $n$ integers; the $i$-th is $a_i$.

**Output Format:**
Output one line with a single integer, the answer.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int main() {
	int n;
	scanf("%d", &n);
	int* a = (int*)malloc(n * sizeof(int));
	for (int i = 0; i < n; i++) {
		scanf("%d", &a[i]);
	}
	int cur = a[0];
	int max = a[0];
	for (int i = 1; i < n; i++) {
		if (cur > 0) {
			cur += a[i];
		}
		else {
			cur = a[i];
		}
		if (cur > max) {
			max = cur;
		}
	}
	printf("%d", max);
	return 0;
}
```
#### 35. Carriage Reordering
Next to an old-style railway station there is a bridge whose deck can rotate horizontally around the pier at the center of the river. A station worker discovered that the bridge can hold at most two carriages. If the bridge is rotated by $180$ degrees, the positions of two adjacent carriages can be swapped. Using this method, the order of the carriages can be rearranged. He was responsible for rearranging incoming carriages in increasing order of their carriage numbers. After he retired, the station decided to automate this work. One important task is to write a program that, given the initial order of the carriages, computes the minimum number of steps needed to sort the carriages.

**Input Format:**
The input consists of two parts.

The first line is the total number of carriages $N( \le 10000)$.

The second line contains $N$ distinct integers representing the initial order of the carriages.  

**Output Format:**
Output a single integer, the minimum number of rotations.

**Note:** 
In the testdata, these integers are not necessarily on a single line and may be split across multiple lines.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int main() {
	int n;
	scanf("%d", &n);
	int* a = (int*)malloc(n * sizeof(int));
	for (int i = 0; i < n; i++) {
		scanf("%d", &a[i]);
	}
	int sum = 0;
	for (int i = 0; i < n - 1; i++) {
		for (int j = 0; j < n - i - 1; j++) {
			if (a[j] > a[j + 1]) {
				sum++;
				int temp = a[j];
				a[j] = a[j + 1];
				a[j + 1] = temp;
			}
		}
	}
	printf("%d", sum);
	return 0;
}
```
#### 36. Silly Little Monkey
The silly little monkey has a very small vocabulary, so he always struggles with English multiple-choice questions. But he found a method, and experiments show that using this method greatly increases the chance of choosing the correct option.

The method is described as follows: suppose $ \text{maxn} $ is the number of occurrences of the most frequent letter in a word, and $ \text{minn} $ is the number of occurrences of the least frequent letter in the word. If $ \text{maxn}-\text{minn} $ is a prime number, then the silly little monkey considers this a Lucky Word. Such a word is very likely to be the correct answer.

**Input Format:**
A single word containing only lowercase letters, with length less than $100$.

**Output Format:**
Two lines in total. The first line is a string: if the input word is a Lucky Word, output `Lucky Word`; otherwise, output `No Answer`.

The second line is an integer: if the input word is a Lucky Word, output the value of $ \text{maxn}-\text{minn} $; otherwise, output $0$.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int maxmin(char* word, int n) {
	int max = 0;
	int min = n;
	int* letter = (int*)calloc(26, sizeof(int));
	for (int i = 0; i < n; i++) {
		letter[word[i] - 'a']++;
	}
	for (int i = 0; i < 26; i++) {
		if (letter[i] > 0) {
			if (max < letter[i]) {
				max = letter[i];
			}
			if (letter[i] < min) {
				min = letter[i];
			}
		}
	}
	int delta = max - min;
	free(letter);
	return delta;
}

int isPrime(int n) {
	if (n <= 1)return 0;
	if (n == 2 || n == 3)return 1;
	if (n % 2 == 0 || n % 3 == 0)return 0;
	for (int i = 5; i * i <= n; i += 6) {
		if (n % i == 0 || n % (i + 2) == 0) {
			return 0;
		}
	}
	return 1;
}

int main() {
	char word[MAXN];
	scanf("%s", word);
	int length = strlen(word);
	int delta = maxmin(word, length);
	int result = isPrime(delta);
	if (result == 1) {
		printf("Lucky Word\n");
		printf("%d\n", delta);
	}
	else {
		printf("No Answer\n");
		printf("0\n");
	}
	return 0;
}
```
#### 37. Sum of Consecutive Positive Integers
Given a positive integer $M$, find all segments of consecutive positive integers (each segment must contain at least two numbers) whose sum is $M$.

Example: $1998+1999+2000+2001+2002 = 10000$, so the segment from $1998$ to $2002$ is a solution for $M=10000$.

**Input Format:**
A single line containing an integer giving the value of $M$ ($10 \le M \le 2,000,000$).

**Output Format:**
Output one line per solution, containing two positive integers: the first and last numbers of a valid consecutive positive integer segment, separated by a space. Sort all lines by the first number in ascending order. For the given input, at least one solution exists.
```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

struct num {
	int L;
	int R;
};

typedef struct num Num;

void bubblesort(Num* number, int cnt) {
	for (int i = 0; i < cnt - 1; i++) {
		for (int j = 0; j < cnt - i - 1; j++) {
			if (number[j].L > number[j + 1].L) {
				Num temp = number[j];
				number[j] = number[j + 1];
				number[j + 1] = temp;
			}
		}
	}
}

int main() {
	int M;
	scanf("%d", &M);
	int cnt = 0;
	Num* number = (Num*)malloc(MAXN * sizeof(Num));
	for (int i = 2; i <= sqrt(2 * M); i++) {
		if ((M * 2) % i == 0) {
			int temp = (M * 2) / i;
			if ((temp - i + 1) % 2 == 0) {
				int left = (temp + 1 - i) / 2;
				if (left >= 1) {
					int right = left + i - 1;
					number[cnt].R = right;
					number[cnt].L = left;
					cnt++;
				}
			}
		}
	}
	bubblesort(number,cnt);
	for (int i = 0; i < cnt; i++) {
		printf("%d %d\n", number[i].L, number[i].R);
	}
	return 0;
}
```
## <center>End</center>

