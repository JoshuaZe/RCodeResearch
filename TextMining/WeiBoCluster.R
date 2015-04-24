################################################################# 
# ��ȡ����
col=c(rep("character",6),"NULL",NA,NA,"character",rep("NULL",4)) 
data=read.csv(file="text.csv",header=T,sep=",",colClasses=col)
# ���ı��洢��һ�������� 
doc=c(NULL) for(i in 1:dim(data)[1]){ doc=c(doc,data$Text[i]) } #################################################################
# ȥ��΢���к��е�url 
doc=gsub(pattern="http:[a-zA-Z\\/\\.0-9]+","",doc) 
# ������΢������
empty_N=c(2032,2912,7518,8939,14172,14422,26786,30126,34501,35239,48029,48426,48949,49100,49365,49386,49430,50034,56818,56824,56828,57859) 
doc[empty_N]="NA" 
################################################################# 
# ���Ӵʻ�  
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
# �������Ͽ�(Corpus����) 
library("tm") 
doc.corpus=Corpus(VectorSource(doc_CN)) 
###########ͣ�ô�########### 
data_stw=read.table(file="����ͣ�ôʿ�.txt",colClasses="character") 
stopwords_CN=c(NULL) 
for(i in 1:dim(data_stw)[1]){
	stopwords_CN=c(stopwords_CN,data_stw[i,1])
}
doc.corpus=tm_map(doc.corpus,removeWords,stopwords_CN) 
# ɾ��ͣ�ô� ############################ 
# ��������-�ĵ�����(TDM) 
control=list(removePunctuation=T,minDocFreq=5,wordLengths = c(1, Inf),weighting = weightTfIdf) 
doc.tdm=TermDocumentMatrix(doc.corpus,control) 
length(doc.tdm$dimnames$Terms) 
tdm_removed=removeSparseTerms(doc.tdm, 0.9998) 
# 1-ȥ���˵��� 99.98% ��ϡ����Ŀ�� 
length(tdm_removed$dimnames$Terms) 
################################################################# 
# ��ξ��ࣺ 
dist_tdm_removed <- dissimilarity(tdm_removed, method = 'cosine') 
hc <- hclust(dist_tdm_removed, method = 'mcquitty')
cutNum = 20 
ct = cutree(hc,k=cutNum) 
sink(file="result.txt") 
for(i in 1:cutNum){
	print(paste("��",i,"�ࣺ ",sum(ct==i),"��"))
	print("----------------")
	print(attr(ct[ct==i],"names")) 
	#print(doc[as.integer(names(ct[ct==i]))])
	print("----------------") 
}
sink()
#������
output=data.frame(clas=NULL,tag=NULL,text=NULL)
for(i in 1:cutNum){
	in_tag=tag[as.integer(names(ct[ct==i]))]
	in_text=doc[as.integer(names(ct[ct==i]))]
	cut_output=data.frame(clas=rep(i,length(in_tag)),tag=in_tag,text=in_text)
	output=rbind(output,cut_output) 
}
write.table(output,file="classification.csv",sep=",",row.names=F)