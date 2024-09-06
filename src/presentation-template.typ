#import "@preview/touying:0.5.2": *
#import "_boxes.typ": *
#import "_slides.typ": *

#let presentation-theme(
  aspect-ratio: "16-9",
  lang: "fr",
  ..args,
  body
) = {
  show: touying-slides.with(
    config-info(
      font: "Lato",
      math-font: "Lete Sans Math",
      code-font: "DejaVu Sans Mono",
      logo: none,
      footer-logo: image("resources/assets/lecnam.png"),
      title-logo-height: 23%
    ),

    config-colors(
      primary: rgb("#c1002a"),
      secondary: rgb("#405a68"),
      background: rgb("#405a68").lighten(95%)
    ),

    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 30%,
      footer-descent: 30%,
      margin: (top: 3em, bottom: 1.5em, x: 2em),
    ),

    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),

    config-methods(
      init: (self: none, body) => {
        set text(font: self.info.font, size: 20pt, lang: lang)
        show math.equation: set text(font: self.info.math-font)
        show raw: set text(font: self.info.code-font)
        set par(justify: true)

        set list(marker: ([#text(fill:self.colors.primary)[#sym.bullet]], [#text(fill:self.colors.primary)[#sym.triangle.filled.small.r]]))
        set enum(numbering: n => text(fill:self.colors.primary)[#n.])

        body
      }
    ),

    config-store(
      align: align,
      lang: lang,
      sec-count: counter("sec-count"),
      app-count: counter("app-count")
    ),
    ..args,
  )

  body
}