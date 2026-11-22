#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

// Crop the page to the diagram (no A4 page around it)
#set page(width: auto, height: auto, margin: 20pt)
#set text(size: 11pt)

#diagram(
  spacing: (2.2em, 2em),
  node-inset: 10pt,
  $
                                   & "CKD" edge("d", ->) & "age" edge("l", ->) edge("d", ->) \
    "Air pollution" edge("rr", ->) &                     &                              "BP"
  $,
)
