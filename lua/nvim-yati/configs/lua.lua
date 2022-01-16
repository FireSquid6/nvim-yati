return {
  indent = {
    "table",
    "function",
    "function_definition",
    "expression",
    "local_function",
    "parameters",
    "arguments",
    "if_statement",
    "else",
    "elseif",
    "do_statement",
    "for_statement",
    "for_in_statement",
    "while_statement",
    "repeat_statement",
    "local_variable_declaration",
    "variable_declaration",
  },
  indent_last = {
    "else",
    "elseif",
    "local_variable_declaration",
    "variable_declaration",
    "function_call",
    "field_expression",
    "return_statement",
  },
  skip_child = {
    local_function = { named = { "parameters" } },
    function_definition = { named = { "parameters" } },
    ["function"] = { named = { "parameters" } },
    if_statement = { literal = { "then" }, named = { "else", "elseif" } },
    for_statement = { literal = { "do" } },
    for_in_statement = { literal = { "do", "in" } },
    while_statement = { literal = { "do" } },
    repeat_statement = { literal = { "until" } },
    return_statement = { literal = { "(", ")" } },
  },
  ignore_self = { named = { "binary_operation" } },
  hook_node = function(node, ctx)
    local sibling = node:prev_sibling()
    -- Fix indent in arguemnt of chained function calls #L133(sample.js)
    if node:type() == "arguments" and sibling:type() == "field_expression" and sibling:start() ~= sibling:end_() then
      return ctx.shift, node
    end
  end,
}
