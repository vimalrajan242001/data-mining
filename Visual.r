getwd()
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)
library(highcharter)
library(scales)

#---------------------Read the datasets---------------------------------------
airline <- read.csv("Airlinewise Monthly International Air Traffic To And From The Indian Territory.csv")
View(airline)

Countrywise <-read.csv("Countrywise Quarterly International Air Traffic To And From The Indian Territory.csv")
Countrywise

Citywise<-read.csv("Citypairwise Quarterly International  Air Traffic To And From The Indian Territory.csv")
Citywise

quarter_wise_domestic <-airline %>%filter(CARRIER.TYPE=="DOMESTIC") %>%
  group_by(YEAR,QUARTER) %>%
  summarise(Passengers_ToInd=sum(PASSENGERS.TO.INDIA),Passengers_FromInd=sum(PASSENGERS.FROM.INDIA)) 
quarter_wise_domestic
View(quarter_wise_domestic)
gather(quarter_wise_domestic,key=Category,Total,3:4) %>%
  ggplot(aes(x=QUARTER,y=Total,fill=Category)) +
  geom_bar(stat="identity",position="dodge") +
  facet_wrap(~YEAR) +
  scale_y_continuous(labels = comma) +
  labs(title="Quarter Wise Travellers Domestic Flights",x="Quarter",y="Passengers") 


quarter_wise_foreign <-airline %>%filter(CARRIER.TYPE=="FOREIGN") %>%
  group_by(YEAR,QUARTER) %>%
  summarise(Passengers_ToInd=sum(PASSENGERS.TO.INDIA),Passengers_FromInd=sum(PASSENGERS.FROM.INDIA)) 
gather(quarter_wise_foreign,key=Category,Total,3:4) %>%
  ggplot(aes(x=QUARTER,y=Total,fill=Category)) +
  geom_bar(stat="identity",position="dodge") +
  facet_wrap(~YEAR) +
  scale_y_continuous(labels = comma) +
  labs(title="Quarter Wise Travellers foreign Flights",x="Quarter",y="Passengers") 

#Lets investigate Country Wise Data
colnames(Countrywise) <-c("YEAR","QUARTER","COUNTRY_NAME","PASSENGERS_TO_INDIA","PASSENGERS_FROM_INDIA","FREIGHT_TO_INDIA","FREIGHT_FROM_INDIA")
Countrywise$COUNTRY_NAME[Countrywise$COUNTRY_NAME=="UNITED ARAB EMIRATES*"] <-"UNITED ARAB EMIRATES"

Countrywise %>% filter(YEAR=="2015") %>% group_by(COUNTRY_NAME) %>% 
  summarise(Total = sum(PASSENGERS_TO_INDIA)) %>%
  arrange(desc(Total)) %>% top_n(n=10, Total) %>%
  hchart(type="treemap",hcaes(x=COUNTRY_NAME,value=Total,color=Total)) %>%
  hc_add_theme(hc_theme_google()) %>%
  hc_title(text="Top 25 Countries-Passengers to India 2015")

Countrywise %>% filter(YEAR=="2016") %>% group_by(COUNTRY_NAME) %>% 
  summarise(Total = sum(PASSENGERS_TO_INDIA)) %>%
  arrange(desc(Total)) %>% top_n(n=50, Total) %>%
  hchart(type="treemap",hcaes(x=COUNTRY_NAME,value=Total,color=Total)) %>%
  hc_add_theme(hc_theme_google()) %>%
  hc_title(text="Top 25 Countries-Passengers to India 2016")


colnames(Citywise) <-c("YEAR",
                       "QUARTER",
                       "CITY1",
                       "CITY2",
                       "PASSENGERS_FROM_CITY1_TO_CITY2",
                       "PASSENGERS_FROM_CITY2_TO_CITY1",
                       "FREIGHT_FROM_CITY1_TO_CITY2",
                       "FREIGHT_FROM_CITY2_TO_CITY1")


#Summarise the total
str(Citywise)
dim(Citywise)
Citywise %>% group_by(CITY1)
Citywise %>% summarise(Total=sum(PASSENGERS_FROM_CITY1_TO_CITY2)) 
Citywise %>%
  filter(YEAR=="2015") %>%
  group_by(CITY2) %>%
  summarise(Total=sum(PASSENGERS_FROM_CITY2_TO_CITY1)) %>%
  arrange(desc(Total)) %>%
  top_n(n=25,Total) %>%
  hchart(type="treemap",hcaes(x=CITY2,value=Total,color=Total)) %>%
  hc_add_theme(hc_theme_google()) %>%
  hc_title(text="Top 25 Passengers from Indian cities to foreign 2015")


quarter_wise <-Citywise %>% group_by(YEAR,QUARTER) %>%
  summarise(Passenger_from_City1_to_city2=sum(PASSENGERS_FROM_CITY1_TO_CITY2),Passenger_from_city2_to_city1=sum(PASSENGERS_FROM_CITY2_TO_CITY1)) 

plot<-gather(quarter_wise,key=Category,Total,3:4) %>%
  ggplot(aes(x=QUARTER,y=Total,fill=Category)) +
  geom_bar(stat="identity",position="dodge") +
  facet_wrap(~YEAR) +
  scale_y_continuous(labels = comma) +
  labs(title="Quarter Wise Traveller",x="Quarter",y="Passengers")

pie <- plot + coord_polar("y", start=0)
pie


covid <- read.csv("COVID19_line_list_data.csv")
covid
View(covid)
dim(covid)
