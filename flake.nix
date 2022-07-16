{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/fa36ef2f25b1357feb17d7e702c6be4397647ee2";
  };
  outputs = { self, nixpkgs }: 
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in with pkgs; {
      devShells.x86_64-linux.default = mkShell {
        buildInputs = [ zig nodejs-18_x nodePackages.pnpm ];
      };
    };
}
    
