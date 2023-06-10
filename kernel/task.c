#include "switch.h"
#include "task.h"

void task_switch(task_info* current, task_info* next) {
    task_switch_rv32(&current->sp, (unsigned int)&next->sp);
}

void task_load(task_info* task) {
    task_load_rv32(&task->sp);
}

void task_create(task_info* task, void (*entry)(void), int pid) {
    task->pid = pid;
    //タスクのスタックポインタを設定
    task->sp = (unsigned int)&(task->stack[4096]);
    // stack pointerをずらしながら、レジスタの初期値を設定していく
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s11
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s10
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s9
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s8
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s7
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s6
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s5
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s4
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s3
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s2
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s1
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = 0; // s0
    task->sp -= sizeof(unsigned int);
    *((unsigned int*)(task->sp)) = (unsigned int)entry; // ra
    return;
}
