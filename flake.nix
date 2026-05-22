{
	description = "Clipboard";

	inputs = {
	nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	};

	outputs = { self, nixpkgs }:
	let
	supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

	forEachSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f (import nixpkgs { inherit system; }));
	in
	{
		devShells = forEachSystem (pkgs: {
			default = pkgs.mkShell {

				nativeBuildInputs = with pkgs; [
					gcc
					gnumake
					pkg-config
				];

				buildInputs = with pkgs; [
					libclipboard
					xorg.libX11
				];

				shellHook = ''
					echo 'Run: gcc main.c -libclipboard -o bin/clipboard'
				'';
			};
		});
	};
}
