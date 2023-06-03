CC=riscv32-unknown-elf-gcc
LD=riscv32-unknown-elf-ld
AS=riscv32-unknown-elf-as

CFLAGS=-fno-stack-protector -fno-zero-initialized-in-bss -ffreestanding -fno-builtin -nostdlib -nodefaultlibs -nostartfiles -mstrict-align -march=rv32i -Wall -Wextra
ASFLAGS=-march=rv32i
LDFLAGS=-Tkernel/rv32/link.ld

kernel/kernel: kernel/main.o kernel/rv32/boot.o
	$(LD) $(LDFLAGS) -o $@ $^

kernel/main.o: kernel/main.c
	$(CC) $(CFLAGS) -c -o $@ $<

kernel/rv32/boot.o: kernel/rv32/boot.S
	$(AS) $(ASFLAGS) -c -o $@ $<

clean:
	rm -rf kernel/*.o kernel/rv32/*.o kernel/kernel

.PHONY: clean
