require(ggplot2)
require(plyr)
require(splitstackshape)
require(lme4)
require(afex)

grate<-read.csv("./data/growthrate.csv",header=T)

grate1<-cSplit(grate, "Tray", sep=" ", drop=F)
grate1$Pop[1:9215]<-grate1$Tray_1[1:9215]
grate1$Tray2[1:9215]<-grate1$Tray_2[1:9215]
grate1$Site<-gsub("manchester","Manchester",grate1$Site)
grate1$Tray<-NULL
grate1$Tray_1<-NULL
grate1$Tray_2<-NULL
grate1$Date<-as.Date(grate1$Date, "%m/%d/%Y")



gratemean<-ddply(grate1,.(Date,Pop,Site),summarise,mean_length=mean(Length.mm,na.rm=T),
                 sd=sd(Length.mm,na.rm=T), N=length(Length.mm),se=sd/sqrt(N))
ciMult<-qt(0.975/2+.5,gratemean$N-1)
gratemean$ci<-gratemean$se*ciMult


grfid<-gratemean[which(gratemean$Site=="Fidalgo"& gratemean$Date<="2014-05-02"|gratemean$Site=="Fidalgo"&gratemean$Date>="2014-09-19"),]
grman<-gratemean[which(gratemean$Site=="Manchester"& gratemean$Date<="2014-05-02"|gratemean$Site=="Manchester"&gratemean$Date>="2014-09-19"),]
groys<-gratemean[which(gratemean$Site=="Oyster Bay"& gratemean$Date<="2014-05-02"|gratemean$Site=="Oyster Bay"&gratemean$Date>="2014-09-19"),]

ggplot(gratemean, aes(x=Date,y=mean_length,color=Pop))+
  geom_point(size=4)+geom_line(size=2)+
  geom_errorbar(aes(x=Date, ymin=mean_length-ci,ymax=mean_length+ci),size=3)+
  scale_colour_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay","Dabob","Fidalgo","Oyster Bay","Dabob","Fidalgo","Oyster Bay"))+
  scale_fill_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay","Dabob","Fidalgo","Oyster Bay","Dabob","Fidalgo","Oyster Bay"))+
  theme_bw()+facet_wrap(~Site,ncol=1)

ggplot(grfid, aes(x=Date,y=mean_length,color=Pop))+
  geom_point(size=2)+geom_line(size=1)+
  geom_errorbar(aes(ymin=mean_length-ci,ymax=mean_length+ci),color="black",width=10)+
  scale_colour_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay"))+
  scale_fill_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay"))+
  theme_bw()+labs(x="Observation",y="Mean Shell Length (mm)")+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))+ 
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))+
  theme(legend.justification=c(0,1),
        legend.position=c(0,1),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20),
        legend.title=element_text(size=20),
        legend.text=element_text(size=20))+ 
  ylim(0,40)

ggplot(grman, aes(x=Date,y=mean_length,color=Pop))+
  geom_point(size=2)+geom_line(size=1)+
  geom_errorbar(aes(ymin=mean_length-ci,ymax=mean_length+ci),color="black",width=10)+
  scale_colour_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay"))+
  scale_fill_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay"))+
  theme_bw()+labs(x="Observation",y="Mean Shell Length (mm)")+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))+ 
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))+
  theme(legend.justification=c(0,1),
        legend.position=c(0,1),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20),
        legend.title=element_text(size=20),
        legend.text=element_text(size=20))+
  ylim(0,40)

ggplot(groys, aes(x=Date,y=mean_length,color=Pop))+
  geom_point(size=2)+geom_line(size=1)+
  geom_errorbar(aes(ymin=mean_length-ci,ymax=mean_length+ci),color="black",width=10)+
  scale_colour_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay"))+
  scale_fill_grey(start=0, end=.9,labels=c("Dabob","Fidalgo","Oyster Bay"))+
  theme_bw()+labs(x="Observation",y="Mean Shell Length (mm)")+
  theme(axis.text.x=element_text(size=20),
        axis.title.x=element_text(size=25, vjust=0.1),
        axis.title.y=element_text(size=25, vjust=2),
        axis.text.y=element_text(size=20))+ 
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))+
  theme(legend.justification=c(0,1),
        legend.position=c(0,1),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20),
        legend.title=element_text(size=20),
        legend.text=element_text(size=20))+
  ylim(0,40)

write.csv(grate1,"grate1.csv",col.names=T)