#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

int main(int argc, char* argv[]){

        if (argc <2){
                printf("There is no arguments!\n");
                exit(-1);
        }
        int fd, pipe_fd[2];
        pid_t t;
        umask(0);
        char * buff = calloc(1000,1);
        int result = mkfifo("file.fifo", 0666);
        if (result < 0){
                perror("mkfifo");
                exit(-1);
        }
        printf("fifo's created\n");

        fd = open ("file.fifo", O_WRONLY);
        if (fd <0){
                perror("open");
                exit(-1);
        }

        printf("starts from %d \n", fd);
        close(0);
        close(1);
        t = pipe(pipe_fd);
        if (t < 0){
        perror("pipe");
        exit(-1);
        }
        printf("pipe works\n");
        result = fork();
        if (result < 0){
                perror("fork");
                exit(-1);
        }
        else if (result > 0){
                execl("/bin/ls", "ls", argv[1], "-a", NULL);
                printf("execl works \n");
        }
        else {
                close(1);
                int len = read(0, buff, 1000);
                result = write(fd, buff, len);
                if (result < 0){
                        perror("write");
                        exit(-1);
                }
        }
        printf("success\n");
        close(fd);
        
}
