#Introduction to R
#08/25/2017
#PS231A
#GSI: David Foster
#Thank you to Shinhye Choi, Stephen Goggin, and Katherine Michel creating these materials.

#Start by doing the following (we'll hopefully get to this at the end!):
install.packages("foreign")
library(foreign)


###################################
#Basic operations: creating objects
###################################

# <- is the assignment operator. It assigns whatever is on the right side as an object on the left

#assigning a single value
x <- 5
y <- x^5

#creating a numeric vector
example.vector <- c(1,2,3,4,5,6)
#What is the c in the above expression?
#Note: If you are unsure about a command, type ? followed by that command to see the help file. 

#If you want to look at the object you created, call it.
example.vector

#creating a larger vector
example.gigantic.vector <- 1:1000000
#Note: The ":" translates as "through," so we've created a sequence of integers from one through 1000000.

#creating a character vector
example.vector.string <- c("a","b","c","d","e","f")
#The quotation marks tell R that you are looking at characters.

#creating a matrix
example.matrix1 <- matrix(example.vector, nrow = 2, ncol = 3, byrow = TRUE)
#The 2 corresponds to the number of rows and the 3 corresponds to the number of columns. 

#Note 1: It is equivalent to write example.matrix <- matrix(example.vector, 2, 3, byrow=TRUE).
#Note 2: The default for "byrow" is FALSE. What changes if we keep the default settings?
example.matrix2 <- matrix(example.vector, nrow = 2, ncol = 3)
example.matrix2

#creating a data frame (a list of variables of the same length with unique column names)
example.dataframe1 <- data.frame(example.vector,example.vector.string)
example.dataframe2 <- as.data.frame(cbind(example.vector,example.vector.string))
#What is cbind() doing in the second example above?

#Note: Some functions in R work with only a data frame OR a matrix.
#Sometimes the solution to a weird error message is to turn your data frame into a matrix or vice versa.


###################
#Looking at objects
###################

#Like we saw above, we can look at the objects we created by calling their assigned name (what's 
#to the left of <-).
#This will print out the raw data.
example.dataframe1

#But, note the limits:
example.gigantic.vector

#What other information can we print out? 
#We can look at only the first five rows of the object.
head(example.dataframe1)

#Or, we can access a specific element in an object through its index.
example.vector
example.vector[2]
#First, list the name of the object. 
#Second, reference the element that you want inside square brackets.

#Or, we can use indices to look at subsets of an object.
subset.dataframe <- example.dataframe1[1:3,]
#The 1:3 before the comma tells R to look at the first three rows. 
#With no specification after the comma, R looks across all columns.
#What if we wanted to create a new data frame that includes only the first two rows and columns?

######################
#Attributes of objects
######################

#What types are our objects?
class(example.dataframe1)
class(example.matrix1)
class(example.vector)
class(example.vector.string)
#Why does the class of an object matter?

#Note: To coerce an object into a different class, use as.*() commands, like as.numeric() or 
#as.character().

#How big are our objects?
length(example.gigantic.vector)
dim(example.dataframe1)
length(example.dataframe1)
#What is length() telling us here?

#If we instead wanted the length of a certain variable in our data frame, how we would find it?
#First, we might want to remind ourselves of the names of the variables in our data frame.
names(example.dataframe1)

#To access either of these variables on their own, we can use the $ sign 
example.dataframe1$example.vector
example.dataframe1$example.vector.string
length(example.dataframe1$example.vector)

#Note: equivalently, we can attach() the data frame and then call the variable's name.
#With attach(), there is no need to use $.
attach(example.dataframe1)
example.vector
detach(example.dataframe1)
#Note: Look back at the R output following attach().
#If you duplicate the name of an object, the newest variable with that name is used.
#So, be sure to detach a dataset when you're done using it!


###################
#Reminder: help!
###################

#If you're curious about what a function does, type a question mark before it.
#This does the same thing: help()
#If you use two question marks, R searches the entirety of help files. 


############################################
#Measures of central tendency and dispersion
############################################

