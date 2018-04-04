# Can cultural consumption increase future earnings? Exploring the economic returns to cultural capital 
# British Journal of Sociology

# Aaron Reeves and Robert de Vries

# Latent class analysis of cultural consumption - Understanding Society

  
# Understanding Society data is available from the UK data archive. 
# To recreate the dataset, see the other data files 

# The authors are happy to send the data files used in this analysis assuming the request comes from 
# someone who has already registered with the UK Data Archive. 

# Email: aaron.reeves@spi.ox.ac.uk


library(foreign)
library(poLCA)
library(arm)

# Import data
setwd("...")
educ <- read.csv("...lcaR.csv", sep=",", check.names=FALSE)
###################################################################
### LCA model - with stately homes and orchestral concerts
t <- cbind(film, gallery, videoart, book, streetart, carnival, 
           circus, play, opera, classical, rock, ballet, contemp, african) ~ 1
lca.tps1 <- poLCA(t,educ,nclass=1, maxiter=4000, nrep=5)
lca.tps2 <- poLCA(t,educ,nclass=2, maxiter=4000, nrep=5) 
lca.tps3 <- poLCA(t,educ,nclass=3, maxiter=6000, nrep=5)
lca.tps4 <- poLCA(t,educ,nclass=4, maxiter=4000, nrep=5)
lca.tps5 <- poLCA(t,educ,nclass=5, maxiter=4000, nrep=5)
lca.tps6 <- poLCA(t,educ,nclass=6, maxiter=4000, nrep=5)

# Re-ordering
lca.tps3
probs.start.new <- poLCA.reorder(lca.tps3$probs.start,
                                 order(lca.tps3$probs$rock[,2],decreasing=FALSE))
lca.tps3 <- poLCA(t,educ,nclass=3,probs.start=probs.start.new)


educ.new <- educ
educ.new$lc_1 <- lca.tps3$posterior[,1]
educ.new$lc_2 <- lca.tps3$posterior[,2]
educ.new$lc_3 <- lca.tps3$posterior[,3]

write.csv(educ.new, "...lca.csv")
