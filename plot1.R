###################################################
# Exploratory Data Analysis - W4Q1
# George Gustavo Mirocha 
###################################################

source('DTL.R')

#Q=Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Aggregating
EMs <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
EMs$PM <- round(EMs[,2]/1000000,2)
EY<-round(max(EMs$PM))+1

# Plot
png(filename='plot1.png')

barplot(EMs$PM, names.arg=EMs$Group.1, 
        main='Total Emission of PM2.5',
        xlab='Year', ylab='PM2.5 (Million of tons)',
		col=sample(c('green','blue','yellow','black')),
		yaxp=c(0,EY,EY)
	)
dev.off()

rm(list=ls())