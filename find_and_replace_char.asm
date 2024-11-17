; MASM program to get a string from user and replace a particular character present in the string with a new character given by user

assume cs:code,ds:data
data segment
    arr db 100 dup(?)
    arr2 db 1 dup(?)

    msg1 db "Enter the string: $"
    msg2 db "Enter the new character: $"
    msg3 db 10,13,"Enter character to be searched: $"
    msg4 db 10,13,"Modified string is: $"
    newline db 10,13,"$"
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


code segment
start:
  mov ax,data
  mov ds,ax

  disps msg1

  lea si,arr
  lea di,arr2

  mov cl,00
  mov ch,00

read_string:
  readc
  cmp al,0dh  ; check if "enter" key is pressed
  jz read_replacement_char
  mov [si],al
  inc cl
  inc si
  jmp read_string

read_replacement_char:
  disps msg2
  readc
  mov [di],al

read_search_char:
  disps msg3
  readc  ; search chara in al

prep:
  lea si, arr  ; point to first place of arr
  mov ch,cl    ; copy the value of count to ch

start_check:
  mov bl,[si]  ; character of string in bl
  cmp al,bl    ; compare currect chara to search chara
  jz replace   ; replace to new chara if it matches
  inc si       ; mov to next chara in string
  dec cl       ; decrement count

  cmp cl,00h
  jnz start_check ; if count not zero loop again
  jmp set_start   ; jump to display part when over

replace:
  lea di,arr2
  mov bh,[di]  ; bh has replacement character
  mov [si],bh

  inc si
  dec cl
  cmp cl,00h
  jnz start_check ; if count not zero loop again
  jmp set_start   ; jump to display part when over



set_start:
  disps msg4
  lea si,arr  ; setting to start

display:
  mov dl,[si]
  mov ah,02h
  int 21h

  inc si
  dec ch

  cmp ch,00h
  jnz display



mov ah, 4Ch
int 21h
code ends
end start