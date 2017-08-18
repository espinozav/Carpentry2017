###DATA VIZ

library(tidyverse)

surveys_complete <- read.csv('data_output/surveys_complete.csv')

##ggplot2 ----

ggplot(data= surveys_complete, aes(x=weight, y=hindfoot_length)) + #telling we are going to be plotting off of this data, define aesthetics, plus sign adds more plotting instructions
  geom_point(alpha =0.8, aes(color=species_id)) #tells it what plot to create
  
##Challenge create a scatterplot of weight over species_id with this plot types
##showing in different colors.Is this a good way to show this type of data?

ggplot(data= surveys_complete, aes(x=weight, y=species_id)) + #telling we are going to be plotting off of this data, define aesthetics, plus sign adds more plotting instructions
  geom_point(alpha =0.8, aes(color=plot_type))
##NO!!!! USE BOXPLOT INSTEAD 
ggplot(data= surveys_complete, aes(y=weight, x=species_id))+
  geom_boxplot(aes(color=plot_type))+
  facet_grid(sex ~.)+
  labs(x="Species", 
       y="Weight",
       title="plot", 
       caption="This is a test boxplot...cool to caption within the code")+
  theme(legend.position="bottom")

##TIME SERIES ----
#total number of species over the years 
yearly_counts <- surveys_complete %>% 
  group_by(year, species_id) %>% 
  tally 

ggplot(data=yearly_counts, 
       aes(x=year, y=n, group=species_id, color=species_id)) +
  geom_line()+
  facet_wrap(~ species_id) # split this in different panels for specied_id
##now for yearly sex counts
yearly_sex_counts <- surveys_complete %>% 
  group_by(year, species_id, sex) %>% 
  tally

ggplot(data = yearly_sex_counts, 
       aes(x = year, y = n, color = sex)) +
  geom_line()+
  facet_wrap(~ species_id) # split this in different panels for specied_id

##Challenge (weight)
#create a plot that depicts how the average weight of each species changes through the years
yearly_weight <- surveys_complete %>% 
  group_by(year, species_id, weight) %>% 
  summarise(avg_weight=mean(weight)) %>% 
  tally

##assigning plot to myplot variable 
myplot <- ggplot(data = yearly_weight, 
       aes(x = year, y = n, color = species_id)) +
  geom_line()+
  facet_wrap(~ species_id) +
  labs(x="year", 
      y="Mean Weight (g)")+
  theme_bw()+
  theme(axis.text.x = element_text(angle=90), 
        legend.position="none")


ggsave("my_plot.png", myplot,width=15, height = 10) #saving ggplot 


