{ pkgs }:

pkgs.stdenv.mkDerivation {
    pname = "clipboard";
    version = "1.0.1";

    src = ./.;

    nativeBuildInputs = with pkgs; [ 
        clang
        pkg-config
    ];

    buildInputs = with pkgs; [
        xorg.libxcb
    ];

    buildPhase = ''
        clang src/main.c inc/clipboard_x11.c $(pkg-config --cflags --libs xcb) -o bin/clipboard
    '';

    installPhase = ''
        mkdir -p $out/bin
        cp bin/clipboard $out/bin/
    '';
}
