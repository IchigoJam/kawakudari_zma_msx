# kawakudari for MSX with ZMA

- kawakudari for MSX with [zma](https://github.com/hra1129/zma)
- run on [MIX](https://github.com/ichigojam/MIX)

## tutorial

### make mix.asm

```asm
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
```

### compile and run

```sh
zma mix.asm mix.rom
deno --allow-read --allow-import https://ichigojam.github.io/MIX/rom2sh.js mix.rom | sh
```

## setup for macOS

- [zma](https://github.com/hra1129/zma)
```sh
cd src/linux
make
ls -l zma
```

- [Deno](https://deno.com/)
```sh
curl -fsSL https://deno.land/install.sh | sh
```

## related

- [kawakudari original](https://ichigojam.net/IchigoJam-firstgame.pdf)
- [kawakudari z88dk MSX](https://github.com/ichigojam/kawakudari_z88dk_msx)
- [kawakudari SDCC MSX](https://github.com/ichigojam/kawakudari_sdcc_msx)
- [kawakudari ASM80 MSX](https://github.com/ichigojam/kawakudari_asm80_msx)
