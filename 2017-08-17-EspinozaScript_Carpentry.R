##my script from Data carpentry UC Merced
##Vicky Espinoza vespinoza2@ucmerced.edu
####

##download data - do this once 
#download.file (from where, to where) ----
download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")


#read data into R ----
surveys <- read.csv("data/portal_data_joined.csv")

#explore the data context ----
head(surveys) #show me the first 6 rows of data 
tail(surveys) #show me the last 6 rows of data
tail(surveys,12) # show me the last 12 rows of data 

##summaries ----
str(surveys) #show me the structure of the dataset (summary of the data)
#note:data.frame is equivalent to a matrice in Matlab
summary(surveys) # shows basic stats of the data

##explore the size of the data frame 
dim(surveys) #show me rows and columns
nrow(surveys) #show the rows
ncol(surveys) #show the columns 
names(surveys) #show the name of the columns

##the $ operator for isolating columns 
tail(surveys$weight) 
str(surveys$weight) 
summary(surveys$weight)

##plot 

plot(surveys$year,surveys$weight) #plotting (x,y) variables

#explore the month with histograms
summary(surveys$month)
hist(surveys$month, col='grey', breaks =12) #histogram of the month 

##explore taxa variable (non-numeric)
summary(surveys$taxa)
#the categories are called levels 
levels(surveys$taxa)
#give me how many levels I have 
nlevels(surveys$taxa)
#plotting this non-numeric data gives an error!!! BUT we can use the table function to make the data table 
##instead of factor 

table(surveys$taxa) #reprints the levels 
class(table(surveys$taxa))

##subsetting in terms of rows and columns 
##filering is subsetting my rows
##selecting is subset by columns
#order is always rows columns --> [rows,columns]

surveys[surveys$genus == 'Ammodramus', ] #leaving a blank will extract every column 
surveys[surveys$genus == 'Ammodramus', c('record_id', 'month', 'weight')] #return a few columns, the c function creates a vector of combines
#strings or columns 

##how many rows are there in january and february? various methods to get the same answer
nrow(surveys[surveys$month==1 | surveys$month == 2, ])  #give me the number of rows from survey month for 1 or 2
nrow(surveys[surveys$month==1, ]) #give me the number of rows for the month of 1 
(summary(surveys$month <3)) #true or false for the month less than March 
(summary(surveys$month==1)) #this is the true or false for Jan
length(which(surveys$month < 3)) #give me the length (ie how many rows) of the month values less than 3 
summary(as.factor(surveys$month)) #give me the number of rows for all the months 

##########################################
#### END OF DAY 1 DATA WORKSHOP###########
##########################################
####STARTING DAY 2 of WORKSHOP###########
####August 18,2017- Day 2 ###############
#########################################

surveys <- read.csv("data/portal_data_joined.csv") #reading in the data 

install.packages("tidyverse") #instal tidyverse
library(tidyverse) #check if tidyverse is in my packages library 

#dplyr package that deals with filter, select, mutate, ,summaries 

#select columns from the surveys dataset 
select(surveys, plot_id, species_id, weight) #same as line 61 but human readable 

##using filter to slect rows where year is 1995 
filter(surveys, year ==1995) 

##want rows for 1995 and select id 

##pipes! it's like connections between functions 
%>%  #command shift m 
  
surveys_SML <- surveys  %>% 
  filter(year ==1995) %>% 
  select(year, plot_id, species_id, weight)

head(surveys_SML) #check the first 6 rows of the new dataset

##mutate 
surveys %>% 
  filter(!is.na(weight)) %>%  #remove NAs 
  mutate(weight_kg=weight / 1000, 
         weight_kg2= weight_kg*2) %>%  ##the new column is being mutated to kg
  head#we can pipe the tail function without havig to use parenthesis! 

##Challenge
##Create a new data frame from the surveys data that meets the following
##criteria: contains only the species_id column and a new column called
##hindfoot_half containing values that are half the hindfoot_lengthvalues. In
##this hindfoot_half column, there are there are no NAs and all values are less than 30 

surveys_hf <- surveys %>% 
  select(species_id, hindfoot_length) %>% 
  mutate(hindfoot_length2=hindfoot_length / 2) %>% 
  filter(hindfoot_length2<30) %>% 
  filter(!is.na(hindfoot_length2)) #%>% 
#head 

##improvement 
surveys_hf <- surveys %>% 
  select(species_id, hindfoot_length) %>% 
  mutate(hindfoot_length2=hindfoot_length / 2) %>% 
  filter(hindfoot_length2<30,(!is.na(hindfoot_length2)) 
         
##what is the average weight for males and females ?
##learning to use group_by and summarize 
male_female <- surveys %>% 
  filter(!is.na(weight), 
         sex=="F" | sex =="M") %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight= mean(weight),
            min_weight=min(weight))# can do the removal of the NA within the function to reduce key stroke --> ,na.rm =TRUE ))  #R returns NA if not removed from the mean 
#total count of number of males and females -->use tally
  surveys %>% 
  group_by(sex) %>% 
    tally 

