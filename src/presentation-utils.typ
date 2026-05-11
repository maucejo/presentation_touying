#import "@preview/touying:0.6.1": *

/// Show mini slides. It is usually used to show the navigation of the presentation in header.
///
/// - self (none): The self context, which is used to get the short heading of the headings.
///
/// - fill (color): The fill color of the headings. Default is `rgb("000000")`.
///
/// - alpha (ratio): The transparency of the headings. Default is `60%`.
///
/// - display-section (boolean): Indicates whether the sections should be displayed. Default is `false`.
///
/// - display-subsection (boolean): Indicates whether the subsections should be displayed. Default is `true`.
///
/// - linebreaks (boolean): Indicates whether or not to insert linebreaks between links for sections and subsections.
///
/// - display-subsection (boolean): Indicates whether the subsections should be displayed. Default is `true`.
///
/// - short-heading (boolean): Indicates whether the headings should be shortened. Default is `true`.
///
/// -> content
#let my-mini-slides(
  self: none,
  fill: rgb("000000"),
  alpha: 60%,
  display-section: false,
  display-subsection: true,
  linebreaks: true,
  short-heading: true,
) = (
  context {
    let headings = query(heading.where(level: 1).or(heading.where(level: 2)))
    let sections = headings.filter(it => it.level == 1)
    if sections == () {
      return
    }
    let first-page = sections.at(0).location().page()
    headings = headings.filter(it => it.location().page() >= first-page)
    let slides = query(<touying-metadata>).filter(it => (
      utils.is-kind(it, "touying-new-slide")
        and it.location().page() >= first-page
    ))
    let current-page = here().page()
    let current-index = (
      sections.filter(it => it.location().page() <= current-page).len() - 1
    )
    let cols = ()
    let col = ()
    for (hd, next-hd) in headings.zip(headings.slice(1) + (none,)) {
      let next-page = if next-hd != none {
        next-hd.location().page()
      } else {
        calc.inf
      }
      if hd.level == 1 {
        if col != () {
          cols.push(align(left, col.sum()))
          col = ()
        }
        col.push({
          show linebreak: none
          let body = if short-heading {
            utils.short-heading(self: self, hd)
          } else {
            hd.body
          }
          [#link(hd.location(), body)<touying-link>]
          // linebreak()
          v(-0.85em)
          while (
            slides.len() > 0 and slides.at(0).location().page() < next-page
          ) {
            let slide = slides.remove(0)
            if display-section {
              let next-slide-page = if slides.len() > 0 {
                slides.at(0).location().page()
              } else {
                calc.inf
              }
              if (
                slide.location().page() <= current-page
                  and current-page < next-slide-page
              ) {
                [#link(slide.location(), sym.circle.filled)<touying-link>]
              } else {
                [#link(slide.location(), sym.circle.small)<touying-link>]
              }
            }
          }
          if display-section and display-subsection and linebreaks {
            linebreak()
          }
        })
      } else {
        col.push({
          while (
            slides.len() > 0 and slides.at(0).location().page() < next-page
          ) {
            let slide = slides.remove(0)
            if display-subsection {
              let next-slide-page = if slides.len() > 0 {
                slides.at(0).location().page()
              } else {
                calc.inf
              }
              if (
                slide.location().page() <= current-page
                  and current-page < next-slide-page
              ) {
                [#link(slide.location(), sym.circle.filled)<touying-link>]
              } else {
                [#link(slide.location(), sym.circle.small)<touying-link>]
              }
            }
          }
          if display-subsection and linebreaks {
            linebreak()
          }
        })
      }
    }
    if col != () {
      cols.push(align(left, col.sum()))
      col = ()
    }
    if current-index < 0 or current-index >= cols.len() {
      cols = cols.map(body => text(fill: fill, body))
    } else {
      cols = cols
        .enumerate()
        .map(pair => {
          let (idx, body) = pair
          if idx == current-index {
            text(fill: fill, body)
          } else {
            text(fill: utils.update-alpha(fill, alpha), body)
          }
        })
    }
    set align(top)
    show: block.with(inset: (top: .5em, x: 2em))
    set text(size: .7em)
    grid(columns: cols.map(_ => auto).intersperse(1fr), ..cols.intersperse([]))
  }
)