setwd("")
#import data
data.col.types<-c('character',
                  'character'
)
data.raw<-read.csv("./location.csv",colClasses=data.col.types,na.strings="NA",stringsAsFactors=F)
#dim(data.raw)
#fix(data.raw)
#preprocessing
nrow(data.raw)
nrow(unique(data.raw))
data.unique<-unique(data.raw)
#URL
address<-"福建省福州市仓山区下藤路龙津花园"
city<-"福州"
library(rjson)
library(RCurl)
getLocation<-function(address,city){
  #api
  URL_Base<-"http://api.map.baidu.com/geocoder/v2/?output=json&ak=3E871a359f1220dee9c847b8544a2e31"
  address<-gsub(" ", "", address)
  city<-gsub(" ", "", city)
  para_address<-paste("address=",address,sep = "")
  para_city<-paste("city=",city,sep = "")
  URL<-paste(URL_Base,para_address,para_city,sep = "&")
  #parse
  tryCatch({
    json_data <- fromJSON(getURL(URL))
    if(json_data$status==0){
      dataline<-data.frame(address=address,city=city,
                           lng=json_data$result$location$lng,
                           lat=json_data$result$location$lat)
    }else{
      dataline<-data.frame(address=address,city=city,
                           lng=0,
                           lat=0)
    }},error = function(e){
      dataline<-data.frame(address=address,city=city,
                         lng=0,
                         lat=0)},
    finally = print(URL))
  return(dataline)
}

library(compiler)
CgetLocation <- cmpfun(getLocation)
#Using
library(plyr)
system.time(compile(location_x<-mdply(.data = data.unique,.fun = CgetLocation)))
write.csv(location_x,file = "locationWithPosition.csv",row.names = FALSE)
names(location_x)[1]<-"GDDXMC"
#Join
data<-read.csv("./temp_file1.csv",na.strings="NA",stringsAsFactors=F)
final<-join(x = data,y = location_x[,-2],by = "GDDXMC")
write.csv(final,file = "temp_file_withlocation.csv",row.names = FALSE)