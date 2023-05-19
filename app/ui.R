ui <- fluidPage(
  # This theme and image section is attempting to emulate the site where the data set was taken
  # For this, may need to make a grid to align the text between the two flames using actual HTML/CSS
  theme = bslib_boys_theme,
  fluidRow(
    column(3,img(src = "fire.gif",align = "right", style = "width: 50px")),
    column(6, titlePanel("Yu-gi-oh Card data looker-atter")),
    column(3, img(src = "fire.gif",align = "left", style = "width: 50px"))
    
  ),
  
  # titlePanel("Yu-gi-oh Card data looker-atter"),
  fluidRow(
    titlePanel("But so far all it compares is average stat totals(atk+def) by Year")
  ),
  tabsetPanel(
    tabPanel(
      title = "Select Parameters",
      fluidRow(
        radioButtons(
          # These buttons are for selecting a region for the purposes of comparing release year
          # as the OCG and TCG have different release dates for certain things
          inputId = "region_input",
          label = "Select Region",
          choices = c("OCG", "TCG")
        ),
        fluidRow(
        column(
          width = 4,
          # I want to make a multiple selection input, but the graphs would not display correctly
          # Will need to correct 
          selectInput(
            inputId = "attribute_input",
            label = "Select Monster Attribute",
            choices = attribute_list,
            multiple = TRUE, 
            selected = "DARK"
          )
        ),
      
      column(
        width = 4,
        selectInput(
          inputId = "monster_input",
          label = "Select Monster Card Type",
          choices = monster_choices
        )
        )
      )
      )
    ),
    tabPanel(
      title = "output",
      plotOutput("output_plot")
    )
  
)
)
