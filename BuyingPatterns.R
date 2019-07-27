#Load Data Set
mydata <- read.csv("data/Blackwell_Hist_Sample.csv")
#Load needed libraries
library(ggplot2)
library(bda)
library(zoo)
#Binning age to 4 different bins
mydata$ageGroup <- cut(mydata$age,breaks=c(0,30,49,65,85))

#Other binning methods:
#test <- tapply(mydata$age, cut(mydata$age, 3), median)
#bin_ids = kmeans(mydata$age,3); 
#out2 <- binning(freq=mydata$age, breaks=3, bw=34.75)

# mentor sugestions -------------------------------------------------------

ggplot(data = mydata, mapping = aes(x = region, fill = ageGroup)) +
  geom_bar(position = "dodge", colour="#666666") +
  labs(x="Region", y="ageCount", title="Region vs Age Groups")
  # geom_text(mapping = aes(label = ..count..), stat = "count", vjust = -1)

library(dplyr)
library(tidyr)

mydata2<-mydata

#change 0 to online and 1 to store (more meaningful)
mydata2$in.store <-replace(mydata2$in.store, mydata2$in.store==0, "online")
mydata2$in.store <-replace(mydata2$in.store, mydata2$in.store==1, "store")

#convert instore to binomial
mydata2$in.store <- factor(mydata2$in.store)

#plot age vs where
ggplot(data = mydata2, mapping = aes(x = ageGroup, fill = in.store)) +
  geom_bar(aes(), position = "dodge" )+
  labs(x="Age", y="Store", title="Age vs Store/Online")

mydata %>% 
  mutate_at("in.store", as.factor) %>% 
  mutate_at("region" , as.factor) %>% 
  str()

mydata %>% 
  group_by(ageGroup) %>% 
  summarize(count(age)) %>% 
  ggplot(aes(region, age)) 
