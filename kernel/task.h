#pragma once

typedef struct task_info {
    int pid;
    unsigned int stack[4096];
    unsigned int sp;
} task_info;

void task_switch(task_info* current, task_info* next);

void task_load(task_info* task);

void task_create(task_info* task, void (*entry)(void), int pid);
