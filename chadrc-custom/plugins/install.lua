return {
   { 
     "wakatime/vim-wakatime",
     event = "VimEnter",
   },
   {
     "simrat39/rust-tools.nvim",
     after = "gitsigns.nvim"
   },
   { 
     "github/copilot.vim",
     setup = function()
       require"core.utils".packer_lazy_load "copilot.vim"
      end,
   },
 }
