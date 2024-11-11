return {
  "mfussenegger/nvim-jdtls",
  ft = {"java"},
  keys = {
    { "<leader>df", "<cmd>lua require'jdtls'.test_class()<cr>", desc = "Test Class" },
    { "<leader>dh", "<cmd>lua require'jdtls'.test_nearest_method()<cr>", desc = "Test Function" },
  },
}
