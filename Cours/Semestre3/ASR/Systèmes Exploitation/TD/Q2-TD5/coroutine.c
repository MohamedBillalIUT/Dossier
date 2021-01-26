#include  <stdio.h>
#include <stdlib.h> 
#include  <setjmp.h>

int       max_tour;
int       compteurPing;    
//??

jmp_buf   ancreMain;
jmp_buf   ancrePing;
//??

void      Ping(void);
void      Pong(void);

void  main(int  argc, char* argv[])
{
     if (argc != 2) { 
          printf("Usage %s <nombre-iteraction>\n", argv[0]);
          exit(1);
     }
     max_tour = abs(atoi(argv[1]));
     compteurPing = 1; 
     
     printf("\t((Main 0))\n");
     
     if(setjmp(ancreMain) == 0)
       {
	 //create de l'ancre
	 Ping();
       } 
     printf("\t((Main 1))\n");
     longjmp(ancrePing, 1);

}
void  Ping(void)
{
  printf("Initialisation de Ping\n");
  if (setjmp(ancrePing) == 0) 
    {//creation de l'ancre
      longjmp(ancreMain, 1);// retour au main
    }
  // ici nous venons d un jump !
  while (1) 
    {  
      printf("%3d:\t<<Ping>\n", compteurPing);
      compteurPing++;   
      if (compteurPing > max_tour) {exit(0);}               
//      if (setjmp(ancrePing) == 0)  
	{ // creation de l'ancre
	  longjmp(ancreMain, 1);   //on cede le controle a la fonction main
	}
    }
}

void  Pong(void)
{
  //??
  printf(">>Pong<<\n");   //
  //??
}
