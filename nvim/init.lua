-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Spell --
-- TODO: Add this to a proper file, don't just leave it in init.lua
--       Also, choose a pretty nerd-font icon for this group
local wk = require("which-key")
wk.add({ "<leader>z", group = "language" })
