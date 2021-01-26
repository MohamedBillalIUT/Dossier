#include "../generic/myalloc.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>  

#define TAILLE_MAX 1024

int main(int argc, char* argv[])
{
  printf("[%s] lancee\n",argv[0]);
  //allocation d'un tableau
  srand (time(NULL));
  int taille = 1 + (rand() % TAILLE_MAX);
  int* buffer = (int*)myalloc(taille*sizeof(int));
  printf("allocation de %d entiers (%d octect par entier) à: %p \n",taille,sizeof(int),(void*)buffer);
  int i ;
  for( i = 0; i < taille ; i++)
    {
      buffer[i] = taille-i;
    }  
  for( i = 0; i < taille ; i++)
    {
      assert(buffer[i] == taille-i);
    }
  blocinfo(buffer);
  myfree(buffer);
  blocinfo(buffer);
  printf("[%s] termine\n",argv[0]);
}
