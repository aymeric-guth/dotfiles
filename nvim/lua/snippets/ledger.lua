local ls = require('luasnip')

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
  ls.snippet(
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
        os.date('%Y-%m-%d'),
        ls.insert_node(1, 'payee'),
        ls.insert_node(2, 'invoice_id'),
        ls.insert_node(3, 'amount'),
        rep(1),
      }
    )
  ),
}
