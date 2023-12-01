#set directory for folder including files: Gasch2000_dataset_heat.csv and clustering_logdata.r

#import your dataset
logdata <- read.csv("dataset_1.csv", header=TRUE, row.names=1)
head(logdata)

#manipulate the data to select which columns you need


#to remove NA/NaN/Inf in a matrix, use:
logdata<-logdata[complete.cases(logdata * 0), , drop=FALSE]

#Double clustering with method:=ward
#----------------------------------

# cr?ation of a new function with ward.D2
lf=function(d) hclust(d,method="ward.D2")

##  double clustering with ward
X11()
heatmap(as.matrix(logdata),hclustfun=lf)


#Dendrogram : we will class the genes which are in the lines (transpose the matrix, logdata=t(logdata) if you want to class the columns)
#------------------------------------------


#calculation of the distances
dist.logdata=dist(logdata)
length(dist.logdata)

#you should get from R the value  nc(nc-1)/2, with nc=number of genes which will be classified


hc.logdata=hclust(dist.logdata,method="ward.D2")
#hc.logdata=hclust(dist.logdata,method="average")



X11()
plot(hc.logdata,hang=-1)

#count the number of genes
nrow(logdata)

#---if you want to see the heights between the nodes to help to choose the numbers of classes----#
#objet : nc=number of genes in the list, in our case nc=527
#representation only of the heigths between node 1 (nc-1) and node 20 (nc-20)
X11()
nc=nrow(logdata)
node1=nc-1
node2=nc-20
plot(hc.logdata$height[node1:node2],type="b")


#to retrieve the clustered genes in K classes, (k chosen after visualisation of the heigth between the nodes)
#------------------------------------------------------------------------------------------------------------
#for example if we choose k=10 classes

#select the number of clusters:
cc= 5 #7

X11()
plot(hc.logdata,hang=-1)
rect.hclust(hc.logdata,k=cc)

# k rectangles will appear on the dendrogram
#to access the genes in each rectangle, you have to save the results of the function rect.hclust in an object named rect.hc.logdata
rect.hc.logdata=rect.hclust(hc.logdata,k=cc)
length(rect.hc.logdata)

#R should return 7, total number of classes


#to get all the gene numbers present in class 1, 2, 3... etc.
c1=rect.hc.logdata[[1]]
c2=rect.hc.logdata[[2]]
c3=rect.hc.logdata[[3]]
c4=rect.hc.logdata[[4]]
c5=rect.hc.logdata[[5]]
#c6=rect.hc.logdata[[6]]
#c7=rect.hc.logdata[[7]]

#add cluster number to the list
c1 <- cbind( c1, 1)
c2 <- cbind( c2, 2)
c3 <- cbind( c3, 3)
c4 <- cbind( c4, 4)
c5 <- cbind( c5, 5)
#c6 <- cbind( c6, 6)
#c7 <- cbind( c7, 7)

#combine clusters
clust_data <- rbind(c1,c2,c3,c4,c5) #,c6,c7)
colnames(clust_data) <- c("gene","clust")

write.csv(clust_data,"clust_data1.csv")


df<-merge(logdata,clust_data,by="row.names")
write.csv(df,"data_clust1.csv")


