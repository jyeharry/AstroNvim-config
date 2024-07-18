local Functions = {
  prompt_command = function(command, prompt, fallback, insertSpace)
    local user_input = vim.fn.input(prompt)
    insertSpace = insertSpace or false
    local formatStr = insertSpace and " %s" or "%s"

    if user_input ~= "" then
      vim.cmd(string.format(command .. formatStr, user_input))
    elseif fallback ~= "" and fallback ~= nil then
      vim.cmd(string.format(command .. formatStr, fallback))
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
