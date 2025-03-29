#include <stdio.h>

int main()
{
    int a;
    switch (a)
    {
    case 1:
        printf("Hello 1");
        break;
    case 2:
        printf("Hello 2");
        break;
    case 3:
        printf("Hello 3");
        break;

    default:
        printf("Bye");
        break;
    }

    int n;
    while (n > 0)
    {
        printf("%d", n);
        n--;
    }
}