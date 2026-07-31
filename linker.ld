ENTRY(_start)

SECTIONS
{
    . = 0x80000;

    .text :
    {
        *(.text*)
    }

    . = ALIGN(16);
    .data :
    {
        *(.data*)
    }

    . = ALIGN(16);
    .bss :
    {
        _bss_start_ = .;
        *(.bss*)
        *(COMMON)
        _bss_end_ = .;
    }

    _kernel_end_ = .;
    . += 0x4000;
    _stack_top_ = .; 
}


