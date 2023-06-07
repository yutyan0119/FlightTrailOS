#pragma once

void task_switch_rv32(unsigned int* old_sp, unsigned int new_sp);
void task_load_rv32(unsigned int* sp);
