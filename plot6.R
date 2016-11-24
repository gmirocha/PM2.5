###################################################
# Exploratory Data Analysis - W4Q6
# George Gustavo Mirocha 
###################################################
require(ggplot2)
source('DTL.R')

#Q=Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
 
# FAC
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Subset & Aggregate
MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

MD.DF <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.DF) <- c('year', 'Emissions')
MD.DF$City <- paste(rep('MD', 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum)
colnames(CA.DF) <- c('year', 'Emissions')
CA.DF$City <- paste(rep('CA', 4))
DF <- as.data.frame(rbind(MD.DF, CA.DF))

#PLOT
png('plot6.png', width=800, height=600, units='px')

ggplot(data=DF, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year),stat="identity") + guides(fill=F) + 
    ggtitle('Emissions of Motor Vehicle Sources','Los Angeles County, California X Baltimore City, Maryland') + 
    ylab('PM2.5') + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

dev.off()
