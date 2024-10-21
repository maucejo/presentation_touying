#import "@preview/touying:0.5.3": *
#import "@preview/showybox:2.0.1": *
#import "@preview/codelst:2.0.1": sourcecode

// Emphasized box (for equations)
#let _emphbox(self: none, body) = {
  set align(center)
  box(
    stroke: 1pt + self.colors.box.lighten(20%),
    radius: 5pt,
    inset: 0.5em,
    fill: self.colors.box.lighten(80%),
  )[#body]
}
#let emphbox(body) = touying-fn-wrapper(_emphbox.with(body))
//----

#let _subtitle(self: none, body) = {
  if self.store.navigation == "topbar" {
    set text(size: 1.2em, fill: self.colors.primary, weight: "bold")
    place(top + left, pad(left: -0.8em, top: -0.25em, body))
    v(1em)
  }
}
#let subtitle(body) = touying-fn-wrapper(_subtitle.with(body))

//---- Utilities for boxes ----
#let box-title(a, b) = {
  grid(columns: 2, column-gutter: 0.5em, align: (horizon),
    a,
    b
  )
}

#let colorize(svg, color) = {
  let blk = black.to-hex();
  if svg.contains(blk) {
    svg.replace(blk, color.to-hex())
  } else {
    svg.replace("<svg ", "<svg fill=\""+color.to-hex()+"\" ")
  }
}

#let color-svg(
  path,
  color,
  ..args,
) = {
  let data = colorize(read(path), color)
  return image.decode(data, ..args)
}
//----

//---- Utility boxes ----
// Information box
#let _info(self: none, body) = {
  set text(size: 0.8em)

  showybox(
    title: box-title(color-svg("resources/assets/icons/info.svg", self.colors.info, width: 1em), [*Note*]),
    title-style: (
      color: self.colors.info,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.info.lighten(80%),
      border-color: self.colors.info,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let info(body) = touying-fn-wrapper(_info.with(body))

// Tip box
#let _tip(self: none, body) = {
  set text(size: 0.8em)

  showybox(
    title: box-title(color-svg("resources/assets/icons/light-bulb.svg", self.colors.tip, width: 1em), [*Tip*]),
    title-style: (
      color: self.colors.tip,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.tip.lighten(80%),
      border-color: self.colors.tip,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let tip(body) = touying-fn-wrapper(_tip.with(body))

// Important box
#let _important(self: none, body) = {
  set text(size: 0.8em)
  showybox(
    title: box-title(color-svg("resources/assets/icons/report.svg", self.colors.important, width: 1em), [*Important*]),
    title-style: (
      color: self.colors.important,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.important.lighten(80%),
      border-color: self.colors.important,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let important(body) = touying-fn-wrapper(_important.with(body))

// Question box
#let _question(self: none, body) = {
  set text(size: 0.8em)
  showybox(
    title: box-title(color-svg("resources/assets/icons/question.svg", self.colors.question, width: 1em), [*Question*]),
    title-style: (
      color: self.colors.question,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: self.colors.question.lighten(80%),
      border-color: self.colors.question,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}
#let question(body) = touying-fn-wrapper(_question.with(body))

// Code box
#let _code(self: none, lang: none, body) = sourcecode(
    frame: showybox.with(
      title: [*Code* #h(1fr) #strong(lang)],
      frame: (
        title-color: self.colors.primary,
        border-color: self.colors.primary,
        body-color: none,
        thickness: (left: 3pt),
        radius: (top-left: 0pt, top-right: 1em),
      )
    ),
    body
)
#let code(lang: none, body) = touying-fn-wrapper(_code.with(lang: lang, body))

// Link box
#let _link-box(self: none, location, name) = {
  block(fill: self.colors.primary, radius: 1em, inset: 0.5em)[
    #set text(fill: white, size: 0.8em, weight: "bold")
    #link(location, name)
  ]
}
#let link-box(location, name) = touying-fn-wrapper(_link-box.with(location, name))