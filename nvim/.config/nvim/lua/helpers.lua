-- dump the value received
function dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
  return ...
end

-- t is for `t`ermcode escaping, e.g. "<TAB>" should be interpreted as a tab character
function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Close the current window if the buffer is open in more than one window
function closeWindowOrBufferAsNeeded(options)
  local force_str = options['force'] and "!" or ""

  local num_windows_for_current_buffer = #vim.fn.win_findbuf(vim.fn.bufnr("%"))
  if num_windows_for_current_buffer > 1 then
    vim.cmd("close") -- close the window
  else
    vim.cmd("bdelete" .. force_str)
  end
end
