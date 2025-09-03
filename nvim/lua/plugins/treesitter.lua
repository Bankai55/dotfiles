return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", 
    },
    lazy = false, 
    config = function()
      vim.keymap.set('n', "<leader>ff" , ':Neotree filesystem reveal left<CR>', {})
      local config = require("nvim-treesitter.configs")
      config.setup({
      auto_install = true,
      ensure_installed = {"lua", "python"},
      higlight = {enable = true},
      indent = {enable = true},
})
  end
}
  
