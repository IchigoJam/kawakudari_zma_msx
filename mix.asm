  org 0x4000
  dw 0x4241, 0x4010, 0, 0, 0, 0, 0, 0

  ld a, 'M'
  call 0x00A2
  ld a, 'I'
  call 0x00A2
  ld a, 'X'
  call 0x00A2

loop:
  jr loop
