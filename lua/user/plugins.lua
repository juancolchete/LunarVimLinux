--lvim.builtin.alpha.active = false
lvim.builtin.nvimtree.setup.filters.custom = { }

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

vim.opt.shell = "bash";

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
   { 'wakatime/vim-wakatime'},
   { 'folke/trouble.nvim' },
   { 'jose-elias-alvarez/typescript.nvim' },
   { 'mg979/vim-visual-multi' },
   { 'juancolchete/lizard'},
   { 'brooth/far.vim'}
   --{'juancolchete/alpha-nvim'}
}
