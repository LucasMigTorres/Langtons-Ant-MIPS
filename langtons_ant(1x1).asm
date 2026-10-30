#--------------------------------------
# Langton's Ant by Lucas Torres
#--------------------------------------

.data

# Display dimensions in pixels: 512 x 512
imageBuffer: .space 0x100000	# Allocate space for 512 * 512 * 4

.text

.globl main

main:
    la $t0, imageBuffer		# Base address for display
    li $t1, 0xFFFFFF		# Color: White in 24-bit RGB
    li $t2, 262144		# 262144 pixels (1x1 unit in pixels)
    li $t3, 0			# Counter
    
    # Make display background white
    fill_display_loop:
        sw $t1, ($t0)				# Paint pixel
        addiu $t0, $t0, 4			# Set pointer to next pixel
        addiu $t3, $t3, 1			# Increment counter
        bne $t3, $t2, fill_display_loop		# Loop to start until last pixel is reached
    
    # Load starting values for x and y
    li $a0, 256		# Middle x value (1x1 unit in pixels)
    li $a1, 256		# Middle y value (1x1 unit in pixels)
    
    li $a2, 0xFFFFFF	# Color: White in 24-bit RGB
    li $a3, 0x000000	# Color: Black in 24-bit RGB
    
    jal langtons_ant	# Call langtons_ant procedure
    
    # Exit after returning
    li $v0, 10
    syscall
    
    langtons_ant:
    	move $s0, $a0		# Save x value to $s0
    	move $s1, $a1		# Save y value to $s1
    
    	la $t0, imageBuffer	# Base address for display
        sll $a0, $a0, 2		# Scale x to bytes (4 bytes per pixel)
        sll $a1, $a1, 11	# Scale y to bytes (512 * 4 bytes per row)
        
        addu $t1, $a1, $t0	# Row starting address (base + y-scaled)
        addu $t1, $a0, $t1	# Starting pixel address (base + y-scaled + x-scaled)
        
        li $t2, 2		# Starting direction
        
        li $a0, 1		# Wait time in milliseconds
        
        ant_loop:
            lw $t3, ($t1)		# Get color of current pixel
            
            # If current pixel is white:
            white_pixel:
            	bne $t3, $a2, black_pixel	# Branch to black_pixel if current pixel is not white
            	addi $t2, $t2, -1		# Decrement direction (turn 90 degrees clockwise)
            	sw $a3, ($t1)			# Flip pixel to black
            	
            	slti $t3, $t2, 0        	# If direction < 0, $t3 = 1; 0 otherwise (direction >= 0)
            	beq $t3, $zero, if_end		# Branch to if_end if $t3 == 0 (direction >= 0)
            	li $t2, 3			# If direction < 0, set to 3
            	j if_end			# Jump to if_end (skip second conditional block)
            
            # Current pixel is black (given it is not white)
            black_pixel:
            	addi $t2, $t2, 1		# Increment direction (turn 90 degrees counter-clockwise)
            	sw $a2, ($t1)			# Flip pixel to white
                
            	slti $t3, $t2, 4        	# If direction < 4, $t3 = 1; 0 otherwise (direction > 3)
            	bne $t3, $zero, if_end		# Branch to if_end if $t3 != 0 (direction <= 3)
            	li $t2, 0			# If direction > 3, set to 0
            
            if_end:			# End of both conditional blocks
            
            beq $t2, 0, case_1		# If direction is 0, go to case_1 (move right)
            beq $t2, 1, case_2		# If direction is 1, go to case_2 (move up)
            beq $t2, 2, case_3		# If direction is 2, go to case_3 (move left)
            beq $t2, 3, case_4		# If direction is 3, go to case_4 (move down)
            
            case_1:
            	addi $t1, $t1, 4	# Move one pixel to the right
            	addi $s0, $s0, 1	# Increment x
            	j break_switch
            case_2:
            	addi $t1, $t1, -2048	# Move one pixel up
            	addi $s1, $s1, -1	# Decrement y
            	j break_switch
            case_3:
            	addi $t1, $t1, -4	# Move one pixel to the left
            	addi $s0, $s0, -1	# Decrement x
            	j break_switch
            case_4:
            	addi $t1, $t1, 2048	# Move one pixel down
            	addi $s1, $s1, 1	# Increment y
            break_switch:
            
            li $v0, 32			# syscall 32: pause program execution
            syscall
            
            beq $s0, 512, ant_loop_end		# Break loop if right edge of display is reached
            beq $s1, 512, ant_loop_end		# Break loop if bottom edge of display is reached
            j ant_loop
        ant_loop_end:
            
        jr $ra	# Return to caller
        
