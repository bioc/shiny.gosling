% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/visualChannels.R
\name{visual_channel_tooltip}
\alias{visual_channel_tooltip}
\title{tooltip visual channel}
\usage{
visual_channel_tooltip(field = NULL, type = NULL, alt = NULL, ...)
}
\arguments{
\item{field}{A character. Name of the data field.}

\item{type}{A character. Must be "genomic". Specify the data type.}

\item{alt}{A character.}

\item{...}{Any other parameters to pass to gosling.js.}
}
\value{
List object. list object with tooltip list object
}
\description{
tooltip visual channel
}
\details{
For more info visit
https://gosling.js.org/ and check for tooltip implementation
}
\examples{
if(interactive()) {
  library(shiny)
  library(shiny.gosling)

  cistrome_data <-
    "https://server.gosling-lang.org/api/v1/tileset_info/?d=cistrome-multivec"

  single_track <- add_single_track(
    id = "track1",
    data = track_data(
      url = cistrome_data,
      type = "multivec",
      row = "sample",
      column = "position",
      value = "peak",
      categories = c("sample 1", "sample 2", "sample 3", "sample 4"),
      binSize = 4,
    ),
    mark = "rect",
    x = visual_channel_x(field = "start", type = "genomic", axis = "top"),
    xe = visual_channel_x(field = "end", type = "genomic"),
    row = visual_channel_row(
      field = "sample",
      type = "nominal",
      legend = TRUE
    ),
    color = visual_channel_color(
      field = "peak",
      type = "quantitative",
      legend = TRUE
    ),
    tooltip = visual_channel_tooltips(
      visual_channel_tooltip(field = "start", type = "genomic",
                             alt = "Start Position"),
      visual_channel_tooltip(field = "end", type = "genomic",
                             alt = "End Position"),
      visual_channel_tooltip(
        field = "peak",
        type = "quantitative",
        alt = "Value",
        format = "0.2"
      )
    ),
    width = 600,
    height = 130
  )

  single_composed_track <- compose_view(
    tracks = single_track
  )

  single_composed_views <- arrange_views(
    title = "Single Track",
    subtitle = "This is the simplest single track visualization with a linear layout",
    layout = "circular", #"linear"
    views = single_composed_track,
    xDomain = list(
      chromosome = "chr1",
      interval = c(1, 3000500)
    )
  )

  ui <- fluidPage(
    use_gosling(),
    fluidRow(
      column(6, goslingOutput("gosling_plot")),
      column(
        1, br(), actionButton(
          "download_pdf",
          "PDF",
          icon = icon("cloud-arrow-down")
        )
      )
    )
  )


  server <- function(input, output, session) {
    output$gosling_plot <- renderGosling({
      gosling(
        component_id = "component_1",
        single_composed_views,
        clean_braces = TRUE
      )
    })

    observeEvent(input$download_pdf, {
      export_pdf(component_id = "component_1")
    })
  }

  shinyApp(ui, server)

}

}
