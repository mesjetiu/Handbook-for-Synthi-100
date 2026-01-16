-- Filtro Lua para convertir Markdown semántico a LaTeX
-- Objetivo: mantener los archivos .md limpios y legibles
-- Uso: pandoc --lua-filter=filters/divs.lua

--------------------------------------------------------------------------------
-- CONFIGURACIÓN
--------------------------------------------------------------------------------

-- Mapeo de clases de div a entornos tcolorbox
local tcolorbox_environments = {
  warning = "warning",
  note = "note",
  important = "important"
}

-- Divs que se convierten a entornos LaTeX simples
local simple_environments = {
  flushright = "flushright",
  center = "center",
  flushleft = "flushleft"
}

--------------------------------------------------------------------------------
-- FILTRO PARA DIVS
--------------------------------------------------------------------------------

function Div(el)
  if not FORMAT:match 'latex' then
    return el
  end
  
  -- 1. Divs tcolorbox (warning, note, important) con soporte para title=
  for class, env in pairs(tcolorbox_environments) do
    if el.classes:includes(class) then
      local title = el.attributes["title"]
      local start_cmd
      if title then
        start_cmd = '\\begin{' .. env .. '}[title={' .. title .. '}]'
      else
        start_cmd = '\\begin{' .. env .. '}'
      end
      
      local start = pandoc.RawBlock('latex', start_cmd)
      local stop = pandoc.RawBlock('latex', '\\end{' .. env .. '}')
      
      local result = { start }
      for _, block in ipairs(el.content) do
        table.insert(result, block)
      end
      table.insert(result, stop)
      
      return result
    end
  end
  
  -- 2. Divs de alineación (flushright, center, flushleft)
  for class, env in pairs(simple_environments) do
    if el.classes:includes(class) then
      local start = pandoc.RawBlock('latex', '\\begin{' .. env .. '}')
      local stop = pandoc.RawBlock('latex', '\\end{' .. env .. '}')
      
      local result = { start }
      for _, block in ipairs(el.content) do
        table.insert(result, block)
      end
      table.insert(result, stop)
      
      return result
    end
  end
  
  -- 3. Div especial: signature (firma con fecha automática)
  if el.classes:includes("signature") then
    local start = pandoc.RawBlock('latex', '\\begin{flushright}')
    local stop = pandoc.RawBlock('latex', '\\end{flushright}')
    
    local result = { start }
    for _, block in ipairs(el.content) do
      table.insert(result, block)
    end
    -- Añadir fecha automática al final
    table.insert(result, pandoc.RawBlock('latex', '\\today'))
    table.insert(result, stop)
    
    return result
  end
  
  -- 4. Div especial: vspace (separador vertical, solo visible en LaTeX)
  if el.classes:includes("vspace") then
    local size = el.attributes["size"] or "1cm"
    return pandoc.RawBlock('latex', '\\vspace{' .. size .. '}')
  end
  
  return el
end

--------------------------------------------------------------------------------
-- FILTRO PARA TEXTO INLINE: "LaTeX" → \LaTeX{}
--------------------------------------------------------------------------------

function Str(el)
  if FORMAT:match 'latex' then
    if el.text == "LaTeX" then
      return pandoc.RawInline('latex', '\\LaTeX{}')
    end
  end
  return el
end

--------------------------------------------------------------------------------
-- FILTRO PARA REGLAS HORIZONTALES: --- → \vspace{1cm} en LaTeX
--------------------------------------------------------------------------------

function HorizontalRule(el)
  if FORMAT:match 'latex' then
    return pandoc.RawBlock('latex', '\\vspace{1cm}')
  end
  return el
end
