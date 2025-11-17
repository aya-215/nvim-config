return {
  {
    "ysmb-wtsg/in-and-out.nvim",
    keys = {
      {
        "<C-CR>",
        function()
          require("in-and-out").in_and_out()
        end,
        mode = "i",
        desc = "Navigate in and out of surrounding characters",
      },
    },
    opts = {
      additional_targets = { "\"", "\"" },
    },
  },
}