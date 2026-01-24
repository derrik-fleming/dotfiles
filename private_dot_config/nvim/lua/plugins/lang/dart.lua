local function get_line_length_from_analysis_options()
	-- Start from current buffer's directory or cwd
	---@diagnostic disable-next-line: assign-type-mismatch
	local search_dir = vim.fn.expand("%:p:h")
	if search_dir == "" then
		---@diagnostic disable-next-line: assign-type-mismatch
		search_dir = vim.fn.getcwd()
	end

	-- Search upward for analysis_options.yaml
	---@diagnostic disable-next-line: assign-type-mismatch
	local analysis_options_path = vim.fn.findfile("analysis_options.yaml", search_dir .. ";")

	if analysis_options_path ~= "" then
		local content = vim.fn.readfile(analysis_options_path)
		for _, line in ipairs(content) do
			local page_width = line:match("page_width:%s*(%d+)")
			if page_width then
				return tonumber(page_width)
			end
		end
	end

	return 120
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
						closingLabels = true,
					},
					capabilities = (function()
						local capabilities = vim.lsp.protocol.make_client_capabilities()
						-- Enable closing labels capability
						capabilities.textDocument = capabilities.textDocument or {}
						capabilities.textDocument.publishDiagnostics = capabilities.textDocument.publishDiagnostics
							or {}
						capabilities.textDocument.publishDiagnostics.tagSupport = { valueSet = { 1, 2 } }
						capabilities.workspace = capabilities.workspace or {}
						capabilities.workspace.configuration = true
						return capabilities
					end)(),
					handlers = {
						["dart/textDocument/publishClosingLabels"] = function(err, result, ctx, config)
							if err then
								return
							end
							if not result then
								return
							end

							local bufnr = vim.uri_to_bufnr(result.uri)
							if not vim.api.nvim_buf_is_loaded(bufnr) then
								return
							end

							local ns = vim.api.nvim_create_namespace("dart_closing_labels")
							vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

							for _, label in ipairs(result.labels) do
								local line = label.range["end"].line
								local text = " // " .. label.label
								vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, {
									virt_text = { { text, "LspInlayHint" } },
									virt_text_pos = "eol",
									hl_mode = "combine",
								})
							end
						end,
					},
					on_new_config = function(config, root_dir)
						-- Dynamically set line length based on project's analysis_options.yaml
						config.settings.dart.lineLength = get_line_length_from_analysis_options()
					end,
					settings = {
						dart = {
							lineLength = 120, -- Default fallback
							enableSdkFormatter = false,
							closingLabels = true,
							flutterOutline = true,
							inlayHints = {
								parameterNames = { enabled = "all" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								functionReturnTypes = { enabled = true },
							},
							analysisExcludedFolders = {
								vim.fn.expand("$HOME/.pub-cache"),
								vim.fn.expand("$HOME/fvm"),
							},
							showTodos = true,
							completeFunctionCalls = true,
							enableSnippets = true,
							renameFilesWithClasses = "prompt",
							updateImportsOnRename = true,
							showDartDeveloperLogs = true,
							analyzerDiagnosticsPort = nil,
						},
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "dart" } },
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
		opts = function()
			local dap = require("dap")

			-- Get Flutter and Dart paths from mise
			local flutter_path = vim.fn.system("mise where flutter 2>/dev/null"):gsub("\n", "")
			local dart_path = flutter_path .. "/bin/cache/dart-sdk"
			local flutter_bin = flutter_path .. "/bin/flutter"

			-- Fallback if mise command fails
			if vim.v.shell_error ~= 0 then
				flutter_path = "/opt/flutter"
				dart_path = "/opt/flutter/bin/cache/dart-sdk"
				flutter_bin = "flutter"
			end

			-- Use Flutter's built-in debug adapter directly
			dap.adapters.dart = {
				type = "executable",
				command = flutter_bin,
				args = { "debug_adapter" },
				options = {
					initialize_timeout_sec = 30,
				},
			}

			-- Set default properties for VSCode configs
			dap.defaults.dart = {
				dartSdkPath = dart_path,
				flutterSdkPath = flutter_path,
				program = "${workspaceFolder}/lib/main.dart",
				cwd = "${workspaceFolder}",
			}

			-- Create configurations that mirror your VSCode launch.json but work with DAP
			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Launch dart",
					dartSdkPath = dart_path,
					flutterSdkPath = flutter_path,
					program = "${workspaceFolder}/lib/main.dart",
					cwd = "${workspaceFolder}",
				},
				{
					type = "dart",
					request = "launch",
					name = "Launch flutter",
					dartSdkPath = dart_path,
					flutterSdkPath = flutter_path,
					program = "${workspaceFolder}/lib/main.dart",
					cwd = "${workspaceFolder}",
				},
				-- Test debugging configurations
				{
					type = "dart",
					request = "launch",
					name = "Debug Current Test",
					dartSdkPath = dart_path,
					flutterSdkPath = flutter_path,
					program = "${file}",
					cwd = "${workspaceFolder}",
					console = "debugConsole",
				},
				{
					type = "dart",
					request = "launch",
					name = "Debug All Tests",
					dartSdkPath = dart_path,
					flutterSdkPath = flutter_path,
					program = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "debugConsole",
					args = { "test" },
				},
				{
					type = "dart",
					request = "launch",
					name = "Debug Widget Tests",
					dartSdkPath = dart_path,
					flutterSdkPath = flutter_path,
					program = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "debugConsole",
					args = { "test", "test/widget_test.dart" },
				},
				{
					type = "dart",
					request = "launch",
					name = "Debug Integration Tests",
					dartSdkPath = dart_path,
					flutterSdkPath = flutter_path,
					program = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "debugConsole",
					args = { "test", "integration_test/" },
				},
			}
		end,
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
						return {
							"format",
							"--line-length",
							tostring(get_line_length_from_analysis_options()),
							"$FILENAME",
						}
					end,
					stdin = false,
				},
			},
		},
	},
	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"sidlatau/neotest-dart",
		},
		opts = {
			adapters = {
				["neotest-dart"] = {
					-- Command being used to run tests. Defaults to `flutter`
					-- Change it to `fvm flutter` if using FVM
					-- Change it to `dart` for Dart only tests
					command = "flutter",
					-- When set Flutter outline information is used when constructing test name.
					-- Useful when using custom test names with @isTest annotation
					use_lsp = true,
					-- Custom test method names (if you use custom annotations)
					custom_test_method_names = {},
				},
			},
		},
	},
}
