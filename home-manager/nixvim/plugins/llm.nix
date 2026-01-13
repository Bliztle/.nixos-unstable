{ ... }:
{
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
        settings = {
          panel.enabled = false;
          suggestion = {
            auto_trigger = true;
            keymap = {
              accept = "<C-CR>";
            };
          };
        };
      };
      avante = {
        enable = true;
        settings = {
          provider = "copilot";
          # providers = {
          #   copilot = {
          #     model = "openai/gpt-3.5-turbo-0613";
          #   };
          # };
          behaviour = {
            auto_suggestions = false; # Experimental at time of writing. TODO: Try this as copilot replacement.
            # Start by auto approving a limited set of tools, as I have not found a full list yet.
            # This list is from the documentation for disabled_tools but is not equivalent to the set of tools for this option:
            # rag_search, python, git_diff, git_commit, glob, search_keyword, read_file_toplevel_symbols, read_file, create_file, move_path, copy_path, delete_path, create_dir, bash, web_search, fetch
            auto_approve_tool_permissions = [
              "str_replace"
              "git_diff"
              "search_keyword"
              "read_file_toplevel_symbols"
              "read_file"
              "create_file"
              "copy_path"
              "create_dir"
              "web_search"
              "fetch"
            ];
          };
        };
      };
    };
  };
}
