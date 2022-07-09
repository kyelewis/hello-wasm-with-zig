{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = { self, nixpkgs }: 
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in with pkgs; {
      devShells.x86_64-linux.default = mkShell {
        buildInputs = [ zig wasmtime ];
      };
    };
}
    