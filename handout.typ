#import "@preview/fletcher:0.5.8" as fletcher: edge, node

#let diagram(..args) = align(center, block(
  above: 2em,
  below: 2em,
  fletcher.diagram(..args),
))


#show heading: set block(above: 1em, below: 0.7em)

#set text(
  font: "DM Sans 9pt",
  size: 11pt,
)
= Simulate data
== DAG

#v(2em)

#align(center)[
  #diagram(
    // cell-size: (20mm, 5mm),
    spacing: (2.2em, 2em),
    node-inset: 10pt,
    $
                                     & "CKD" edge("d", ->) & "age" edge("l", ->) edge("d", ->) \
      "Air pollution" edge("rr", ->) &                     &                              "BP"
    $,
  )
]

