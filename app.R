#######################
##                   ##
###   Bernie Sits   ###
##                   ##
### By Drew Seewald ###
##                   ##
#######################


# Setup -------------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(stringr)
library(dotenv)
library(magick)

load_dot_env()

# Helper Functions --------------------------------------------------------

check_bad_characters <- function(string) {
    return(str_detect(string, "[?&%=;:]"))
}

check_no_input <- function(string) {
    return(ifelse(str_count(string) <= 1, TRUE, FALSE))
}

build_URL <- function(location, key) {
    base_URL <- "https://maps.googleapis.com/maps/api/streetview?size=600x400&"
    
    paste0(base_URL, "&location=", location, "&key=", key)
    
}

# Server ------------------------------------------------------------------

server <- function(input, output) {
    
    # Button Events
    observeEvent(input$sit, {
        location <- input$address
        
        if (check_bad_characters(location)) {
            showNotification("Check your address, it should not include ? & % = ; :", type = "error")
        } else if (check_no_input(location)) {
            showNotification("Check your address, you didn't type anything", type = "warning")
        } else {
            location <- URLencode(location)
            
            street <- image_read(build_URL(location, Sys.getenv("GOOGLE_MAPS_STREETVIEW_KEY")))
            bernie <- image_scale(image_read("bernie_large.png"), "x175")
            
            final <- image_composite(street, bernie, offset = "+350 +200")
            
            output$image <- renderImage({
                tmpfile <- image_write(final, tempfile(fileext='jpg'), format = 'jpg')
                
                list(src = tmpfile, contentType = "image/jpeg")
            })
            
        }
        
    })
}


# Header ------------------------------------------------------------------

header <- dashboardHeader(
    title = "Bernie Sits Clone"
)


# Sidebar -----------------------------------------------------------------

sidebar <- dashboardSidebar(disable = TRUE)


# Body --------------------------------------------------------------------

body <- dashboardBody(
    box(title = "Make Bernie Sanders sit in front of your house! Just enter the address to begin:", width = 12,
        textInput("address", "Address"),
        actionButton("sit", "Sit!"),
        footer = "Note: Addresses are not saved"
    ),
    box(title = "Output", width = 12, imageOutput("image"))
)


# Assemble App ------------------------------------------------------------

ui <- dashboardPage(header, sidebar, body)

shinyApp(ui, server)
