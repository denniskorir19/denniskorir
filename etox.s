#Dennis Korir

         .text
         .globl  main
  
main:
 # get x
        li      $v0,4               # print value entered
        la      $a0,invalue         #
        syscall
        li      $v0,6               # read single
        syscall                     # $f0 <-- x

# Initialize registers        
        mov.s   $f1,$f0             # $f1 <-- x
        mul.s   $f2,$f1,$f1         # $f2 <-- x^2
        li.s    $f3,1.0             # initialize n to 1
        li.s    $f21, 1.0           # for getting the next value of n in the Taylor series
        li.s    $f22, -1.0          # for getting n-1, and for the value in the Taylor series
        mov.s   $f7,$f1             # initialize current term to x
        abs.s   $f8,$f1             # initialize absolute current term to |x|
        mov.s   $f9,$f1             # initialize e^x to x

# Loop until n gets to 18
loop:   c.eq.d  $f3,18              # is n < 18?
        bc1t    done                # if so, then loop is done
        
        add.s   $f3,$f3,$f21        # add 1.0 to n, for current n
        add.s   $f4,$f3,$f22        # add -1.0 to n, for current n-1
        mul.s   $f5,$f3,$f4         # get n(n-1) 
        div.s   $f6,$f2,$f5         # get x^2/n(n-1)
        mul.s   $f7,$f7,$f6         # get current term, x^n/n(n-1)
        abs.s   $f8,$f7             # get the absolute of current term to test
        add.s   $f9,$f9,$f7         # add the current term to the sum
        
        j       loop                #
         
# print e^x
done: 
        li      $v0,4               # print output message
        la      $a0,outvalue          #
        syscall
        
        mov.s     $f12,$f9          # load the float argument
        li      $v0,2               # code 2 == print float
        syscall                     #

        li      $v0,10              # exit
        syscall

         .data
invalue:  .asciiz "Enter a floating point value for x: "
outvalue:   .asciiz "e^x= "

