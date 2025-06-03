  org 0x4000
  dw 0x4241, 0x4010, 0, 0, 0, 0, 0, 0

main:
  ; cls
  call cls

  ; a = 15
  ld a, 15
  push af

loop_game:
  ; lc a, 5
  pop af
  ld h, a
  ld l, 5
  push af
  call locate
  
  ; print "O"
  ;ld a, 79 ; O
  ld a, 236 ; neko
  call putchar

  ; lc rnd(32)+1,24
  ld a, r ; random
  and 31
  inc a
  ld h, a
  ld l, 24
  call locate

  ; print "*"
  ld a, '*'
  call putchar

  call scrolldown

  ; wait 6  
  ld a, 6
  call wait

  ; a = a - btn(7) + btn(3)
  call inkey
  cp 3
  jr nz, skip1
  pop af
  inc a
  push af
  jr skip3
skip1:
  cp 7
  jr nz, skip3
  pop af
  dec a
  push af
skip3:

  ; if scr(a, 5)!=asc("*") goto loop_game
  pop af
  ld h, a
  ld l, 5
  push af
  call scr
  cp '*'
  jr nz, loop_game

  ; wait 200
  ld a, 200
  call wait

  ; run
  jr main

inkey: ; a: 1=up, 2=right up, 3=right, 4=right down, 5=down, 6=left down, 7=left, 8=left up
  ld a, 0
  call 0x00D5
  ret

scr: ; h: X, l: y
  dec h
  dec l
  ld d, h
  ld e, l
  ld c, l
  ld b, 0

  ; bc <<= 5
  SLA C
  RL  B
  SLA C
  RL  B
  SLA C
  RL  B
  SLA C
  RL  B
  SLA C
  RL  B

  ; bc += d
  ld a, c
  add a, d
  ld c, a
  jp nc, scr_skip
  inc b
scr_skip:

  ld hl, 0x1800
  add hl, bc

  call 0x004A
  ret

scrolldown:
  ld h, 1
  ld l, 24
  call locate
  ld a, 10; enter
  call putchar
  ld a, 13; enter
  call putchar
  ret

wait: ; count: a
  ld b, 255
wait_loop:
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  djnz wait_loop
  dec a
  or a
  jr nz, wait
  ret

locate: ; H: x, L: y
  call 0x00C6   ; POSIT（カーソル表示と位置制御に関わる）
  ret

putchar: ; A: char
  call 0x00A2   ; CHPUT
  ret

width32:
  ld a, 32     ;WIDTH=32
  ld [0xF3AF], a
  ret

cls:
  call width32 ; width 32
  ld a, 1
  call 0x005F   ; CHGMOD - スクリーンモード切替
  call 0x00C3   ; CLS - 画面全体をクリア
  ret
