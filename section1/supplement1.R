#Supplementary information
#08/25/2017
#PS231A
#GSI: David Foster
#Thanks to Katherine Michel for creating materials.

##########################################
#Question one: Can we override max(print)?
##########################################

#Yes!
#Remember that when we created a huge vector and had R print the raw data, there were limits.
huge.vector <- c(1:1000000)
huge.vector

#If we want to force R to print out all of the results, we can change max(print) in this way:
options(max.print=1000000)
huge.vector


##############################################
#Question two: What about missing values (NA)?
##############################################

#If we have two vectors of different lengths, can we make a data frame?
var1 <- c(1,2,3,4,5)
var2 <- c(1,2,3,4)
dataframe1 <- as.data.frame(cbind(var1,var2))
#No, this gives us an error!

#If instead, we have two vectors of the same length:
var4 <- c(1,2,3)
var5 <- c(4,5,6)
dataframe2 <- as.data.frame(cbind(var4,var5))
#We can create a data frame!

#What if for some reason it's the case that the fifth element of var2 is actually NA? 
#How can we show that this is a missing value?
var2[5] <- NA      
#This makes a 5th element of var2. 
#Now, we can make a data frame from the two vectors.
dataframe3 <- as.data.frame(cbind(var1,var2))

#Suppose there is a mistake in the data frame and we need to make the 2nd element of var1 NA.
dataframe3[2,1] <- NA      
dataframe3
#The value in row 2, column 1 is now a missing value.

#Note 1: If we use summary() now, we will see an additional output for NA's.
#Note 2: We can also see a matrix of which values are missing with the command is.na(dataframe3).
#Note 3: If you were interested in which values are NOT missing, you could do the opposite of
#above with the command !is.na(dataframe3).


########################################################
#Question three: Should we use _ or . in variable names?
########################################################

#Either is fine!
#Let's reload the data from section with slightly different variable names.
getwd()
setwd("C:/Users/Katherine/Dropbox/231A/data")
varnames <- read.csv('example.var.names.csv',header=TRUE)
head(varnames)
attach(varnames)
varnames.dataframe <- as.data.frame(cbind(pop.2,ec_vote))
varnames.dataframe
detach(varnames)

######################
#End of supplement one
######################