# Clipboard

Clipboard is a minimal CLI utility written in C. It allows you to pipe streams or pass arguments directly into an available system clipboard.


The utility requires `libclipboard` installed on your system.

- Ubuntu/Debian: `sudo apt install libclipboard-dev`
- Arch Linux: `sudo pacman -S libclipboard`

- NixOs:

```bash
nix develop
```

Once inside the development shell, run:

```bash
gcc main.c -lclipboard -o bin/clipboard
```

## Usage

1. Copying via arguments

```bash
./bin/clipboard "Copy me."
```

2. Copying via piping

```bash
echo "Hello, me!" | ./bin/clipboard
```

```bash
cat file.txt | ./bin/clipboard
```
