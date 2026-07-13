local map = vim.keymap.set

map("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "Toggle Filemanager" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope Live Grep" })
map("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close Buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
