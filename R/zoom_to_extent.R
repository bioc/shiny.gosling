#' Zoom to extent
#' @description
#' Zooms out to see the entire view_id passed to this function.
#' @param component_id A character. The id of the component_id prop
#' passed to the
#' GoslingComponent function.
#' @param view_id A character. The ID of a view that you want to
#' control. This ID
#' is consistent to what you specify as track.id in your spec.
#' @param duration A numeric. A duration of the animated transition in ms
#' (Default: 1000).
#' @param session A shiny session object.
#' @examples
#' if(interactive()) {
#'   library(shiny)
#'   library(shiny.gosling)
#'
#'   cistrome_data <-
#'     "https://server.gosling-lang.org/api/v1/tileset_info/?d=cistrome-multivec"
#'
#'   single_track <- add_single_track(
#'     id = "track1",
#'     data = track_data(
#'       url = cistrome_data,
#'       type = "multivec",
#'       row = "sample",
#'       column = "position",
#'       value = "peak",
#'       categories = c("sample 1", "sample 2", "sample 3", "sample 4"),
#'       binSize = 4,
#'     ),
#'     mark = "rect",
#'     x = visual_channel_x(field = "start", type = "genomic", axis = "top"),
#'     xe = visual_channel_x(field = "end", type = "genomic"),
#'     row = visual_channel_row(
#'       field = "sample",
#'       type = "nominal",
#'       legend = TRUE
#'     ),
#'     color = visual_channel_color(
#'       field = "peak",
#'       type = "quantitative",
#'       legend = TRUE
#'     ),
#'     tooltip = visual_channel_tooltips(
#'       visual_channel_tooltip(field = "start", type = "genomic",
#'                              alt = "Start Position"),
#'       visual_channel_tooltip(field = "end", type = "genomic",
#'                              alt = "End Position"),
#'       visual_channel_tooltip(
#'         field = "peak",
#'         type = "quantitative",
#'         alt = "Value",
#'         format = "0.2"
#'       )
#'     ),
#'     width = 600,
#'     height = 130
#'   )
#'
#'   single_composed_track <- compose_view(
#'     tracks = single_track
#'   )
#'
#'   single_composed_views <- arrange_views(
#'     title = "Single Track",
#'     subtitle = "This is the simplest single track visualization with a linear layout",
#'     layout = "circular", #"linear"
#'     views = single_composed_track,
#'     xDomain = list(
#'       chromosome = "chr1",
#'       interval = c(1, 3000500)
#'     )
#'   )
#'
#'   ui <- fluidPage(
#'     use_gosling(),
#'     fluidRow(
#'       column(6, goslingOutput("gosling_plot")),
#'       column(
#'         1, br(), actionButton(
#'           "zoom_out",
#'           "Zoom Out"
#'         )
#'       )
#'     )
#'   )
#'
#'
#'   server <- function(input, output, session) {
#'     output$gosling_plot <- renderGosling({
#'       gosling(
#'         component_id = "component_1",
#'         single_composed_views,
#'         clean_braces = TRUE
#'       )
#'     })
#'
#'     observeEvent(input$zoom_out, {
#'       zoom_to_extent(
#'         component_id = "component_1",
#'         view_id = "track1"
#'       )
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
#'
#' @return None.
#' @importFrom shiny getDefaultReactiveDomain
#' @export
zoom_to_extent <- function(component_id, view_id, duration = 1000,
                           session = getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    "zoom_to_extent",
    list(
      component_id = component_id,
      view_id = view_id,
      duration = duration
    )
  )
}
