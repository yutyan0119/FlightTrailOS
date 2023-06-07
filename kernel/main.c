#include "task.h"
#include "switch.h"

task_info task_list[2];

#define UARTADR 0x10000000

void print_int(int i) {
    i %= 10;
    volatile unsigned int *const UART0DR = (unsigned int *)UARTADR;
    *UART0DR = (unsigned int)(i + '0');
}

void print_uart0(const char *s) {
    volatile unsigned int *const UART0DR = (unsigned int *)UARTADR;
    while (*s != '\0') {
        *UART0DR = (unsigned int)(*s);
        s++;
    }
}

void clear_bss() {
    extern unsigned int* __bss_start, __bss_end;
    unsigned int start = (unsigned int)__bss_start;
    unsigned int end = (unsigned int)__bss_end;
    while (start < end) {
        *(unsigned int*)start = 0;
        start ++;
    }
}

void task_1() {
    int i = 0;
    while (1) {
        print_uart0("task_1 ");
        print_int(i);
        print_uart0("\n");
        i++;
        task_switch(&task_list[0], &task_list[1]);
    }
}

void task_2() {
    int i = 2;
    while (1) {
        print_uart0("task_2 ");
        print_int(i);
        print_uart0("\n");
        i++;
        task_switch(&task_list[1], &task_list[0]);
    }
}

int main() {
    clear_bss();
    print_uart0("Hello world!\n");
    print_int(1);
    task_create(&task_list[0], task_1, 0);
    task_create(&task_list[1], task_2, 1);
    task_load_rv32(&task_list[0].sp);
    return 0;
}
