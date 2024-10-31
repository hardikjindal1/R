library(shiny)
library(timevis)

# Define the UI
ui <- fluidPage(
  titlePanel("Corporate Lifecycle of Bell Labs"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Explore the different phases of Bell Labs' lifecycle."),
      p("Click on each phase in the timeline to see more details about the events, innovations, and challenges.")
    ),
    
    mainPanel(
      timevisOutput("timeline")
    )
  )
)

# Define the Server logic
server <- function(input, output) {
  # Data for the timeline
  timeline_data <- data.frame(
    id = 1:6,
    content = c("Launch", "Growth", "Maturity", "Shakeout", "Decline", "End"),
    start = c("1880-01-01", "1930-01-01", "1950-01-01", "1970-01-01", "1980-01-01", "2000-01-01"),
    end = c("1925-12-31", "1949-12-31", "1969-12-31", "1979-12-31", "1999-12-31", "Present"),
    description = c(
      "1880s: Alexander Graham Bell sets up Volta Laboratory. The foundation of Bell Labs is laid.",
      "1930s-40s: Bell Labs experiences rapid growth, inventing technologies like the transistor and SIGSALY.",
      "1950s-60s: Bell Labs reaches maturity, developing UNIX and the first practical solar cell.",
      "1970s-80s: Antitrust actions against AT&T start to impact Bell Labs' funding and focus.",
      "1980s-90s: AT&T is broken up, and Bell Labs' resources are redirected to commercialization.",
      "2000s-Present: Bell Labs is sold multiple times and is now owned by Nokia."
    )
  )
  
  # Render the timeline with events and clickable details
  output$timeline <- renderTimevis({
    timevis(
      data = timeline_data,
      options = list(editable = TRUE, height = "300px")
    )
  })
  
  # Add interactivity: show more details on click
  observeEvent(input$timeline_selected, {
    selected_phase <- input$timeline_selected
    selected_info <- timeline_data[timeline_data$id == selected_phase, "description"]
    
    showModal(
      modalDialog(
        title = timeline_data$content[timeline_data$id == selected_phase],
        paste(selected_info),
        easyClose = TRUE
      )
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
