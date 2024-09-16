#import "@preview/touying:0.5.2": *
#import "../src/presentation-template.typ": *

#let colors = (
  red: rgb("#c1002a")
)

#let title = [Title
#v(-0.5em)
#line(length: 15%, stroke: 0.075em + colors.red)
#v(-0.5em)
#text(size: 0.8em, [Subtitle])
]

#let labo = [Laboratory
]

#let authors = [#text(fill: colors.red, [Author A]) #h(1em) Author B]

#show: presentation-theme.with(
  navigation: "mini-slides",
  config-info(
    title: title,
    short-title: [Short title],
    author: authors,
    institution: labo,
    logo: image("../src/resources/assets/logo_cnam_lmssc.png"),
  )
)

#title-slide

#content-slide

= First section

== Slide title

#emphbox[
    $
    bold(z)_(k + 1) = bold(A) bold(z)_k + bold(B) bold(u)_k + bold(w)_k \
    bold(y)_k = bold(C) bold(z)_k + bold(v)_k
    $
]

- #lorem(20)

= Second section

== Slide title

#info[#lorem(10)]
#tip[#lorem(10)]
#important[#lorem(10)]
#question[#lorem(10)]

= Third section

== Code

#lorem(10)
#code(lang:"Julia")[
```julia
# A comment
function squared(x)
  return x^2
end
```
]

#subtitle("A slide with a list")

#focus-slide[
  Thank you for your attention

  Questions ?
]

#show: appendix

= Appendices <touying:hidden>

== A first appendix

== A second appendix

