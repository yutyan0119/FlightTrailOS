# define UARTADR 0x10000000

void print_int(int i) {
    i %= 10;
    volatile unsigned int * const UART0DR = (unsigned int *)UARTADR;
    *UART0DR = (unsigned int)(i + '0');
}

void print_uart0(const char *s) {
    volatile unsigned int * const UART0DR = (unsigned int *)UARTADR;
    while (*s != '\0') {
        *UART0DR = (unsigned int)(*s);
        s++;
    }
}

int main(){
    print_uart0("Hello world!\n");
    print_int(1);
    return 0;
}
