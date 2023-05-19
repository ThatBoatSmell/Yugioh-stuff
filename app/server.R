server <- function(input, output, session) {
  
  # This creates a new column based on the region the user selected, 
  # which supplies the Year a card was released in said Region
  # It then groups by this newly created column so it can be used
  # for plotting the line chart
  
  filtered_if <- eventReactive(eventExpr = input$region_input,
                               valueExpr = {
                                 if (input$region_input == "OCG")
                                   cards_wide %>% 
                                   mutate(release_year = as.numeric(format(ymd(ocg_release),'%Y'))) %>% 
                                   group_by(release_year) 
                                 else 
                                   cards_wide %>%
                                   mutate(release_year = as.numeric(format(ymd(tcg_release),'%Y'))) %>% 
                                   group_by(release_year)
                               })
  
  output$output_plot<- renderPlot({ 
    filtered_if() %>% 
      filter(type %in% input$monster_input) %>% 
      filter(attribute %in% input$attribute_input) %>% 
      group_by(attribute, release_year) %>% 
      summarise(avg_stat_total_by_year = floor(mean(stat_total))) %>% 
      arrange(attribute) %>% 
      ggplot(aes(x = release_year, y = avg_stat_total_by_year)) +
      geom_line(aes(colour = attribute)) +
      geom_point(aes(shape = attribute)) +
      labs(
        title = "Average stat total by release year",
        x = "Release Year",
        y = "Average ATK + DEF") +
      theme_bw()
    
  })            
}