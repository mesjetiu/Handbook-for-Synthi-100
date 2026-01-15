-- Filtro Lua para convertir divs de Pandoc a tcolorbox en LaTeX
-- Uso: pandoc --lua-filter=filters/divs.lua

function Div(el)
  -- Mapeo de clases a entornos tcolorbox
  local environments = {
    warning = "warning",
    note = "note",
    important = "important"
  }
  
  for class, env in pairs(environments) do
    if el.classes:includes(class) then
      -- Para LaTeX: envolver en el entorno tcolorbox
      if FORMAT:match 'latex' then
        local start = pandoc.RawBlock('latex', '\\begin{' .. env .. '}')
        local stop = pandoc.RawBlock('latex', '\\end{' .. env .. '}')
        
        local result = { start }
        for _, block in ipairs(el.content) do
          table.insert(result, block)
        end
        table.insert(result, stop)
        
        return result
      -- Para HTML: mantener como div con clase
      elseif FORMAT:match 'html' then
        return el
      end
    end
  end
  
  return el
end
