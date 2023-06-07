.align 4
.global task_switch_rv32
.global task_load_rv32

# a0には切り替え元のspアドレスが入っている
# a1には切り替え先のspアドレスが入っている

task_switch_rv32:
# レジスタを保存する分だけスタックを確保する
    addi sp,  sp, -13*4

# スタックにレジスタを保存する
    sw   ra,  0*4(sp)
    sw   s0,  1*4(sp)
    sw   s1,  2*4(sp)
    sw   s2,  3*4(sp)
    sw   s3,  4*4(sp)
    sw   s4,  5*4(sp)
    sw   s5,  6*4(sp)
    sw   s6,  7*4(sp)
    sw   s7,  8*4(sp)
    sw   s8,  9*4(sp)
    sw   s9,  10*4(sp)
    sw   s10, 11*4(sp)
    sw   s11, 12*4(sp)

# スタックポインタを保存する    
    sw   sp,  (a0)

# スタックポインタを復元する
    lw   sp,  (a1)

# レジスタを復元する
    lw   ra,  0*4(sp)
    lw   s0,  1*4(sp)
    lw   s1,  2*4(sp)
    lw   s2,  3*4(sp)
    lw   s3,  4*4(sp)
    lw   s4,  5*4(sp)
    lw   s5,  6*4(sp)
    lw   s6,  7*4(sp)
    lw   s7,  8*4(sp)
    lw   s8,  9*4(sp)
    lw   s9,  10*4(sp)
    lw   s10, 11*4(sp)
    lw   s11, 12*4(sp)

# スタックを解放する
    addi sp,  sp, 13*4

# 戻る
    ret

task_load_rv32:
    lw  sp,  (a0)
    lw   ra,  0*4(sp)
    lw   s0,  1*4(sp)
    lw   s1,  2*4(sp)
    lw   s2,  3*4(sp)
    lw   s3,  4*4(sp)
    lw   s4,  5*4(sp)
    lw   s5,  6*4(sp)
    lw   s6,  7*4(sp)
    lw   s7,  8*4(sp)
    lw   s8,  9*4(sp)
    lw   s9,  10*4(sp)
    lw   s10, 11*4(sp)
    lw   s11, 12*4(sp)
    addi sp,  sp, 13*4
    ret
