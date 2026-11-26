#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let ki-colors = (
  plum: rgb("870052"),
  plum_light: rgb(237, 219, 228),
  plum_dark: rgb("4F0433").lighten(10%),
  orange: rgb("FF876F"),
  orange_light: rgb("FEEEEB"),
  orange_dark: rgb("B84145"),
  blue: rgb("4DB5BC").darken(20%),
  blue_light: rgb("EDF4F4"),
  blue_dark: rgb("002C34"),
  grey: rgb("666666"),
  grey_light: rgb("F1F1F1"),
  grey_dark: rgb("000000"),
  green: rgb("54B986"),
  green_light: rgb("C7ECDC"),
  green_dark: rgb("094334"),
  yellow: rgb("FFC66D"),
  yellow_light: rgb("#FFF1DB"),
  yellow_dark: rgb("F59A00"),
)

#let font-size = (
  body: 12pt,
  smaller: 10pt,
  small: 12pt,
  large: 20pt,
  xl: 40pt,
)

#let faded(body) = {
  show text: it => context {
    set text(fill: text.fill.transparentize(70%))
    it
  }
  body
}

#let numbered-line(line, highlight) = context {
  let number-width = measure(str(line.count)).width
  let number = box(width: number-width, align(right, text(fill: ki-colors.grey, str(line.number))))
  let numbered = number + h(1em) + line.body
  if highlight == none or line.number in highlight { numbered } else { faded(numbered) }
}

#let code-panel-border = 1pt + ki-colors.grey_light.darken(15%)

#let code-panel(filename, body) = block(
  width: 100%,
  stroke: code-panel-border,
  radius: 6pt,
  clip: true,
  stack(
    if filename != none {
      block(
        width: 100%,
        fill: ki-colors.grey_light,
        stroke: (bottom: code-panel-border),
        inset: (x: 1em, y: 0.5em),
        text(fill: ki-colors.grey, raw(filename)),
      )
    },
    block(width: 100%, inset: (x: 1em, y: 0.75em), body),
  ),
)

#let code-box(path, lang: auto, filename: true, highlight: none) = block(width: 100%, {
  let root-relative-path = if path.starts-with("/") { path } else { "/" + path }
  let basename = path.split("/").last()
  let lang = if lang == auto { basename.split(".").last() } else { lang }
  set text(font-size.small)
  set par(leading: 0.5em)
  code-panel(
    if filename { basename },
    {
      show raw.line: line => numbered-line(line, highlight)
      raw(read(root-relative-path).trim(at: end), lang: lang, block: true)
    },
  )
})

#let sec-col = ki-colors.grey

#show heading: set block(above: 1.5em, below: 1em)

#set text(
  font: "DM Sans 9pt",
)

#set page(
  header: [
    #text(fill: sec-col)[_Workshop on Bayesian Workflow_]
    #h(1fr)
    #text(fill: sec-col)[26-27 November 2026]
  ],
)

= Option 1: From simulation to posterior samples

== Simulation
This is based on Richard McElreath's #link("https://github.com/rmcelreath/stat_rethinking_2026/blob/main/homework/homework_A06.pdf")[exercise A06].

#v(2em)

#align(center, diagram(
  spacing: (2.2em, 2em),
  node-inset: 10pt,
  $
    "X" edge("rr", ->) &                                   & "Y" \
                       & "Z" edge("ul", ->) edge("ur", ->)
  $,
))

#v(2em)

Simulate a dataset based on the DAG.
You can keep it really simple and assume that each variable is normally distributed.
If you prefer, you can also come up with more realistic variables!

== Model
Then write a model based on your simulation code. What happens when you don't adjust for Z?

== Posterior
Summarise and visualise the posterior.
#v(1fr)

#code-box("R_code/for_typst/hint/option_1.R")
#pagebreak()

= Option 2: Using real data

This is McElreath's #link("https://github.com/rmcelreath/stat_rethinking_2026/blob/main/homework/homework_A07.pdf")[exercise A07].
The exercise is a bit more advanced and uses real data.

This is based on the data in `data(foxes)`: 116 foxes from 30 different urban groups in England.
These fox groups are like street gangs.
We consider four variables.
Each group maintains its own (almost exclusive) urban territory.
Some territories are larger than others.
The area variable is the size of each territory.
Group size (`groupsize`) varies from 2 to 8 individuals and is the number of foxes in each territory.
Some territories also have more `avgfood` than others.
And finally food influences the weight of each fox. Assume this DAG:

#align(center, diagram(
  spacing: (2em, 2em),
  node-inset: 10pt,
  $
                                      & "A" edge("dl", ->) \
    "F" edge("rr", ->) edge("dr", ->) &                    & "G" edge("dl", ->) \
                                      & "W"
  $,
))

where *F* is `avgfood`, *G* is `groupsize`, *A* is `area`, and *W* is `weight`.

First familiarise yourself with the data using simple plots and tables.

Then use the backdoor criterion and estimate the total causal influence of F on W.
Now try summarising your results numerically and visually.

*Bonus*: What effect would increasing the food have on the weight of foxes inside it?

#v(1fr)

#code-box("R_code/for_typst/hint/option_2.R")
