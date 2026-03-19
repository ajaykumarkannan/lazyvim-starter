vim.bo.expandtab = false
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

-- Use manual foldmethod so folds are created/removed explicitly with zf/zd
vim.wo.foldmethod = "manual"
vim.wo.foldenable = true
vim.wo.foldlevel = 99 -- start with everything unfolded (except what we explicitly fold)

-- Auto-fold YAML frontmatter (lines between opening and closing ---)
vim.schedule(function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	if #lines < 2 or lines[1] ~= "---" then
		return
	end
	for i = 2, #lines do
		if lines[i] == "---" then
			-- Create a fold from line 1 to the closing ---
			vim.cmd(string.format("1,%dfold", i))
			break
		end
	end
end)
