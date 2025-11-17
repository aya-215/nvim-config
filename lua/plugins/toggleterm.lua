return {
  {
    "akinsho/toggleterm.nvim",
	version = "*",
	lazy = true,
	cmd = { "ToggleTerm", "ToggleTermToggleAll", "ToggleTermSelectAll" },
	keys = {
		{ "<c-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", mode = {"n", "t"} },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
		{ "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Horizontal Terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical Terminal" },
		{ "<leader>gg", function() _lazygit_toggle() end, desc = "Lazygit" },
		{ "<leader>tp", function() _python_toggle() end, desc = "Python REPL" },
		{ "<leader>ts", function() _powershell_toggle() end, desc = "PowerShell" },
		{ "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", desc = "Toggle All Terminals" },
		{ "<leader>tr", "<cmd>ToggleTermSelectAll<cr>", desc = "Select Terminal" },
	},
	config = function()
	require("toggleterm").setup({
		-- 基本設定
		size = 20,
		open_mapping = [[<c-\>]], -- Ctrl+\ でターミナルを開閉
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2, -- darker = 1, lighter = 3
		start_in_insert = true,
		insert_mappings = true, -- インサートモードでopen_mappingが有効
		terminal_mappings = true,
		persist_size = true,
		persist_mode = true, -- 前回のモードを記憶
		direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
		close_on_exit = true,
		shell = vim.o.shell,

		-- フローティング設定
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},

		-- winbar設定
		winbar = {
			enabled = false,
			name_formatter = function(term)
			return term.name
			end,
		},
	})

      -- カスタムターミナルの設定
      local Terminal = require("toggleterm.terminal").Terminal

      -- lazygit用ターミナル
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        -- lazygit終了時にターミナルを閉じる
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- lazygitでESCが効くようにする
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      -- Python REPL用ターミナル
      local python = Terminal:new({
        cmd = "python",
        direction = "horizontal",
        size = 15,
      })

      function _python_toggle()
        python:toggle()
      end

      -- PowerShell用ターミナル
      local powershell = Terminal:new({
        cmd = "powershell",
        direction = "vertical",
        size = vim.o.columns * 0.4,
      })

      function _powershell_toggle()
        powershell:toggle()
      end

      -- キーマッピング設定
      local opts = { noremap = true, silent = true }

      -- ターミナル内でのキーマッピング
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        local bufname = vim.api.nvim_buf_get_name(0)
        local is_lazygit = string.find(bufname:lower(), "lazygit") ~= nil
        local is_claude = string.find(bufname:lower(), "claude") ~= nil or
                          string.find(bufname:lower(), "snacks") ~= nil

        -- ESC behavior: LazyGit/Claude Code keeps ESC, other terminals exit to normal mode
        if not (is_lazygit or is_claude) then
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts) -- ESCでノーマルモードへ
        end
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        -- Window navigation in terminal mode
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts) -- Move to left window
        -- Note: <C-j> is disabled to allow newline input in terminal (configured in keymaps.lua)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts) -- Move to upper window
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts) -- Move to right window
      end

      -- ターミナルバッファ作成時に自動でキーマッピングを設定
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    end,
  },
}
