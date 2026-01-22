return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git", "dist", ".idea" },
        path_display = { "truncate" },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- Use fd with optimized flags
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
      },
    },
  },
}
