return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.nvim",
    },
    ft = { "markdown", "md", "quarto", "rmd", "org" },
    keys = {
      { "<leader>rm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
    },
    opts = {
      enabled = true,
      max_file_size = 10.0,
      debounce = 100,
      render_modes = { "n", "c" },
      preset = "lazy",
      
      anti_conceal = {
        enabled = true,
        above = 0,
        below = 0,
      },
      
      heading = {
        enabled = true,
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      
      code = {
        enabled = true,
        sign = false,
        style = "full",
        position = "left",
        width = "block",
        left_pad = 0,
        right_pad = 1,
        min_width = 0,
        border = "thin",
        above = "▄",
        below = "▀",
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",
      },
      
      dash = {
        enabled = true,
        icon = "─",
        width = "full",
        highlight = "RenderMarkdownDash",
      },
      
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
        left_pad = 0,
        right_pad = 0,
        highlight = "RenderMarkdownBullet",
      },
      
      checkbox = {
        enabled = true,
        position = "inline",
        unchecked = { icon = "○ " },
        checked = { icon = "✔ " },
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 " },
          important = { raw = "[~]", rendered = "󰖨 " },
        },
      },
      
      quote = {
        enabled = true,
        icon = "▍",
        repeat_linebreak = false,
        highlight = "RenderMarkdownQuote",
      },
      
      pipe_table = {
        enabled = true,
        preset = "round",
        style = "full",
        cell = "padded",
        alignment_indicator = "━",
      },
      
      callout = {
        note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "DiagnosticInfo" },
        tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "DiagnosticOk" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "DiagnosticHint" },
        warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "DiagnosticWarn" },
        caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "DiagnosticError" },
      },
      
      link = {
        enabled = true,
        image = "󰥶 ",
        email = "󰇮 ",
        hyperlink = "󰌹 ",
        highlight = "RenderMarkdownLink",
      },
      
      sign = { enabled = false },
      
      latex = {
        enabled = true,
        converter = "latex2text",
        highlight = "RenderMarkdownMath",
      },
    },
  },
}