// P-9 Develop a program to implement and demonstrate DFS and BFS graph traversal techniques.

#include <stdio.h>

#define MAX 20

int graph[MAX][MAX], visited[MAX];
int queue[MAX], front = 0, rear = -1;
int n;

// DFS using recursion
void DFS(int v) {
    int i;
    visited[v] = 1;
    printf("%d ", v);

    for (i = 0; i < n; i++) {
        if (graph[v][i] == 1 && visited[i] == 0) {
            DFS(i);
        }
    }
}

// BFS using queue
void BFS(int start) {
    int i, v;

    front = 0;
    rear = -1;

    for (i = 0; i < n; i++) {
        visited[i] = 0;
    }

    queue[++rear] = start;
    visited[start] = 1;

    while (front <= rear) {
        v = queue[front++];
        printf("%d ", v);

        for (i = 0; i < n; i++) {
            if (graph[v][i] == 1 && visited[i] == 0) {
                queue[++rear] = i;
                visited[i] = 1;
            }
        }
    }
}

int main() {
    int i, j, start;

    printf("Enter number of vertices: ");
    scanf("%d", &n);

    if (n <= 0 || n > MAX) {
        printf("Invalid number of vertices!");
        return 1;
    }

    printf("Enter adjacency matrix:\n");
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            scanf("%d", &graph[i][j]);
        }
    }

    printf("Enter starting vertex (0 to %d): ", n - 1);
    scanf("%d", &start);

    if (start < 0 || start >= n) {
        printf("Invalid starting vertex!");
        return 1;
    }

    for (i = 0; i < n; i++) {
        visited[i] = 0;
    }

    printf("\nDFS Traversal: ");
    DFS(start);

    printf("\nBFS Traversal: ");
    BFS(start);

    return 0;
}
