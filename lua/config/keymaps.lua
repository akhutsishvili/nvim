-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Insert relative file path with @ prefix
vim.keymap.set("i", "@", function()
  local telescope = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Get git root or fall back to cwd
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    git_root = vim.fn.getcwd()
  end

  telescope.find_files({
    cwd = git_root,
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          -- selection.path is absolute, make it relative to git_root
          local relative_path = selection.path
          if vim.startswith(relative_path, git_root) then
            relative_path = relative_path:sub(#git_root + 2) -- +2 for trailing slash
          end
          -- Insert @path at cursor
          vim.api.nvim_put({ "@" .. relative_path }, "c", true, true)
        end
      end)
      return true
    end,
  })
end, { desc = "Insert @file reference" })
