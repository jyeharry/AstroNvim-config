local Functions = {
  prompt_command = function(command, prompt, fallback)
    local user_input = vim.fn.input(prompt)

    if user_input ~= "" then
      vim.cmd(string.format(command .. " %s", user_input))
    elseif fallback ~= "" and fallback ~= nil then
      vim.cmd(string.format(command .. " %s", fallback))
    else
      vim.cmd(string.format(command))
    end
  end,

  getVisualSelection = function()
    vim.cmd 'noau normal! "vy"'
    local text = vim.fn.getreg "v"
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
      return text
    else
      return ""
    end
  end,
}

return Functions
