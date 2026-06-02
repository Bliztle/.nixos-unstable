{ ... }:
{
  programs.nixvim = {
    plugins = {
      neotest = {
        enable = false;
        adapters = {
          vitest = {
            enable = false;
          };
        };
      };
    };
  };
}
