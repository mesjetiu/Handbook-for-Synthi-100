# Convenciones para la separación Markdown / LaTeX

Este proyecto mantiene una separación estricta entre el contenido Markdown (limpio y legible) y la implementación LaTeX (secundaria y técnica).

## Principio fundamental

> Los archivos `.md` en `content/` deben ser **completamente legibles** sin conocimientos de LaTeX. Toda la lógica de conversión reside en el filtro Lua y la plantilla.

---

## Sintaxis Markdown permitida

### Divs semánticos (cajas de advertencia)

```markdown
::: note
Texto de nota informativa.
:::

::: warning
Texto de advertencia.
:::

::: important
Texto importante.
:::
```

Con título personalizado (el atributo `title=` solo afecta al PDF):

```markdown
::: {.warning title="MUY IMPORTANTE"}
Contenido de la advertencia.
:::
```

### Firma con fecha automática

El div `signature` añade automáticamente la fecha al final (solo en LaTeX):

```markdown
::: signature
Nombre del autor\
Afiliación
:::
```

En Markdown se verá limpio. En el PDF aparecerá con alineación a la derecha y la fecha actual.

### Separador vertical

Usar `---` (regla horizontal de Markdown). En el PDF se convierte en `\vspace{1cm}`:

```markdown
Párrafo anterior.

---

Párrafo siguiente con espacio visual adicional.
```

### Alineación de texto

```markdown
::: flushright
Texto alineado a la derecha.
:::

::: center
Texto centrado.
:::
```

### Texto "LaTeX"

Simplemente escribe `LaTeX` en el texto. El filtro lo convierte automáticamente a `\LaTeX{}` en el PDF:

```markdown
Este documento está editado en LaTeX.
```

---

## Sintaxis Pandoc estándar (no es contaminación)

Los siguientes elementos son **sintaxis Pandoc válida**, no LaTeX, y se consideran aceptables:

- **Matemáticas**: `$x^2$` o `$$\sum_{i=1}^n$$`
- **Atributos de figura**: `![caption](path.png){#fig:id}`
- **Encabezados sin numerar**: `# Título {.unnumbered}`
- **Comentarios HTML**: `<!-- nota para editores -->`

---

## Archivos del sistema de conversión

| Archivo | Función |
|---------|---------|
| `filters/divs.lua` | Transforma sintaxis semántica Markdown → LaTeX |
| `templates/handbook.latex` | Plantilla con entornos y estilos personalizados |
| `content/metadata.yaml` | Variables globales (título, autor, fecha) |
| `build.sh` | Script de compilación Pandoc → PDF |

---

## Qué NO debe aparecer en los archivos .md

❌ Comandos LaTeX directos: `\vspace{}`, `\today`, `\LaTeX{}`, `\textbf{}`  
❌ Entornos LaTeX: `\begin{...}`, `\end{...}`  
❌ Paquetes o configuración LaTeX  

Si necesitas algo que solo existe en LaTeX:
1. Crea un div semántico nuevo (ej: `:::miestilo`)
2. Añade su transformación en `filters/divs.lua`
3. Añade el entorno correspondiente en `templates/handbook.latex`
