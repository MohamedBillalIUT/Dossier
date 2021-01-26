/************* PROCESSUS CLIENT ***************************/
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <stdlib.h>
#include <unistd.h>

#include <fcntl.h>


int main()
{ int t1 ,t2;
char message[80];
t1 = open("tube1",O_WRONLY);
if (t1 == -1) {
   perror("open t1");
   exit(1);
  }
t2 = open("tube2",O_RDONLY);
if (t2 == -1) {
   perror("open t2");
   exit(1);
  }
strcpy(message, "hello, je suis le processus client");
write(t1,message,strlen(message)) ;
read(t2,message,80) ;
printf("le message recu est :%s\n", message);
close(t1);
close(t2);
exit(0);
}

