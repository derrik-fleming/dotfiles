local function get_line_length_from_analysis_options()
	local cwd = vim.fn.getcwd()
	local analysis_options_path = cwd .. "/analysis_options.yaml"
	
	if vim.fn.filereadable(analysis_options_path) == 1 then
		local content = vim.fn.readfile(analysis_options_path)
		for _, line in ipairs(content) do
			local page_width = line:match("page_width:%s*(%d+)")
			if page_width then
				return tonumber(page_width)
			end
		end
	end
	
	return 80
end

return {
	{
		"dart-lang/dart-vim-plugin",
		event = "VeryLazy",
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				dartls = {
					cmd = { "dart", "language-server", "--protocol=lsp" },
					init_options = {
						onlyAnalyzeProjectsWithOpenFiles = true,
					},
					settings = {
						dart = {
							lineLength = get_line_length_from_analysis_options(),
							enableSdkFormatter = false,
						},
					},
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				dart = { "dart_cust" },
			},
			formatters = {
				dart_cust = {
					command = "dart",
					args = function()
						return { "format", "--line-length", tostring(get_line_length_from_analysis_options()), "$FILENAME" }
					end,
					stdin = false,
				},
			},
		},
	},
	-- {
	-- 	"akinsho/flutter-tools.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"stevearc/dressing.nvim", -- optional for vim.ui.select
	-- 	},
	-- 	requires = "nvim-lua/plenary.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("flutter-tools").setup({
	-- 			fvm = true,
	--
	-- 			debugger = {
	-- 				enabled = true,
	-- 				run_via_dap = true,
	-- 				register_configurations = function(_)
	-- 					require("dap").configurations.dart = {}
	-- 					require("dap.ext.vscode").load_launchjs()
	-- 				end,
	-- 			},
	--
	-- 			dev_log = { enabled = false, open_cmd = "tabedit" },
	-- 			lsp = {
	-- 				settings = {
	-- 					showTodos = true,
	--
	-- 					lineLength = 120,
	-- 				},
	-- 				on_attach = LazyVim.lsp.on_attach,
	-- 				capabilities = require("lazyvim.plugins.lsp").capabilities,
	-- 				flags = require("lazyvim.plugins.lsp").flags,
	-- 				handlers = require("lazyvim.plugins.lsp").handlers,
	-- 			},
	-- 		})
	-- 	end,
	-- 	keys = {
	-- 		{ "<leader>F", "", desc = "Flutter" },
	-- 		{ "<leader>Fc", ":FlutterCopyProfilerUrl<CR>", desc = "Copy Profile Url" },
	-- 		{ "<leader>Fd", ":FlutterDevices<CR>", desc = "Devices" },
	-- 		{ "<leader>FD", ":FlutterDevTools<CR>", desc = "Dev Tools" },
	-- 		{ "<leader>Fe", ":FlutterEmulators<CR>", desc = "Emulators" },
	-- 		{ "<leader>Fh", ":FlutterReload<CR>", desc = "Reload" },
	-- 		{ "<leader>FH", ":FlutterRestart<CR>", desc = "Restart" },
	-- 		{ "<leader>Fl", ":FlutterLogClear<CR>", desc = "Log Clear" },
	-- 		{ "<leader>Fo", ":Flutterlvimutline<CR>", desc = "lvimutline" },
	-- 		{ "<leader>Fp", ":FlutterPubGet<CR>", desc = "Pub Get" },
	-- 		{ "<leader>Fq", ":FlutterQuit<CR>", desc = "Quit" },
	-- 		{ "<leader>Fr", ":FlutterRun<CR>", desc = "Run Dev" },
	-- 		{ "<leader>Fv", ":FlutterVisualDebug<CR>", desc = "Visual Debug" },
	-- 	},
	-- },
}
