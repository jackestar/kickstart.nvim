local gh = function(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim', -- kickstart may already add this; duplicates are fine
  gh 'kdheepak/lazygit.nvim',
  gh 'sindrets/diffview.nvim',
  gh 'isakbm/gitgraph.nvim',
}

-- Diffview works without setup(), but this is where options go
require('diffview').setup {
use_icons = false
}

require('gitgraph').setup {
  hooks = {
    on_select_commit = function(commit)
      vim.cmd('DiffviewOpen ' .. commit.hash .. '^!')
    end,
    on_select_range_commit = function(from, to)
      vim.cmd('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
    end,
  },
}

local map = vim.keymap.set
map('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
map('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Diff: working tree' })
map('n', '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'History: current file' })
map('n', '<leader>gH', '<cmd>DiffviewFileHistory<cr>', { desc = 'History: repo' })
map('n', '<leader>gq', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' })
map('n', '<leader>gl', function()
  require('gitgraph').draw({}, { all = true, max_count = 5000 })
end, { desc = 'Git graph' })
