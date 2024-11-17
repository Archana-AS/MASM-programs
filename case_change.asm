assume cs:code, ds:data

data  segment
  arr db 20 DUP(0)
  n1 db 0ah,0dh,"enter the word :$"
  n2 db 0ah,0dh,"The converted word is:$"
data ends

code segment
start:
  mov ax,data
  mov ds,ax

  lea dx,n1
  mov ah,09h
  int 21h

  lea si,arr
  mov cl,00h

l1: 
  mov ah,01h
  int 21h
  cmp al,0dh
  jz l6
  cmp al,41h
  jc l2
  cmp al,5bh
  jc l3
  cmp al,61h
  jc l2
  cmp al,7bh
  jc l4
  jmp l6

l2: 
  mov [si],al
  jmp l5

l3: 
  add al,20h
  mov [si], al
  jmp l5

l4: 
  sub al,20h
  mov[si],al
  jmp l5

l5: 
  inc si
  inc cl
  jnz l1

l6: 
  lea dx,n2
  mov ah,09h
  int 21h
  lea si,arr

l7: 
  mov dl,[si]
  mov ah,02h
  int 21h
  inc si
  dec cl
  jnz l7
  mov ah,4ch
  int 21h

code ends
end start