#import "@preview/touying:0.5.2": *
#import "_utils.typ": *

#let _typst-builtin-align = align

#let slide(
  title: auto,
  subtitle: none,
  align: horizon,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
    if align != auto {
      self.store.align = align
    }

    let align = _typst-builtin-align
    let header(self) = {
      if self.store.navigation == "topbar" {
        set align(top)
        show: components.cell.with(fill: self.colors.primary, inset: 1em)
        set align(horizon)
        set strong(delta: 350)
        set text(fill: white, size: 1.25em)
        strong(utils.display-current-heading(level: 1))
        h(1fr)
        text(size: 0.8em, strong(utils.display-current-heading(level: 2)))
      } else if self.store.navigation == "mini-slides" {
        show: components.cell.with(fill: gradient.linear(self.colors.background.darken(10%), self.colors.background, dir: ttb))
        my-mini-slides(
          self: self,
          fill: self.colors.primary,
          alpha: 60%,
          display-section: self.store.mini-slides.at("display-section", default: false),
          display-subsection: self.store.mini-slides.at("display-subsection", default: true),
          short-heading: self.store.mini-slides.at("short-heading", default: true),
      )
        line(length: 100%, stroke: 0.5pt + self.colors.primary)

        place(dx: 1em, dy: 0.65em, text(size: 1.2em, fill: self.colors.primary, weight: "bold", utils.display-current-heading(())))
      }
    }

    let footer(self) = {
       set align(bottom)
       set text(size: 0.8em)

       place(dx: 1em, dy: -1em, {
         grid(
          columns: (1fr, 4fr, 1fr),
          align: center + horizon,
          [ #set image(height: 1.75em)
            #self.info.footer-logo
          ],
          [
            #v(0.25em)
            #text(fill:self.colors.primary, strong(self.info.short-title))
          ],
          [
            #set text(fill:self.colors.primary, weight: "bold")
            #if self.appendix {
              self.store.app-count.step()
              context{
                pad(right: 2em, bottom: 1.5em, top: 0.25em,
                box(stroke: 1.75pt + self.colors.primary, radius: 5pt, inset: -1em,outset: 1.5em)[
                #align(horizon)[#text(fill: self.colors.primary, strong([A | #self.store.app-count.at(here()).first() / #self.store.app-count.final().first()]))]
                ])
              }
            } else {
              box(stroke: 1.75pt + self.colors.primary, radius: 5pt, inset: -0.5em,outset: 1em)[#utils.slide-counter.display() / #utils.last-slide-number]
            }
          ]
        )
      })

      if self.appendix {
        let appendix-progress-bar = {
          context{
            let ratio = self.store.app-count.at(here()).first()/self.store.app-count.final().first()
            grid(
              columns: (ratio*100%, 1fr),
              components.cell(fill: self.colors.primary),
              components.cell(fill: self.colors.secondary.lighten(50%))
            )
          }
        }
        place(bottom, block(height: 2pt, width: 100%, spacing: 0pt, appendix-progress-bar))
      } else {
        place(bottom, components.progress-bar(height: 2pt, self.colors.primary, self.colors.secondary.lighten(40%)))
      }
    }

    let self = utils.merge-dicts(
    self,
    config-page(
      fill: self.colors.background,
      header: header,
      footer: footer,
    ),
  )

  let new-setting = body => {
    show: align.with(self.store.align)
    show: setting

    if self.store.navigation == "topbar" {v(-1em)}
    body
  }

  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
  }
)

#let title-slide = touying-slide-wrapper(self => {
  let content = {
    set align(center + horizon)

    block(width: 100%, inset: 2cm, {
      set image(height: self.info.title-logo-height)
      if self.info.logo != none {
        if type(self.info.logo) == "content" {
          set align(top + right)
          v(-2.5em)
          self.info.logo
        } else {
          v(-2.5em)
          grid(
            columns: self.info.logo.len(),
            column-gutter: 1fr,
            ..self.info.logo.map((logos) => (align(center + horizon, logos)))
          )
        }
      }

      line(length: 100%, stroke: 0.15em + self.colors.primary)
      text(size: 1.75em, strong(self.info.title, delta: 300))
      line(length: 100%, stroke: 0.15em + self.colors.primary)

      v(0.5em)
      if self.info.author != none {
        set text(size: 1em)
        block(spacing: 1em, strong(self.info.author, delta: 250))
      }

      if self.info.institution != none {
        set text(size: 0.85em)
        block(spacing: 1em, self.info.institution)
      }
    })
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: self.colors.background,
      margin: (top: 0em, bottom: 0em, x: 0em)
    )
  )
  touying-slide(self: self, content)
  }
)

#let content-slide = touying-slide-wrapper(self => {
  let localizaton = json("resources/i18n/fr.json")
  if self.store.lang == "en" {
    localization = json("resources/i18n/en.json")
  }

  let header = {
    set strong(delta: 350)
    if self.store.navigation == "topbar" {
      set align(top)
      show: components.cell.with(fill: self.colors.primary, inset: 1em)
      set align(horizon)
      set text(fill: white, size: 1.25em)
      strong(localizaton.toc)
    } else if self.store.navigation == "mini-slides" {
      set align(top)
      show: components.cell.with(fill: gradient.linear(self.colors.background.darken(10%), self.colors.background, dir: ttb))
      v(0.8em)
      set align(horizon)
      set text(fill: self.colors.primary, size: 1.25em)
      h(0.75em) + strong(localizaton.toc)
      v(-0.6em)
      line(length: 100%, stroke: 0.5pt + self.colors.primary)
    }
  }

 let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: self.colors.background,
      header: header,
    ),
  )

  let content = {
    show outline.entry: it => {
      let number = int(it.page.text)  + 1
      block(above: 2em, below: 0em)
      [#text([#number.], fill: self.colors.primary) #h(0.25em) #it.body]
    }

    set align(horizon)
    components.adaptive-columns(text(size: 1.2em, strong(outline(title:none, indent: 1em, depth: 1, fill: none), delta: 250)))
}

  touying-slide(self: self, content)
})

#let new-section-slide(level: 1, numbered: true, title) = touying-slide-wrapper(self => {
  let content = {
    self.store.sec-count.step()

    set align(horizon)
    show: pad.with(10%)
    set text(size: 1.5em)
    v(-0.7em)

    let section-progress-bar = {
      context{
        let ratio = self.store.sec-count.at(here()).first()/self.store.sec-count.final().first()
        grid(
          columns: (ratio*100%, 1fr),
          components.cell(fill: self.colors.primary),
          components.cell(fill: self.colors.secondary.lighten(50%))
        )
      }
    }

   stack(
      dir: ttb,
      spacing: 0.5em,
      strong(utils.display-current-heading(level: level, numbered: numbered), delta: 250),
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        section-progress-bar
      ),
    )
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.background)
  )
  touying-slide(self: self, content)
}
)

#let focus-slide(align: center + horizon, body) = touying-slide-wrapper(self => {
  let _align = align
  let align = _typst-builtin-align
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.primary, margin: 2em),
  )
  set text(fill: white, size: 2em)
  touying-slide(self: self, align(_align, strong(body)))
})