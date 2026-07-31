.globl _start
.section .text

_start:
    ldr x0,=_stack_top_
    mrs x1,SPSel
    cmp x1,#1
    beq sp_el1
sp_el0:
    msr SPSel,#1
sp_el1:
    mov sp,x0
zero_bss:
    ldr x0,=_bss_start_
    ldr x1,=_bss_end_
    mov x2,#0
loop:
    cmp x0,x1
    bge done
    str x2,[x0]
    add x0,x0,#8
    b loop

done:
    bl main
