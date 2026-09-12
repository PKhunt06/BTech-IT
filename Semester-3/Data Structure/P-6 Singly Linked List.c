// P-6 Write a program to implement a singly linked list and perform the following operations:
// i. Insert a new node (at the beginning, at the end, after a given node)
// ii. Delete a node (first node, last node, node after a given node)
// Display all the nodes

#include <stdio.h>
#include <stdlib.h>

struct node
{
    int info;
    struct node *next;
};

struct node *first = NULL;

struct node* create_node(int x)
{
    struct node *t;

    t = (struct node*)malloc(sizeof(struct node));
    t->info = x;
    t->next = NULL;

    return t;
}

/* Insert at beginning */
void insert_first(int x)
{
    struct node *t = create_node(x);

    t->next = first;
    first = t;
}

/* Insert at end */
void insert_last(int x)
{
    struct node *t, *p;

    t = create_node(x);

    if (first == NULL)
        first = t;
    else
    {
        p = first;

        while (p->next != NULL)
            p = p->next;

        p->next = t;
    }
}

/* Insert after given node */
void insert_after(int key, int x)
{
    struct node *t, *p;

    p = first;

    while (p != NULL && p->info != key)
        p = p->next;

    if (p != NULL)
    {
        t = create_node(x);
        t->next = p->next;
        p->next = t;
    }
}

/* Delete first node */
void del_first()
{
    struct node *t;

    t = first;
    first = first->next;
    free(t);
}

/* Delete last node */
void del_last()
{
    struct node *t, *p;

    t = first;

    if (t->next == NULL)
    {
        first = NULL;
        free(t);
        return;
    }

    while (t->next->next != NULL)
        t = t->next;

    p = t->next;
    t->next = NULL;
    free(p);
}

/* Delete node after given node */
void del_after(int key)
{
    struct node *t, *p;

    t = first;

    while (t != NULL && t->info != key)
        t = t->next;

    if (t != NULL && t->next != NULL)
    {
        p = t->next;
        t->next = p->next;
        free(p);
    }
}

/* Display */
void display()
{
    struct node *t = first;

    while (t != NULL)
    {
        printf("%d -> ", t->info);
        t = t->next;
    }

    printf("NULL\n");
}

int main()
{
    int ch, x, key;

    while (1)
    {
        printf("\n1. Insert Node at Beginning");
        printf("\n2. Insert Node at End");
        printf("\n3. Insert Node After a Given Node");
        printf("\n4. Delete First Node");
        printf("\n5. Delete Last Node");
        printf("\n6. Delete Node After a Given Node");
        printf("\n7. Display All Nodes");
        printf("\n8. Exit");

        printf("\nEnter choice: ");
        scanf("%d", &ch);

        switch (ch)
        {
            case 1:
                printf("Enter value: ");
                scanf("%d", &x);
                insert_first(x);
                break;

            case 2:
                printf("Enter value: ");
                scanf("%d", &x);
                insert_last(x);
                break;

            case 3:
                printf("Enter given node and new value: ");
                scanf("%d%d", &key, &x);
                insert_after(key, x);
                break;

            case 4:
                del_first();
                break;

            case 5:
                del_last();
                break;

            case 6:
                printf("Enter given node: ");
                scanf("%d", &key);
                del_after(key);
                break;

            case 7:
                display();
                break;

            case 8:
                return 0;
        }
    }
}
