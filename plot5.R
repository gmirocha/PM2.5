###################################################
# Exploratory Data Analysis - W4Q5
# George Gustavo Mirocha 
###################################################
require(ggplot2)
source('DTL.R')

#Q=How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

# FAC
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Sub & Aggregate
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

#Plot
png('plot5.png')

ggplot(data=MD.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year),stat="identity") + guides(fill=F) + 
    ggtitle('Emissions of Motor Vehicle Sources','Baltimore City, Maryland') + 
    ylab('PM2.5') + xlab('Year') + theme(legend.position='none') + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

dev.off()
