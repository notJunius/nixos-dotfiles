{
  description = "A reproducible development environment for a Go (golang) Raylib project.";

  inputs = {
    # Nixpkgs provides the core packages (Go, Raylib, etc.)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      # Define the target system architecture
      supportedSystems = [
        "x86_64-linux"
      ];

      # A function to generate the pkgs set for each system
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      # Development Shell
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true; # Set to true if you need proprietary software
          };

          # List of necessary packages for development and Raylib compilation
          buildInputs = with pkgs; [
            go_1_25
            raylib # The core Raylib C library

            # C/C++ build tools often needed for CGO (required by raylib-go)
            gcc
            raylib
            gcc
            pkg-config
            libxkbcommon
            wayland # Provides the missing wayland-client-core.h
            xorg.libXrandr
            xorg.libXcursor
            xorg.libXext
            xorg.libXft
            xorg.libXi
            xorg.libXinerama
            pkg-config
          ];

        in
        {
          default = pkgs.mkShell {
            # Use 'raylib-go-env' as a clear name for the environment
            name = "raylib shell";

            # Set environment variables for CGO/Raylib to link correctly
            shellHook = ''
              # Point pkg-config to find the Raylib libraries
              export PKG_CONFIG_PATH=${pkgs.raylib}/lib/pkgconfig:$PKG_CONFIG_PATH

              # Inform the Go linker where to find the Raylib library
              export CGO_LDFLAGS="-lraylib"

              echo "Go Raylib development environment ready! Start coding."
              echo "Use 'go run .' or 'go build' to compile your project."
            '';

            # Set the build inputs for the shell
            buildInputs = buildInputs;

          };
        }
      );

      # Buildable Package (Optional: for creating a final, self-contained executable)
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          # This package builds the Go Raylib application
          raylib-app = pkgs.buildGoModule {
            pname = "raylib-go-app";
            version = "0.1.0";
            src = ./.; # Assumes your Go code is in the flake root directory

            vendorHash = "sha256-a_hash_goes_here"; # Replace with the actual hash after 'nix build'

            # The Go Raylib binding requires CGO, so we enable it
            CGO_ENABLED = 1;

            # Ensure the Raylib C library is available during the build
            nativeBuildInputs = [ pkgs.pkg-config ];
            buildInputs = [ pkgs.raylib ];

            # Additional flags for the Go linker to find and link against raylib
            ldflags = [
              "-s"
              "-w"
              "-linkmode external"
              "-extldflags \"-lraylib\""
            ];
          };
          default = self.packages.${system}.raylib-app;
        }
      );
    };
}
