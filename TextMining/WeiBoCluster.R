################################################################# 
# 读取数据
col=c(rep("character",6),"NULL",NA,NA,"character",rep("NULL",4)) 
data=read.csv(file="text.csv",header=T,sep=",",colClasses=col)
# 将文本存储到一个向量中 
doc=c(NULL) for(i in 1:dim(data)[1]){ doc=c(doc,data$Text[i]) } #################################################################
# 去除微博中含有的url 
doc=gsub(pattern="http:[a-zA-Z\\/\\.0-9]+","",doc) 
# 无意义微博处理
empty_N=c(2032,2912,7518,8939,14172,14422,26786,30126,34501,35239,48029,48426,48949,49100,49365,49386,49430,50034,56818,56824,56828,57859) 
doc[empty_N]="NA" 
################################################################# 
# 添加词汇  
library("Rwordseg") 
textwords=c("...") 
insertWords(textwords) 
# removeWords(tagwords)  
doc_CN=list() 
for(j in 1:length(doc)){
	doc_CN[[j]]=c(segmentCN(doc[j],recognition=F)) 
} 
detach("package:Rwordseg", unload=TRUE)
################################################################# 
# 构建语料库(Corpus对象) 
library("tm") 
doc.corpus=Corpus(VectorSource(doc_CN)) 
###########停用词########### 
data_stw=read.table(file="中文停用词库.txt",colClasses="character") 
stopwords_CN=c(NULL) 
for(i in 1:dim(data_stw)[1]){
	stopwords_CN=c(stopwords_CN,data_stw[i,1])
}
doc.corpus=tm_map(doc.corpus,removeWords,stopwords_CN) 
# 删除停用词 ############################ 
# 创建词项-文档矩阵(TDM) 
control=list(removePunctuation=T,minDocFreq=5,wordLengths = c(1, Inf),weighting = weightTfIdf) 
doc.tdm=TermDocumentMatrix(doc.corpus,control) 
length(doc.tdm$dimnames$Terms) 
tdm_removed=removeSparseTerms(doc.tdm, 0.9998) 
# 1-去除了低于 99.98% 的稀疏条目项 
length(tdm_removed$dimnames$Terms) 
################################################################# 
# 层次聚类： 
dist_tdm_removed <- dissimilarity(tdm_removed, method = 'cosine') 
hc <- hclust(dist_tdm_removed, method = 'mcquitty')
cutNum = 20 
ct = cutree(hc,k=cutNum) 
sink(file="result.txt") 
for(i in 1:cutNum){
	print(paste("第",i,"类： ",sum(ct==i),"个"))
	print("----------------")
	print(attr(ct[ct==i],"names")) 
	#print(doc[as.integer(names(ct[ct==i]))])
	print("----------------") 
}
sink()
#输出结果
output=data.frame(clas=NULL,tag=NULL,text=NULL)
for(i in 1:cutNum){
	in_tag=tag[as.integer(names(ct[ct==i]))]
	in_text=doc[as.integer(names(ct[ct==i]))]
	cut_output=data.frame(clas=rep(i,length(in_tag)),tag=in_tag,text=in_text)
	output=rbind(output,cut_output) 
}
write.table(output,file="classification.csv",sep=",",row.names=F)