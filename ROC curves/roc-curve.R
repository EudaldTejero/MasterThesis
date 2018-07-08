library("cvAUC")
   
category1 <- lapply("category1.txt",readLines) 
category1 <- as.numeric(unlist(category1)) 
category2 <- lapply("category2.txt",readLines) 
category2 <- as.numeric(unlist(category2)) 
category3 <- lapply("category3.txt",readLines) 
category3 <- as.numeric(unlist(category3)) 
category4 <- lapply("category4.txt",readLines) 
category4 <- as.numeric(unlist(category4)) 
category5 <- lapply("category5.txt",readLines) 
category5 <- as.numeric(unlist(category5)) 

category <- list(category1,category2,category3,category4,category5)
 
prediction1 <- seq(1, 0, length.out = length(category1))
prediction2 <- seq(1, 0, length.out = length(category2))
prediction3 <- seq(1, 0, length.out = length(category3))
prediction4 <- seq(1, 0, length.out = length(category4))
prediction5 <- seq(1, 0, length.out = length(category5))

prediction <- list(prediction1,prediction2,prediction3,prediction4,prediction5) 

ids1 <- lapply("result1.txt",readLines) 
ids2 <- lapply("result2.txt",readLines) 
ids3 <- lapply("result3.txt",readLines) 
ids4 <- lapply("result4.txt",readLines) 
ids5 <- lapply("result5.txt",readLines) 

ids <- list(ids1, ids2, ids3, ids4, ids5)

out <- cvAUC(prediction, category)
 out
 
ci.cvAUC(prediction, category, label.ordering = NULL, confidence = 0.95)

plot(out$perf, col="red", avg="vertical", lwd=2, main="ROC curve")
abline(a=0, b=1, lty=2, lwd=2, col="black")