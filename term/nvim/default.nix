# My shell configuration
{
  pkgs,
  lib,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      lua51Packages.lz-n
      lua51Packages.tree-sitter-cli
      luarocks
      neocmakelsp
      ripgrep
      tree-sitter
      vscode-extensions.vadimcn.vscode-lldb
      xxd
    ];

    sessionVariables = {
      EDITOR = "nvim";
      CODELLDB_BIN_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      CODELLDB_LIB_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.dylib";
    };

  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
  };
}
