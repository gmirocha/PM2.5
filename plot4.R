###################################################
# Exploratory Data Analysis - W4Q4
# George Gustavo Mirocha 
###################################################
require(ggplot2)
source('DTL.R')

#Q=Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


# Filt
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merge
merge <- merge(x=NEI, y=SCC.coal, by='SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

# Plot
png(filename='plot4.png')

ggplot(data=merge.sum, aes(x=Year, y=Emissions/1000)) + 
    geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
    ggtitle('US Total Emissions of PM2.5') + 
    ylab('PM2.5 (in k of tons)') + 
    geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
    theme(legend.position='none') + scale_colour_gradient(low='green', high='red')

dev.off()
