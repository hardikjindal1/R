library(shiny)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("cosmo"),
  title = "Calculator",
  titlePanel("Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      tags$h3("Input two numbers"),
      selectInput("func", "Enter function",
                  choices = list("Addition" = "add", "Subtract" = "sub",
                                 "Divide" = "div", "Multiply" = "mul")),
      numericInput("num1", "Enter number 1", 0),
      numericInput("num2", "Enter number 2", 0),
      actionButton("submitbutton", "Submit")
    ),
    
    mainPanel(
      h1("Output"),
      verbatimTextOutput("out")
    )
  )
)

server <- function(input, output) {
  # Use eventReactive to respond to the Submit button click
  result <- eventReactive(input$submitbutton, {
    x <- input$num1
    y <- input$num2
    z <- 0  # Initialize z
    
    # Perform operation based on input$func
    if (input$func == "add") {
      z <- x + y
    } else if (input$func == "sub") {
      z <- x - y
    } else if (input$func == "div") {
      z <- x / y
    } else {
      z <- x * y
    }
    
    # Return the result
    z
  })
  
  # Render the output when submit button is clicked
  output$out <- renderText({
    result()  # Call the reactive result here
  })
}

shinyApp(ui = ui, server = server)
