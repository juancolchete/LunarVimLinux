--lvim.builtin.alpha.active = false
lvim.builtin.nvimtree.setup.filters.custom = { }

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "typescript", "typescriptreact" } }
}
vim.opt.shell = "fish";
formatters.setup {
  {
    name = "prettier",
    args = { "--print-width", "128","--plugin", "prettier-plugin-solidity","--tab-width","2" },
    filetypes = { "solidity" },
  },
}
configs.solidity = {
  default_config = {
    cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
    filetypes = { 'solidity' },
    root_dir = lspconfig.util.find_git_ancestor,
    single_file_support = true,
  },
}

lvim.keys.normal_mode["<S-f>"] = ":Telescope live_grep<CR>"
lvim.keys.normal_mode["<S-x>"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<space>'"] = ":Lizard<CR>"
lvim.keys.normal_mode["<F2>"] = "<cmd>ToggleTerm direction=float<CR>"
lvim.keys.term_mode["<F2>"] = "<cmd>ToggleTerm direction=float<CR>"
lvim.keys.normal_mode["<F3>"] = "<cmd>ToggleTerm direction=horizontal<CR>"
lvim.keys.term_mode["<F3>"] = "<cmd>ToggleTerm direction=horizontal<CR>"
lvim.keys.normal_mode["<F4>"] = "<cmd>ToggleTerm direction=vertical<CR>"
lvim.keys.term_mode["<F4>"] = "<cmd>ToggleTerm direction=vertical<CR>"
lvim.keys.visual_mode["<space>v"] = "g<C-G>"
lvim.keys.normal_mode["<C-a>"] = "ggVG"
lvim.keys.normal_mode["<C-s>"] = "zfa]"
lvim.keys.normal_mode["<C-z>"] = "zfa}"

lvim.builtin.which_key.mappings["ç"] = {
  name = "+Trouble",
  l = {"<cmd>TroubleToggle<cr>","General panel"},
  k = {"<cmd>TroubleToggle workspace_diagnostics<cr>","Workspace diagnostics"},
  j = {"<cmd>TroubleToggle document_diagnostics<cr>","Document diagnosticas"},
  h = {"<cmd>TroubleToggle loclist<cr>","Loclist"},
  g = {"<cmd>TroubleToggle quickfix<cr>","Quickfix"},
  f = {"<cmd>TroubleToggle lsp_references<cr>","LSP References"}
}

lvim.plugins = {
   { 'lunarvim/colorschemes' },
   { 'folke/trouble.nvim' },
   { 'jose-elias-alvarez/typescript.nvim' },
   { 'mg979/vim-visual-multi' },
   { 'juancolchete/lizard'},
   { 'brooth/far.vim'},
   { 'simrat39/rust-tools.nvim' }
}

local ctime = require("user.ctime")
local cdate = require("user.cdate")
lvim.builtin.lualine.sections.lualine_c = {
  ctime,
  cdate
}
