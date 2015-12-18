#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char* argv[]){
        int fd;
        char* buf  = calloc(100, 1);
        fd = open("file.fifo", O_RDONLY);
        if (fd < 0){
                perror("open");
                exit(-1);
        }
        printf("fifo is opened again \n");
        int rd = read(fd, buf, 100);
        if (rd < 0){
                perror("read");
                exit(-1);
        }
        printf("%s works well \n", buf);

        remove("file.fifo");
}
