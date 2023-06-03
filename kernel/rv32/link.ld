OUTPUT_ARCH("riscv")
ENTRY(boot)

SECTIONS
{
    . = 0x80000000;
    .text : {
      __text = .;
      KEEP(*(.boot));
      . = ALIGN(4);
      *(.text .text.*);
      . = ALIGN(4096);
      __text_end = .;
    }

    __data = .;
    .rodata : {
        *(.rodata .rodata.*);
        . = ALIGN(4);
        *(.srodata .srodata.*);
        . = ALIGN(4096);
        __rodata_end = .;
    }
    .data : {
        . = ALIGN(4);
        *(.data .data.*);
        . = ALIGN(16);
        *(.sdata .sdata.*);
    }
    .bss : {
      __bss = .;
      *(.bss .bss.*);
      . = ALIGN(16);
      *(.sbss .sbss.*);
      __bss_end = .;
      . = ALIGN(4096);
      stack_top = .;
      . = . + 16384;
    }

    . = ALIGN(4096);
    __data_end = .;
}
