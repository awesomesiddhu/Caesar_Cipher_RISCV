.data
msg: .string "This is the message"

.text

li x20,97 #a
li x21,122 #z
li x22,65 #A
li x23,90 #Z

# Load the address of the string into register x5
la x5, msg

# Load the address of the destination into register x6
li x6, 0x200

# Load the shift value into register x7
li x7, 3

# Loop over the string until null character is found
loop:

# Load a byte from the string into register x8
lb x8, 0(x5)

# Check if it is null
beq x8, x0, end

# Check if it is a lowercase letter
blt x8, x20, upper
bge x8, x21, upper

# Encrypt or decrypt the lowercase letter by adding or subtracting the shift
add x8, x8, x7 # change to add for encryption
blt x8, x20, wrap_low
bge x8, x21, wrap_low
j store

# Wrap around the lowercase letter if it goes beyond the range
wrap_low:
addi x8, x8, -26 # change to -26 for encryption
j store

# Check if it is an uppercase letter
upper:
blt x8, x22, store
bge x8, x23, store

# Encrypt or decrypt the uppercase letter by adding or subtracting the shift
add x8, x8, x7 # change to add for encryption
blt x8, x22, wrap_up
bge x8, x23, wrap_up
j store

# Wrap around the uppercase letter if it goes beyond the range
wrap_up:
addi x8, x8, -26 # change to -26 for encryption
j store

# Store the encrypted or decrypted byte into the destination
store:
sb x8, 0(x6)

# Increment the source and destination pointers
addi x5, x5, 1
addi x6, x6, 1

# Go back to the loop
j loop

# End of the program
end:
nop
