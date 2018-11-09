cur_tab = vim.api.nvim_get_current_tabpage

V = {
    cur_tab: cur_tab,
    set_tvar: (k,v) -> vim.api.nvim_tabpage_set_var(cur_tab!, k, v),
    get_tvar: (k) -> vim.api.nvim_tabpage_get_var(cur_tab!, k),
    cmd: (c) -> vim.api.nvim_command(c),
    call: (n, a) -> vim.api.nvim_call_function(n, a),
}

-- A tabpage-specific vim variable
V.def_tvar = (n) -> {
    set: (v) -> V.set_tvar(n, v),
    get: () -> V.get_tvar(n),
}

-- A table attached to a tabpage
class TStorage
    data: {}
    init: => @data[V.cur_tab!] = {}         -- Create a tabpage-specific table
    get: => @data[V.cur_tab!]               -- Access the table
    set: (k,v) => @data[V.cur_tab!][k] = v  -- Set key-value
    clear: => @data[V.cur_tab!] = nil       -- Delete the tabpage-specific table

V.def_tstorage = TStorage

V