#We can look at summary statistics for our objects.
summary(example.gigantic.vector)
summary(example.dataframe1)

#Measures of central tendency (mean, median, mode)
#While summary() provides the mean, you can also find it directly with mean().
mean(example.gigantic.vector)

#Similarly, you can directly find the median with median().
median(example.gigantic.vector)

#But does this work for an even-length dataset?
even <- c(2,1,3,3,3,4,5,6,6,7)
median(even)
#We see that the median() command returns the average between the two middle values.

#How might we write code to find a range of median values when we have an even set? 
#We can write a function for this! (This is beyond where we're at right now, but it is still good
#to think through what the code should look like.)
#Step one: We need to figure out if a set contains an even or odd number of observations. 
#Step two: When odd, we want the function to use the normal median() command.
#Step three: When even, we want the function to return the range of median values.
median.all = function(x){
  if (length(x) %% 2 != 0){
    which(x == median(x))
  } 
  else if (length(x) %% 2 == 0){
    a = sort(x)[c(length(x)/2, (length(x)/2)+1)]
    return(a)
  }
}
median.all(c(5,6,7,8))
#This function contains a number of pieces that we've already seen! What are they?
#Notice that functions are self-contained, so we must call them with respect to our data.
median.all(even)

#How can we find the mode? Let's look at a new set.
data <- c(1,2,3,4,4,5,5,5,6,7,8)
#Like a median range, finding the mode is not necessarily straightforward, but here is one way:
#Step one: Create a table of frequency counts for all unique values in the vector.
table <- table(as.vector(data))
table
#Step two: Have R return a numeric value for the name of the value with the maximum frequency.
mode <- as.numeric(names(table)[table==max(table)])
mode

#Measures of dispersion
#Luckily, finding the standard deviation is easy with the command sd()!
sd(example.gigantic.vector)

#Note: We can also see the values for the first and third quartiles (to compute IQR) with summary().


########################################################
#Enough silly made-up data! Let's talk about real data!
########################################################

#First things first: We need to figure out where we are. Let's see what our working directory is.
getwd()

#If you saved the data files somewhere other than where getwd() lists, change your working directory.
#Use setwd() to change your working directory.
setwd("C:/Users/David/Google Drive/PhD Files/GSI 231A 2017-Fall/Section 1")


##############
#Loading data
##############

#Once you're in the correct working directory, you can load in your data.
#Note: Many commands for loading different file types take the format "read.***('FilePath')"

#Let's start by reading in a .csv file.
csv.example <- read.csv('example.csv')

#Just for practice, let's read in the same material in a Stata (.dta) file.
dta.example <- read.dta('example.dta')

#Note1: We can  read in  SPSS (.sav) files with read.spss(.sav).
#Note2: R also has a native data file format. We can read this type of file with load(file=" .Rdata").
#Note3: We have read a Stata 12 file.  Reading a Stata 13 file requires the package readstata13 and the command read.dta13.

##############
#Saving files
##############

#Suppose we want to save our two files. 
save(csv.example, dta.example, file="example.datafile.RData")
#This new file now appears in our working directory. 
#If you want to save it elsewhere, you can specify a full file path.

#Note1: The .RData file contains two data frames in a single file. It is not possible to do this with .csv, .dta, or .sav files.
#Note2: We can also save the current workspace with save.image().

#We can also save a .csv file or a .dta file directly in R.
write.csv(csv.example, file="example.csvsave.csv")
write.dta(dta.example, file="example.dtasave.dta")


###################################
#Practice: playing with csv.example
###################################

#Where should we start? How can we summarize the data?

#What if I just want a vector of all the electoral college vote shares in the example data?
#What's another way to do this?

#How can I find the mean of the electoralcollege variable? The standard deviation?

#How can I show this relationship graphically?
#Histograms
hist(electoralcollege)

#What if I want it to be blue?
hist(electoralcollege, col="blue")

#What if I want more bins?
hist(electoralcollege, breaks=10, col="blue")

