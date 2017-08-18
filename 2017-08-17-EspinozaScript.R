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

plot(surveys$year,surveys$weight) 
plot(surveys$hindfoot_length,surveys$weight)

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

#########################################
#### END OF DAY 1 DATA WORKSHOP##########
#########################################
#August 18,2017- Day 2 