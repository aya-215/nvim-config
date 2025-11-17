return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = (function()
      if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        return nil
      else
        return "echo 'jsregexp is optional'; make install_jsregexp"
      end
    end)(),
    lazy = true,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        lazy = true, -- 起動時間最適化: lazy trueを明示
		config = function()
			-- 起動時間最適化: 初回InsertEnterまで完全に遅延
			vim.api.nvim_create_autocmd("InsertEnter", {
				once = true,
				callback = function()
					vim.schedule(function()
						require("luasnip.loaders.from_vscode").lazy_load()
						local config_path = vim.fn.stdpath("config")
						local custom_snippets_path = config_path .. "/snippets"
						if vim.fn.isdirectory(custom_snippets_path) == 1 then
							require("luasnip.loaders.from_vscode").lazy_load({
								paths = { custom_snippets_path }
							})
						end
					end)
				end,
			})
		end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
      region_check_events = "CursorMoved",
    },
    config = function(_, opts)
      local ls = require("luasnip")
      ls.setup(opts)

      local lua_snippets_path = vim.fn.stdpath("config") .. "/LuaSnip"
      if vim.fn.isdirectory(lua_snippets_path) == 1 then
        require("luasnip.loaders.from_lua").load({
          paths = lua_snippets_path
        })
      end

      vim.api.nvim_create_user_command("LuaSnipEdit", function()
        require("luasnip.loaders").edit_snippet_files()
      end, {})

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] 
            and not require("luasnip").session.jump_active then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
    keys = {
      {
        "<Tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<Tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<S-Tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.spec then
        opts.spec = {}
      end
      
      vim.list_extend(opts.spec, {
        { "<Tab>", desc = "Jump to next snippet placeholder", mode = "s" },
        { "<S-Tab>", desc = "Jump to previous snippet placeholder", mode = "s" },
      })
      
      return opts
    end,
  },
}
