PREFIX=riscv32-unknown-elf-
CC=$(PREFIX)gcc
LD=$(PREFIX)ld
AS=$(PREFIX)as

BASE_CFLAGS=-fno-stack-protector -fno-zero-initialized-in-bss -ffreestanding
OPT_CFLAGS=-fno-builtin -nostdlib -nodefaultlibs -nostartfiles -mstrict-align
WARN_CFLAGS=-Wall -Wextra
ARCH_CFLAGS=-march=rv32im

CFLAGS=$(BASE_CFLAGS) $(OPT_CFLAGS) $(WARN_CFLAGS) $(ARCH_CFLAGS)
ASFLAGS=-march=rv32im
LDFLAGS=-Tkernel/rv32/link.ld

C_SRC=$(wildcard kernel/*.c kernel/rv32/*.c)
S_SRC=$(wildcard kernel/*.S kernel/rv32/*.S)
OBJ_FILES=$(C_SRC:.c=.o) $(S_SRC:.S=.o)

kernel/kernel: $(OBJ_FILES)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.c Makefile
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.S Makefile
	$(AS) $(ASFLAGS) -c -o $@ $<

clean:
	rm -rf $(OBJ_FILES) kernel/kernel

run: kernel/kernel
	qemu-system-riscv32 -smp 1 -nographic -serial mon:stdio --no-reboot -m 128 -machine virt,aclint=on -bios none -kernel kernel/kernel

.PHONY: clean run
