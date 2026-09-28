// P-7 write a program to implement a singly circular linked list and perform the following operations :
// i. Insert a new node (at the beginning, at the end, after a given node)
// ii. Delete a node (first node, last node, node after a given node)
// iii. Display all the nodes

#include <stdio.h>
#include <stdlib.h>

struct node
{
    int data;
    struct node *next;
};

struct node *last = NULL;

// Insert at beginning
void insert_begin(int x)
{
    struct node *newnode = malloc(sizeof(struct node));
    newnode->data = x;

    if (last == NULL)
    {
        last = newnode;
        newnode->next = last;
    }
    else
    {
        newnode->next = last->next;
        last->next = newnode;
    }
}

// Insert at end
void insert_end(int x)
{
    struct node *newnode = malloc(sizeof(struct node));
    newnode->data = x;

    if (last == NULL)
    {
        last = newnode;
        newnode->next = last;
    }
    else
    {
        newnode->next = last->next;
        last->next = newnode;
        last = newnode;
    }
}

// Insert after given node
void insert_after(int key, int x)
{
    struct node *temp;

    if (last == NULL)
    {
        printf("List is empty\n");
        return;
    }

    temp = last->next;

    do
    {
        if (temp->data == key)
        {
            struct node *newnode = malloc(sizeof(struct node));
            newnode->data = x;
            newnode->next = temp->next;
            temp->next = newnode;

            if (temp == last)
                last = newnode;

            return;
        }

        temp = temp->next;

    } while (temp != last->next);

    printf("Node not found\n");
}

// Delete first node
void delete_first()
{
    struct node *temp;

    if (last == NULL)
    {
        printf("List is empty\n");
        return;
    }

    temp = last->next;

    if (temp == last)
        last = NULL;
    else
        last->next = temp->next;

    free(temp);
}

// Delete last node
void delete_last()
{
    struct node *temp;

    if (last == NULL)
    {
        printf("List is empty\n");
        return;
    }

    temp = last->next;

    if (temp == last)
    {
        free(last);
        last = NULL;
        return;
    }

    while (temp->next != last)
        temp = temp->next;

    temp->next = last->next;
    free(last);
    last = temp;
}

// Delete node after given node
void delete_after(int key)
{
    struct node *temp, *del;

    if (last == NULL)
    {
        printf("List is empty\n");
        return;
    }

    temp = last->next;

    do
    {
        if (temp->data == key)
        {
            del = temp->next;

            if (del == temp)
                last = NULL;
            else
            {
                temp->next = del->next;

                if (del == last)
                    last = temp;
            }

            free(del);
            return;
        }

        temp = temp->next;

    } while (temp != last->next);

    printf("Node not found\n");
}

// Display
void display()
{
    struct node *temp;

    if (last == NULL)
    {
        printf("List is empty\n");
        return;
    }

    temp = last->next;

    do
    {
        printf("%d -> ", temp->data);
        temp = temp->next;
    } while (temp != last->next);

    printf("Back to first node\n");
}

int main()
{
    int ch, x, key;

    while (1)
    {
        printf("\n1.Insert Beginning");
        printf("\n2.Insert End");
        printf("\n3.Insert After");
        printf("\n4.Delete First");
        printf("\n5.Delete Last");
        printf("\n6.Delete After");
        printf("\n7.Display");
        printf("\n8.Exit");

        printf("\nEnter choice: ");
        scanf("%d", &ch);

        switch (ch)
        {
        case 1:
            printf("Enter value: ");
            scanf("%d", &x);
            insert_begin(x);
            break;

        case 2:
            printf("Enter value: ");
            scanf("%d", &x);
            insert_end(x);
            break;

        case 3:
            printf("Enter node: ");
            scanf("%d", &key);
            printf("Enter value: ");
            scanf("%d", &x);
            insert_after(key, x);
            break;

        case 4:
            delete_first();
            break;

        case 5:
            delete_last();
            break;

        case 6:
            printf("Enter node: ");
            scanf("%d", &key);
            delete_after(key);
            break;

        case 7:
            display();
            break;

        case 8:
            exit(0);

        default:
            printf("Invalid choice\n");
        }
    }

    return 0;
}
