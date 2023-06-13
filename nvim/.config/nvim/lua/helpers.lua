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

-- wrap calls that return boolean from vim.fn in this
function bool(x)
  if type(x) == "number" then
    return not (x == 0)
  end
  return false
end
