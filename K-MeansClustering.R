

# Clear plots
if(!is.null(dev.list())) dev.off()

# Clear console
cat("\014") 

# Clean workspace
rm(list=ls())

#Set work directory

setwd("C:\\Users\\bucka\\Downloads")

options(scipen=9)


##################################################
### Install Libraries                           ##
##################################################

#If the library is not already downloaded, download it

if(!require(dplyr)){install.packages("dplyr")}
library("dplyr")

if(!require(pastecs)){install.packages("pastecs")}
library("pastecs")

if(!require(ggplot2)){install.packages("ggplot2")}
library("ggplot2")

##################################################
### Read in Data                                ##
##################################################

Review_SB <- read.csv("Reviews.csv", header=TRUE)
Review_SB<-Review_SB[-c(1)] # removing user_ID column

normn <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

#Normalizing all the variables except UserID
Review_SB$Sports <- normn(Review_SB$Sports)
Review_SB$Religious <- normn(Review_SB$Religious)
Review_SB$Nature <- normn(Review_SB$Nature)
Review_SB$Theatre <- normn(Review_SB$Theatre)
Review_SB$Shopping <- normn(Review_SB$Shopping)
Review_SB$Picnic <- normn(Review_SB$Picnic)
Review_SB$Age <- normn(Review_SB$Age)
Review_SB$Income <- normn(Review_SB$Income)
Review_SB$Nbr <- normn(Review_SB$Nbr)

#histograms
par(mfrow=c(3,3))
hist(Review_SB$Sports)
hist(Review_SB$Religious)
hist(Review_SB$Nature)
hist(Review_SB$Theatre)
hist(Review_SB$Shopping)
hist(Review_SB$Picnic)
hist(Review_SB$Age)
hist(Review_SB$Income)
hist(Review_SB$Nbr)
par(mfrow=c(1,1))
par(mfrow=c(3,3))
boxplot(Review_SB$Sports,main='Sports')
boxplot(Review_SB$Religious,main='Religious')
boxplot(Review_SB$Nature,main='Nature')
boxplot(Review_SB$Theatre,main='Theatre')
boxplot(Review_SB$Shopping,main='Shopping')
boxplot(Review_SB$Picnic,main='Picnic')
boxplot(Review_SB$Age,main='Age')
boxplot(Review_SB$Income,main='Income')
boxplot(Review_SB$Nbr,main ='Nbr')
par(mfrow=c(1,1))

quantile(Review_SB$Sports,.95)
max(Review_SB$Sports)
#no outliers in Sports 

quantile(Review_SB$Religious,.95)
max(Review_SB$Religious,0.95)
#no outliers in Religious



summary(Review_SB)
stat.desc(Review_SB)
Review_SB<-Review_SB[-c(3,4,5,6)]
#Removing unassigned features such as Nature, Theatre, Shopping, Picnic

#data frame containing the normalized features Sports and Religious
Review_Clusters_SB<-Review_SB[c(1,2)]

Review_Clusters_SB

#Segmentation scheme for K 2-6

ClstrRev_2_SB <- kmeans(Review_Clusters_SB, iter.max=25, centers=2, nstart=10)
ClstrRev_2_SB$tot.withinss
ggplot(data=Review_Clusters_SB, aes(x=Sports, y=Religious,
                           color=ClstrRev_2_SB$cluster)) + geom_point()

ClstrRev_3_SB <- kmeans(Review_Clusters_SB, iter.max=25, centers=3, nstart=10)
ClstrRev_3_SB$tot.withinss
ggplot(data=Review_Clusters_SB, aes(x=Sports, y=Religious,
                                    color=ClstrRev_3_SB$cluster)) + geom_point()

ClstrRev_4_SB <- kmeans(Review_Clusters_SB, iter.max=25, centers=4, nstart=10)
ClstrRev_4_SB$tot.withinss
ggplot(data=Review_Clusters_SB, aes(x=Sports, y=Religious,
                                    color=ClstrRev_4_SB$cluster)) + geom_point()

ClstrRev_5_SB <- kmeans(Review_Clusters_SB, iter.max=25, centers=5, nstart=10)
ClstrRev_5_SB$tot.withinss
ggplot(data=Review_Clusters_SB, aes(x=Sports, y=Religious,
                                    color=ClstrRev_5_SB$cluster)) + geom_point()

ClstrRev_6_SB <- kmeans(Review_Clusters_SB, iter.max=25, centers=6, nstart=10)
ClstrRev_6_SB$tot.withinss
ggplot(data=Review_Clusters_SB, aes(x=Sports, y=Religious,
                                    color=ClstrRev_6_SB$cluster)) + geom_point()

#elbow plot
k_vector_SB<-c(2,3,4,5,6)
wss_totwithin_SB<-c(ClstrRev_2_SB$tot.withinss,ClstrRev_3_SB$tot.withinss,
           ClstrRev_4_SB$tot.withinss,ClstrRev_5_SB$tot.withinss,
           ClstrRev_6_SB$tot.withinss)
plot(k_vector_SB,wss_totwithin_SB,type = 'l',main = 'Elbow plot',sub = 'Identifying the optimal K')


############
# k=4 optimal values
Review_SB$cluster <- factor(ClstrRev_4_SB$cluster)   # Adding Cluster tags to variables

centers <- data.frame(cluster=factor(1:4), ClstrRev_4_SB$centers)

###################################################
## Plotting the Clusters                        ##
###################################################


ggplot(data=Review_SB, aes(x=Sports, y=Religious,
                           color=Review_SB$cluster)) + geom_point()

ggplot(data=Review_SB, aes(x=Sports, y=Religious, color=cluster, shape=cluster)) + 
  geom_point(alpha=.99) +
  geom_point(data=centers, aes(x=Sports, y=Religious), size=5, stroke=3)


Review_SUM_SB <- Review_SB %>% 
  group_by(cluster) %>% 
  summarise(Sports = mean(Sports), Religious = mean(Religious), Age=mean(Age),
            Income=mean(Income), Nbr=mean(Nbr),N=n() )

Review_SUM_SB


