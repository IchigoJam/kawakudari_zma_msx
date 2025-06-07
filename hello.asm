  org 0x4000
  dw 0x4241, 0x4010, 0, 0, 0, 0, 0, 0

init:
  call cls

  ld hl, message
  call puts

Loop:
  jr Loop

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

puts:
  ld a, [hl]
  or a
  ret z
  call 0x00A2   ; BIOSの CHPUT
  inc hl
  jr puts

message:
  db "Hello! MSX with zma"
  db 13, 10, 0
