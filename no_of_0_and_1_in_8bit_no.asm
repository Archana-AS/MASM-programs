; number of 0's and 1's in the binary representation an 8 bit number 

assume cs:code,ds:data
data segment
    g1 db 0dh, 0ah, "Enter the number: $"
    c0 db 0dh, 0ah, "Number of 0s: $"
    c1 db 0dh, 0ah, "Number of 1s: $"
    nl db 0dh, 0ah, "$"
data ends

disps macro msg
  lea dx,msg
  mov ah,09h
  int 21h
endm

readc macro
  mov ah,01h
  int 21h
endm

readnum macro
  readc
  sub al,30h
endm

code segment
start:
    mov ax, data
    mov ds, ax

    mov bl, 8 ; Loop counter for 8-bit number
    mov cl, 0 ; Zero count
    mov ch, 0 ; One count

user_input:
  disps g1
  readnum
  mov dl,10
  mul dl
  mov dl,al
  readnum
  add dl,al ; now dl has 2 digit no
  mov al,dl


find_start:
  shl al,1
  dec bl
  jnc find_start ; if bit is 0
  inc ch   ; here we only start counting after seeing the first 1

loop1:
    shl al, 1 ; Shift left by 1 bit
    jnc zero_bit ; Jump if carry flag is 0 (bit is 0)
    inc ch ; Increment one count
    jmp next_bit

zero_bit:
    inc cl ; Increment zero count

next_bit:
    dec bl
    jnz loop1

; Display the counts
disps c0
mov dl, cl
add dl, 30h
mov ah, 02h
int 21h

disps c1
mov dl, ch
add dl, 30h
mov ah, 02h
int 21h

mov ah, 4Ch
int 21h
code ends
end start