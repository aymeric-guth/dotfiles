local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local function today()
  return os.date('%Y-%m-%d')
end

return {
  s(
    {
      trig = 'arinv',
      name = 'Accounts receivable invoice',
      dscr = 'Invoice payment from bank to account receivable',
    },
    fmt(
      [[
{} * {}
  ; invoice: {}
  assets:bank:boursobank:checking  {} EUR
  assets:account receivable:{}
]],
      {
        f(today),
        i(1, 'payee'),
        i(2, 'invoice_id'),
        i(3, 'amount'),
        rep(1),
      }
    )
  ),
}
