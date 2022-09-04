TCP-SERVER:

#include<stdio.h>
#include<stdlib.h>

#include<string.h>
#include<unistd.h>
#include<arpa/inet.h>

#include<sys/socket.h>
#include<sys/types.h>
#include<netdb.h>

int main()
{
    int server_socket,comm_fd;
    char recvline[100];
    server_socket = socket(AF_INET,SOCK_STREAM,0);
    
    struct sockaddr_in servaddr;
    bzero(&servaddr,sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(9002);
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    
    bind(server_socket,(struct sockaddr*)&servaddr,sizeof(servaddr));
    listen(server_socket,10);
    while(1){
        
        comm_fd = accept(server_socket,(struct sockaddr*)NULL, NULL);
        bzero(recvline,100);
        recv(comm_fd,recvline,100,0);
        printf("CLIENT MESSAGE : %s",recvline);
        close(comm_fd);
    }
    return 0;
}


Tcp-client:
#include<stdio.h>
#include<stdlib.h>

#include<string.h>
#include<unistd.h>
#include<arpa/inet.h>

#include<sys/socket.h>
#include<sys/types.h>
#include<netdb.h>

int main()
{
    int server_socket;
    char sendline[100];
    server_socket = socket(AF_INET,SOCK_STREAM,0);
    
    struct sockaddr_in servaddr;
    bzero(&servaddr,sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(9002);
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    connect(server_socket,(struct sockaddr*)&servaddr,sizeof(servaddr));
    
    while(1){
        
        bzero(sendline,100);
        fgets(sendline,100,stdin);
        send(server_socket,sendline,100,0);
    }
    return 0;
}


UDP-SERVER:

#include<stdio.h>
#include<stdlib.h>

#include<string.h>
#include<unistd.h>
#include<arpa/inet.h>

#include<sys/socket.h>
#include<sys/types.h>
#include<netdb.h>

int main()
{
    int server_socket;
    char recvline[100];
    server_socket = socket(AF_INET,SOCK_DGRAM,0);
    
    struct sockaddr_in servaddr;
    bzero(&servaddr,sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(10000);
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    
    bind(server_socket,(struct sockaddr*)&servaddr,sizeof(servaddr));
    
    while(1){
        
        bzero(recvline,100);
        recvfrom(server_socket,recvline,100,0,(struct sockaddr*)&servaddr,sizeof(servaddr));
        printf("CLIENT MESSAGE : %s",recvline);
        }
    return 0;
}

UDP-client:
#include<stdio.h>
#include<stdlib.h>

#include<string.h>
#include<unistd.h>
#include<arpa/inet.h>

#include<sys/socket.h>
#include<sys/types.h>
#include<netdb.h>

int main()
{
    int server_socket;
    char sendline[100];
    server_socket = socket(AF_INET,SOCK_DGRAM,0);
    
    struct sockaddr_in servaddr;
    bzero(&servaddr,sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(10000);
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    while(1){
        
        bzero(sendline,100);
        fgets(sendline,100,stdin);
        sendto(server_socket,sendline,100,0,(struct sockaddr*)&servaddr,sizeof(servaddr)); 
        
    }
    return 0;
}