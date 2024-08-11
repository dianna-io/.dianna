-- (dianna) .dianna/.nvim/init.lua
--
-- notes:
--  entrypoint for nvim config

--  NB: Must happen before plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--
-- plugin management
--

-- lazy.nvim for package management
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- plugin configuration
require('lazy').setup({

  --
  -- assistance
  --

  -- vim-sleuth to automagically set tabstop and shiftwidth
  'tpope/vim-sleuth',

  -- lspconfig (language server protocol)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- automatically install languages to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- language server live status updates
      { 'j-hui/fidget.nvim',       tag = "legacy" },
    },
  },

  -- autocompletions
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- snippet engine
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- with language server protocol based completions
      'hrsh7th/cmp-nvim-lsp',
    },
  },

  -- action preview
  { "aznhe21/actions-preview.nvim" },

  --
  -- appearance
  --

  -- theme
  {
    "jesseleite/nvim-noirbuddy",
    dependencies = {
      -- NB: see https://github.com/jesseleite/nvim-noirbuddy#installation
      { "tjdevries/colorbuddy.nvim", branch = "dev" },
    },
  },

  -- statusline
  'nvim-lualine/lualine.nvim',

  --
  -- commands
  --

  -- map "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  --
  -- search
  --

  -- fuzzy searching
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  --
  -- nagivation
  --

  -- structure awareness
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- file browser
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
  },

  -- TODO(dianna): continue exploring this

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-o>'] = require('telescope.actions').select_default,
        ['<C-t>'] = require('telescope.actions').select_tab,
        ['<C-v>'] = require('telescope.actions').select_vertical,
        ['<C-V>'] = require('telescope.actions').select_horizontal,
        ['<C-j>'] = require('telescope.actions').preview_scrolling_down,
        ['<C-k>'] = require('telescope.actions').preview_scrolling_up,
      },
      n = {
        ['<C-o>'] = require('telescope.actions').select_default,
        ['<C-t>'] = require('telescope.actions').select_tab,
        ['<C-v>'] = require('telescope.actions').select_vertical,
        ['<C-V>'] = require('telescope.actions').select_horizontal,
        ['<C-j>'] = require('telescope.actions').preview_scrolling_down,
        ['<C-k>'] = require('telescope.actions').preview_scrolling_up,
      },
    },
  },
  extensions = {
    file_browser = {
      hidden = { file_browser = true, folder_browser = true },
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')

-- Telescope search customization
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 0,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>fb', require('telescope').extensions.file_browser.file_browser, { desc = '[F]ile [B]rowser' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>s?', require('telescope.builtin').help_tags, { desc = '[S]earch Help [?]' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Clear last search
vim.keymap.set('n', '\\', function() vim.cmd("let @/ = ''") end, { desc = 'Clear last search' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'json', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['cp'] = '@parameter.inner',
        ['Cp'] = '@parameter.outer',
        ['cf'] = '@function.inner',
        ['Cf'] = '@function.outer',
        ['ct'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ['Gf'] = '@function.outer',
        ['Gt'] = '@class.outer',
      },
      goto_next_end = {
        ['GF'] = '@function.outer',
        ['GT'] = '@class.outer',
      },
      goto_previous_start = {
        ['gf'] = '@function.outer',
        ['gt'] = '@class.outer',
      },
      goto_previous_end = {
        ['gF'] = '@function.outer',
        ['gT'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['Sn'] = '@parameter.inner',
      },
      swap_previous = {
        ['Sp'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', 'Ge', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>oe', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Action preview configuration
require('actions-preview').setup {
  diff = {
    ctxlen = 0,
    algorithm = 'patience',
    ignore_whitespace = true,
  },
  highlight_command = {
    require('actions-preview.highlight').diff_so_fancy(),
  },
  backend = { 'telescope' },
  telescope = require('telescope.themes').get_dropdown { winblend = 0 },
}

-- LSP configuration
local lsp_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- Edit
  nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
  nmap('<leader>a', require("actions-preview").code_actions, '[A]ction')

  -- Search Symbols
  nmap('<leader>sl', require('telescope.builtin').lsp_document_symbols, '[S]earch [L]ocal Symbols')
  nmap('<leader>sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch [W]orkspace Symbols')
  nmap('<leader>sr', require('telescope.builtin').lsp_references, '[S]earch [R]eferences')

  -- Help
  nmap('<leader>?', vim.lsp.buf.hover, 'Hover Help [?]')
  nmap('<leader>a?', vim.lsp.buf.signature_help, 'Hover [A]rgument Help [?]')

  -- Format
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- TODO: enable more language servers
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

--
-- additional setup handlers
--

require('fidget').setup()

-- minimally gay theme
require('noirbuddy').setup {
  colors = {
    primary = '#ff92ff',            -- magenta
    diagnostic_error = '#ff6464',   -- red
    diagnostic_warning = '#ffff64', -- yellow
    diagnostic_info = '#5297ff',    -- blue
    diagnostic_hint = '#c096ff',    -- purple
    diff_add = '#c9ffa6',           -- green
    diff_change = '#5297ff',        -- blue
    diff_delete = '#ff6464',        -- red
  },
}

require('lualine').setup {
  options = {
    theme = require('noirbuddy.plugins.lualine').theme,
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
  },
  sections = require('noirbuddy.plugins.lualine').sections,
  inactive_sections = require('noirbuddy.plugins.lualine').inactive_sections,
}

-- Setup neovim lua configuration

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers),
}

require('mason-lspconfig').setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = lsp_attach,
      settings = servers[server_name],
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip').config.setup {}
require('cmp').setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = require('cmp').mapping.preset.insert {
    ['<C-j>'] = require('cmp').mapping.select_next_item(),
    ['<C-k>'] = require('cmp').mapping.select_prev_item(),
    ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
    ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
    ['<C-Space>'] = require('cmp').mapping.complete {},
    ['<CR>'] = require('cmp').mapping.confirm {
      behavior = require('cmp').ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = require('cmp').mapping(function(fallback)
      if require('cmp').visible() then
        require('cmp').select_next_item()
      elseif require('luasnip').expand_or_locally_jumpable() then
        require('luasnip').expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = require('cmp').mapping(function(fallback)
      if require('cmp').visible() then
        require('cmp').select_prev_item()
      elseif require('luasnip').locally_jumpable(-1) then
        require('luasnip').jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
