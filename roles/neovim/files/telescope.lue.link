return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = { -- insert mode (the prompt mode you type in)
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-h>"] = actions.preview_scrolling_up,
            ["<C-l>"] = actions.preview_scrolling_down,
          },
          n = { -- normal mode inside telescope (press <Esc> to enter)
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-h>"] = actions.preview_scrolling_up,
            ["<C-l>"] = actions.preview_scrolling_down,
            ["q"] = actions.close,
          },
        },
        layout_strategy = "horizontal", -- or "vertical"
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending", -- makes the first result appear at the top
      },
    })
  end,
}
