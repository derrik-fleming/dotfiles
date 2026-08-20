return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "swift" })
		end,
	},

	-- {
	--   "mason-org/mason.nvim",
	--   optional = true,
	--   opts = function(_, opts)
	--     opts.ensure_installed = opts.ensure_installed or {}
	--     vim.list_extend(opts.ensure_installed, {
	--       "swiftlint", -- Required by nvim-lint swiftlint
	--       "swiftformat", -- Required by confirm.nvim swiftformat
	--       "xcbeautify", -- Required by xcodebuild.nvim
	--       "xcode-build-server" -- Required by nvim-lspconfig sourcekit
	--     })
	--   end,
	-- },

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
			sourcekit = {
				mason = false, -- sourcekit-lsp comes from Xcode, not mason; forces vim.lsp.enable()
				filetypes = { "swift", "objective-c", "objective-cpp" },
				-- Neovim nightly calls root_dir(bufnr, on_dir) — the result must be passed
				-- to the on_dir callback, not returned. Returning synchronously is silently ignored.
				root_dir = function(bufnr, on_dir)
					local filename = vim.api.nvim_buf_get_name(bufnr)
					local util = require("lspconfig.util")

					-- Standard Swift/Xcode project detection (traverses up from file)
					local xcode_root = util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
						or util.root_pattern("Package.swift")(filename)
					if xcode_root then
						on_dir(xcode_root)
						return
					end

					-- Flutter iOS fallback: pubspec.yaml marks the Flutter project root;
					-- sourcekit needs the ios/ subdirectory where the xcodeproj lives.
					local flutter_root = util.root_pattern("pubspec.yaml")(filename)
					if flutter_root then
						local ios_dir = flutter_root .. "/ios"
						if
							vim.fn.isdirectory(ios_dir .. "/Runner.xcworkspace") == 1
							or vim.fn.isdirectory(ios_dir .. "/Runner.xcodeproj") == 1
						then
							on_dir(ios_dir)
							return
						end
					end

					on_dir(nil)
				end,
			},
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				swift = { "swiftlint" },
			},
		},
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				swift = { "swiftformat" },
			},
		},
	},

	{
		"wojciech-kulik/xcodebuild.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("xcodebuild").setup({
				code_coverage = {
					enabled = true,
				},
			})

			vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
			vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
			vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
			vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
			vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })
			vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })
			vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
			vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
			vim.keymap.set(
				"n",
				"<leader>xc",
				"<cmd>XcodebuildToggleCodeCoverage<cr>",
				{ desc = "Toggle Code Coverage" }
			)
			vim.keymap.set(
				"n",
				"<leader>xC",
				"<cmd>XcodebuildShowCodeCoverageReport<cr>",
				{ desc = "Show Code Coverage Report" }
			)
			vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Show QuickFix List" })
		end,
	},
}