#What if I want labels?
hist(electoralcollege, breaks=10, col="blue", xlab="Percentage", main="Electoral College Example")
#Note: Look at ?hist to see all of the arguments

#What if I want to add in a vertical line to show the mean?
abline(v=mean(electoralcollege), col="red")

#We can also add lines to show typical values within one standard deviation
abline(v=(mean(electoralcollege)+sd(electoralcollege)), col="green")
abline(v=(mean(electoralcollege)-sd(electoralcollege)), col="green")

#Density plots
ECdensity <- density(electoralcollege)
plot(ECdensity, col="blue", main = "Electoral College Density Example")

#Now let's look at more than one variable in this data. 
#How might we summarize the relationship between two variables of interest?

#How might we show this relationship graphically?

#How can we make a data frame from two variables: YEAR and ECVOTE?

#What if I wanted a subset of the data -- electoral college vote shares since 1972?
#Note: Look up subset() for another way to do this!


##################################
#Keeping track of what you've done
##################################

#We created a lot of objects today. How can we know What we have in our workspace?
ls()
#We can remove an object that we don't want.
rm(example.vector.string)
ls()
#We can also clear everything out.
rm(list=ls())
ls()


##################################################
#Extra material 1: installing and loading packages
##################################################

#While we often want to use our own data, some packages in R also have datasets that may be useful
#for you to practice on. 
#There are MANY packages available, but to utilize them you must first install them. 
#We loaded the useful package "foreign" at the beginning of the session.
#This allows us to read data from many other formats, like SPSS and Stata.
#Another useful package is called "car," which has tools related to regression and data manipulation.
install.packages("car")

#Once you install a package on your machine, there is no need to reinstall it every time. 
#Instead, use this command to load in the package.
library(car)

#To view the data in a loaded package, you can use the command data().
#To load a specific dataset from within a package, you call that dataset by name. 
#For example, within the MASS package, we can look at a dataset of animal body and brain weights.
#What do you need to do to find this data?
head(Animals)

#Practice: How can you find the number of observations in the Animals data?

#Practice: How can you find the brain column?

#Practice: How can you find out the variable values of "Cow"?

#For now, we can just look at which row "Cow" is in, but what if we want R to tell us? 
#Try this alternative to find the row number:
which(row.names(Animals)=="Cow")

#What if we want to look at a subset of "big" animals?
#Let's define big as follows
big <- body[body>=500]
length(big)

#Now, let's instead look at a list of the big animals
Animals[body>=500,]

#What if we want more than one condition? We can use logical operators AND (&), OR (|), and NOT (!)
Animals[body>=500 & brain<700,] 
Animals[brain<100 | brain>700,]
Animals[!brain<1000,]
Animals[body>500 & !brain<1000,]

detach(Animals)


#####################################
#Extra material 2: recoding variables
#####################################

#Let's recode some data. Note that the recode function is from the car library
century <- recode(csv.example$YEAR, "1948 = '20th'; 1952 = '20th'; 1956 = '20th'; 1960 = '20th'; 1964 = '20th'; 1968 = '20th'; 1972 = '20th'; 1976 = '20th'; 1980 = '20th'; 1984 = '20th'; 1988 = '20th'; 1992 = '20th'; 1996 = '20th'; 2000 = '21st'; 2004 = '21st'; 2008 = '21st'") 

winner <- recode(csv.example$YEAR, "1948 = 'Truman'; 1952 = 'Eisenhower'; 1956 = 'Eisenhower'; 1960 = 'Kennedy'; 1964 = 'Johnson'; 1968 = 'Nixon'; 1972 = 'Nixon'; 1976 = 'Carter'; 1980 = 'Reagan'; 1984 = 'Reagan'; 1988 = 'Bush'; 1992 = 'Clinton'; 1996 = 'Clinton'; 2000 = 'Bush'; 2004 = 'Bush'; 2008 = 'Obama'") 

#Now let's add the recoded year and winner to the data frame:
new.dataset <- cbind(csv.example,century,winner)
new.dataset
csv.example


#################################
#End of section one introduction!
#################################