Author: Dennis Korir


int f(int a, int b, int c, int d) {
    return func(func(a,b), c+d);
}

func:
    addi $sp, $sp, -8      	   # Make space for $t0 and $t1
    sw   $t1, 4($sp)      	   # Save previous values of $t1
    sw   $t0, 0($sp)      	   # Save previous values of $t0
    add $t0, $a0, $a1     	   # $t0 < $a0 + $a1
    add $t1, $a2, $a3              # $t1 < $a2 + $a3
    
    bgt $t0, $t1 valueLarger       # if $t0 > $t1 jump to label valueLarger
    add $v0, $0, $t1               # Comes here if $t0 <= $t1
                                   # save value of $t1 to $v0
    j   cleanup
valueLarger:
    add $v0, $0, $t0       	   # $t0 was greater than $t1, so save $t0 in $v0
    j    cleanup
cleanup:
    lw   $t0, 0($sp)              # Restore $t0 to previous value
    lw   $t1, 4($sp)              # Restore $t1 to previous value
    addi $sp, $sp, 8              # Cleanup the space taken
    jr   $ra                      # Return to the caller