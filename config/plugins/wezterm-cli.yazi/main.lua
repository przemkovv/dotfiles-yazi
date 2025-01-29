local get_current_directory = ya.sync(
  function(_) return tostring(cx.active.current.cwd) end
)

return {
  entry = function(_, job)
    local args = table.concat(job.args, " ")
    local current = get_current_directory()
    if current == nil then
      return
    end
    local cmd = "wezterm.exe cli " .. args .. " --cwd " .. ya.quote(current)
    ya.manager_emit("shell", {
      cmd,
      block = false,
      orphan = true,
    })
  end,
}
