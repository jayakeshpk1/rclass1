# returns path for the current working directory 
getwd() 
# set the working directory to a specified directory 
setwd("~/Dropbox/Comp/Bowery/Analytics/Classes/R/Class 1/Content")

# basically removes everything in the working environment. 
rm(list = ls())

# default shows 25 most recent commands 
history() 
# show 100 most recent commands 
history(100) 
# show entire saved history 
history(Inf)

# provides general help links 
help.start() 
# searches the help system
help.search ("getwd")

#Numbers:
#Double:
double_var = c(1, 2.5, 4.5)
double_var
typeof(double_var)

#Integers:
int_var = c(1L, 2L, 2L)
int_var
typeof(int_var)

#Integer to Double
int_to_double=as.double(int_var)
int_to_double
typeof(int_to_double)

#Doubles to integers
double_to_integer = as.integer(double_var)
double_to_integer
typeof(double_to_integer)

#Generate a sequence
1:10
seq1 = c(1:10)
seq1

#Regular Sequence
seq2 = seq (from = 1, to = 10, by = 2)
seq2

#Repeat Sequence
rep1 = rep(1:4, times=2)
rep1

#Repeat Collate Sequence
rep2 = rep(1:4, each=2)
rep2

#Characters
basicstring = "Learning R Strings"
basicstring

#String Concatenation using Paste
basicstring2 = "Continued."

#strcat
paste(basicstring, basicstring2)
paste(basicstring, basicstring2,sep = "-")
paste0(basicstring, basicstring2,sep = "-")

is.character(basicstring)
basicstring_vector = c("Hello", "World",2016);
basicstring3=toString(basicstring3)

#Factors
gender = factor(c("male","female"))
gender
class(gender)

#What are the levels.
levels(gender)

#summary
summary(gender)

#Revalue
install.packages("plyr")
library(plyr)
reval_gender = plyr:: revalue (gender, c ("male" = "m", "female" = "f"))
reval_gender

#Data Structures
#Creating Vectors:

vector1 = 8:19
vector1

#Double Vector
vector2 = c(0.5, 0.6, 0.2)
vector2

#logical vector
vector3 = c(TRUE, FALSE, FALSE)
vector3

vector4 = c(T, F, F)
vector4

#Numerical Vector to character.
charvector = as.vector(vector1, mode="character")
charvector

#mixed vectors
#Numerics are turned to characters
#Logical are turned to numerics

logicalvector = c(1,2, TRUE, FALSE)
logicalvector

#Adding to vectors
vector5 = c(vector1, 18:22)
vector5

#Attributes to Vectors
attributes(vector5)

#adding names to vectors
vectorattributenames = c(First="Hello", Second = "World");
vectorattributenames
attributes(vectorattributenames)
comment(vectorattributenames) = "This holds hello world."
attributes(vectorattributenames)

#subsetting vectors
vector5
vector5[3]
vector5[5:8]

#Negative Subsetting
vector5[-3]

#logical subsetting
vector5[vector5 < 10]
lessthan10 = vector5[vector5 < 10]
lessthan10

#subsetting with names
vectorattributenames
vectorattributenames["First"]

#list
#list can have mixed types

list1 = list(1:3,"a", c(TRUE, FALSE, TRUE, c(2.5,4.2)))
list1

#Addint to lists
list2 = list(list1, c(3,4))
list2

#Append function
list3 = append(list2, list(c(5,6)))
list3

#Append
list3$newitem = "New list item"
list3

#subsetting list
list3[1]
list3["newitem"]
list3[c(1,3)]
list3[[1]][3]
list3[[1]][[1]][3]

#Matrices
#creating a matrix
mat1 = matrix(1:6, nrow=2, ncol=3) 
mat1

#rbind
mat2 = c(5,6,7)
rbind(mat2, mat1)

#cbind
mat3 = c(8,9)
cbind(mat1, mat3)

#attributes
attributes(mat1)
rownames(mat1) = c("R1", "R2")
attributes(mat1)

colnames(mat1) = c("C1", "C2", "C3")
attributes(mat1)

#subsetting matrices
#Get row1
mat1[1,] 

#Get Col2 and Col3
mat1[,2:3]


#Data Frames
#list of vectors.
df <- data.frame(
  col1 = 1:3, 
  col2 = c ("this", "is", "text"), 
  col3 = c (TRUE, FALSE, TRUE), 
  col4 = c (2.5, 4.2, pi)
  )
View(df)
nrow(df)
ncol(df)

#Adding a new column to a dataframe
col5 = c(5,6,7)
newdf = cbind(df,col5)
View(newdf)

colnames (df) <- c ("col_1", "col_2", "col_3", "col_4")
View(df)

#Get a specific column values.
df$col1

#subsetting dataframes
#by row numbers
df[2:3,]

#By Column Names
df[,c("col_2","col_3"),]

#subset clause
df2 = subset(df, col_2=="is")
View(df2)

#Which
df3 <- df[which(df$col_3=='TRUE'),]
View(df3)

#sqldf
install.packages("sqldf")
library(sqldf)
df4 <- sqldf("select * from df where col_1='1'")
View(df4)


























