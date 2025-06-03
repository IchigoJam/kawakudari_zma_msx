zma $1.asm $1.rom
deno --allow-read --allow-import https://ichigojam.github.io/MIX/rom2sh.js $1.rom | sh
