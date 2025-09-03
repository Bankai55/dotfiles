return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- Example formatters
					null_ls.builtins.formatting.prettier, -- Prettier
					null_ls.builtins.formatting.black, -- Black for Python
					null_ls.builtins.formatting.stylua,
                    null_ls.builtins.diagnostics.ruff,
					-- Example linters
					null_ls.builtins.diagnostics.eslint, -- ESLint
					null_ls.builtins.diagnostics.flake8, -- Flake8 for Python
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
