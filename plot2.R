###################################################
# Exploratory Data Analysis - W4Q2
# George Gustavo Mirocha 
###################################################

source('DTL.R')

#Q=Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Subset & Aggregating
NEI<-subset(NEI, fips=='24510')
EMs <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
EMs$PM <- EMs$x
EY<-round(max(EMs$PM))+1

# Plot
png(filename='plot2.png')
barplot(EMs$PM, names.arg=EMs$Group.1, 
        main='Total Emission of PM2.5 in Baltimore City, Maryland',
        xlab='Year', ylab='PM2.5 (in tons)',
		col=rainbow(4),
	)
dev.off()

rm(list=ls())
