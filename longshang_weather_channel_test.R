qdata <- read.csv("E:/test/data.csv")
#####
# remove NA Cols
# remove useless questionnaires
# questionnaire coding
#####
# remove useless questionnaires
nrow(qdata)
qdata <- qdata[which(!is.na(qdata$C2.34)),]
qdata <- qdata[which(!is.na(qdata$C2.35)),]
qdata <- qdata[which(!is.na(qdata$C2.36)),]
qdata <- qdata[which(!is.na(qdata$C2.37)),]
qdata <- qdata[which(!is.na(qdata$C2.38)),]
qdata <- qdata[which(!is.na(qdata$C2.39)),]
qdata <- qdata[which(!is.na(qdata$C2.40)),]
nrow(qdata)
# questionnaire coding
data <- data.frame(C2.34=qdata$C2.34,
                   C2.35_1=0,C2.35_2=0,C2.35_3=0,C2.35_88=0,
                   C2.36_1=0,C2.36_2=0,C2.36_3=0,C2.36_4=0,
                   C2.37=qdata$C2.37,
                   C2.38=qdata$C2.38,
                   C2.39=qdata$C2.39,
                   C2.40_1=0,C2.40_2=0,C2.40_3=0,C2.40_88=0)
for(i in 1:nrow(qdata)){
  # C2.35
  C2.35_N <- strsplit(as.character(qdata$C2.35[i]),',')
  if("1"%in%C2.35_N){data$C2.35_1[i] = 1}
  if("2"%in%C2.35_N){data$C2.35_2[i] = 1}
  if("3"%in%C2.35_N){data$C2.35_3[i] = 1}
  if("88"%in%C2.35_N){data$C2.35_88[i] = 1}
  # C2.36
  C2.36_N <- strsplit(as.character(qdata$C2.36[i]),',')
  if("1"%in%C2.36_N){data$C2.36_1[i] = 1}
  if("2"%in%C2.36_N){data$C2.36_2[i] = 1}
  if("3"%in%C2.36_N){data$C2.36_3[i] = 1}
  if("4"%in%C2.36_N){data$C2.36_4[i] = 1}
  # C2.40
  C2.40_N <- strsplit(as.character(qdata$C2.40[i]),',')
  if("1"%in%C2.40_N){data$C2.40_1[i] = 1}
  if("2"%in%C2.40_N){data$C2.40_2[i] = 1}
  if("3"%in%C2.40_N){data$C2.40_3[i] = 1}
  if("88"%in%C2.40_N){data$C2.40_88[i] = 1}
}
#####
# descriptive statistic
# for a single question analysis
# frequency distribution
#####
# C2.34
cases <- c(length(which(data$C2.34==1)),
            length(which(data$C2.34==2)),
            length(which(data$C2.34==3)),
            length(which(data$C2.34==4)))
names(cases) <- c("06:12","11:40","21:00","20:15")
#barplot(cases)
barplot(beside=TRUE,
        cases,
        border="black",
        col=c("purple","green3","blue","red"),
        density = c(7.5,12.5,17.5,22.5),
        angle = c(45,60,120,135)
        )
pie(cases,col=rainbow(4),radius = 1)
# C2.35

