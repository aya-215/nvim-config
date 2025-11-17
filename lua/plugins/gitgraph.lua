return {
	"isakbm/gitgraph.nvim",
	lazy = true,
	keys = {
		{ "<leader>gl", function()
			require("gitgraph").draw({}, { all = true, max_count = 5000 })
		end, desc ="GitGraph" },
	},
	dependencies = {
		"sindrets/diffview.nvim", -- 依存プラグイン
	},
	config = function()
		local gitgraph = require("gitgraph")

		-- プラグイン設定
		gitgraph.setup({
			-- 記号設定
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			-- フォーマット設定
			format = {
				timestamp = "%Y-%m-%d %H:%M:%S",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			-- フック設定：単一コミット選択時
			hooks = {
				on_select_commit = function(commit)
					-- Diffviewでコミットを表示
					vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
				end,
				on_select_range_commit = function(from, to)
					-- Diffviewで範囲を表示
					vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
				end,
			},
		})

	end,
}
