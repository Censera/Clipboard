{ pkgs }:

pkgs.stdenv.mkDerivation {
    pname = "clipboard";
    version = "1.0.1";

    src = ./.;

    nativeBuildInputs = with pkgs; [ 
        gcc
        pkg-config
    ];

    buildInputs = with pkgs; [
        xorg.libxcb
    ];

    buildPhase = ''
        gcc src/main.c inc/clipboard_x11.c $(pkg-config --cflags --libs xcb) -o bin/clipboard
    '';

    installPhase = ''
        mkdir -p $out/bin
        cp bin/clipboard $out/bin/
    '';
}
