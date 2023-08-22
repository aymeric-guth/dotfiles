local ok, ls = pcall(require, 'luasnip')
if not ok then
  return
end

ls.snippets = {
  all = {},
  lua = {
    ls.parser.parse_snippet('lf', 'local $1 = function($2)\n  $0end'),
  },
  python = {
    ls.parser.parse_snippet('main', ''),
  },
}
-- https://www.youtube.com/watch?v=Dn800rlPIho
