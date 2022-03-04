local goldsmith_ok, goldsmith = pcall(require, "goldsmith")
if not goldsmith_ok then
  return
end


goldsmith.config()
