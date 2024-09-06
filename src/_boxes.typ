#import "@preview/showybox:2.0.1": *
#import "@preview/codelst:2.0.1": sourcecode

#let colors = (
  red: rgb("#c1002a"),
  gray: rgb("#405a68"),
  green: rgb(31, 136, 61),
  blue: rgb(9, 105, 218),
  purple: rgb(130, 80, 223),
)

//---- Mathematics ----
// Space for equations
#let hs = sym.space.thin

// Emphasized box (for equations)
#let boxeq(body) = {
  set align(center)
  box(
    stroke: 1pt + colors.gray.lighten(20%),
    radius: 5pt,
    inset: 0.5em,
    fill: colors.gray.lighten(80%),
  )[#body]
}
//----

#let subtitle(body) = {
  set align(top)
  set text(size: 1.2em, fill: colors.red, weight: "bold")
  pad(left: -0.8em, body)
}

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
#let info(body) = {
  set text(size: 0.8em)

  showybox(
    title: box-title(color-svg("resources/assets/icons/info.svg", colors.red, width: 1em), [*Note*]),
    title-style: (
      color: colors.red,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: colors.red.lighten(80%),
      border-color: colors.red,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}

// Tip box
#let tip(body) = {
  set text(size: 0.8em)

  showybox(
    title: box-title(color-svg("resources/assets/icons/light-bulb.svg", colors.green, width: 1em), [*Tip*]),
    title-style: (
      color: colors.green,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: colors.green.lighten(80%),
      border-color: colors.green,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}

// Important box
#let important(body) = {
  set text(size: 0.8em)
  showybox(
    title: box-title(color-svg("resources/assets/icons/report.svg", colors.blue, width: 1em), [*Important*]),
    title-style: (
      color: colors.blue,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: colors.blue.lighten(80%),
      border-color: colors.blue,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}

// Question box
#let question(body, type: none) = {
  set text(size: 0.8em)
  showybox(
    title: box-title(color-svg("resources/assets/icons/question.svg", colors.purple, width: 1em), [*Question*]),
    title-style: (
      color: colors.purple,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: colors.purple.lighten(80%),
      border-color: colors.purple,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}

// Code box
#let code(lang: none, body) = sourcecode(
    frame: showybox.with(
      title: [*Code* #h(1fr) #strong(lang)],
      frame: (
        title-color: colors.red,
        border-color: colors.red,
        body-color: none,
        thickness: (left: 3pt),
        radius: (top-left: 0pt, top-right: 1em),
      )
    ),
    body
)

// Link box
#let link-box(location, name) = {
  set align(bottom + left)
  block(fill: colors.red, radius: 1em, inset: 0.5em)[
    #set text(fill: white, size: 0.8em, weight: "bold")
    #link(location, name)
  ]
}