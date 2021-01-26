#include <stdio.h>
#include <stdlib.h>

char tableauGlobal[65536] ;
int tableau2[] = { 2, 3, 5, 7 };

static int f0(int f0_var0)
{
int f0_var1;
f0_var1 = f0_var0 * f0_var0;
return f0_var1;
}

static void f1(int f1_v0)
{
    printf("Le carre de %d est %d\n", f1_v0, f0(f1_v0));
    if (f1_v0 < 1000)
        {
            int f1_v1;
            f1_v1 = f1_v0 * f1_v0 * f1_v0;
            printf("Le cube de %d est %d\n", f1_v0, f1_v1);
        }
}

int main(int argc, char *argv[])
{
    static int main_v0 = 9973;
    static char main_v1[10240000];
    char *main_v2;
    main_v2 = malloc(1024);
    f1(main_v0);
    exit(0);
}
