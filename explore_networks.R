#### Introduction to Network Analysis in R ####

#### Packages #### 
#install.packages(c('statnet','igraph','intergraph'))
library(statnet)

#### Matrices and Edgelist #### 

# Two steps 
# 1. Construct/import network data 
# 2. Assign data to network object

## Matrix

# If there are n nodes, then there are n^2 possible edges
# So a network of 3 nodes has 9 possible edges 

# A square matrix of three nodes
m <- matrix(c(0,0,0,
              0,0,0,
              0,0,0), 
            nrow=3)
m

# Add an edge from 1 to 3, and from 2 to 1
m[1,3] <- 1
m[2,1] <- 1
m

# the diagonal are "loops" or self connections 
diag(m) 

# Create a network object from matrix m 
o <- network(m)
gplot(o, displaylabels = T)

# Edgelist 
# Two columns representing sender (1) and receiver (2)
e <- rbind(c(1,3),
           c(2,1))
e

# make edgelist into a network object 
o <- network(e, matrix.type = 'edgelist')
gplot(o, displaylabels = T)

#### Simulate a random graph #### 
set.seed(777)
N <-  7
m <- matrix(rbinom(N^2, 1, 0.5),
            nrow = N)

# no loops
diag(m) <- 0
m

#### Manipulating network objects 
data("zach")
z <- zach
z

# summarize network
set.network.attribute(z, 'density', network.density(z))
z

# use %v% and %e% operators to extract attributes 
z %v% 'club'

# set vertex attribute for degree centrality 
set.vertex.attribute(z, attrname = 'degree', 
                     value = degree(z, gmode = 'graph'))

set.vertex.attribute(z, attrname = 'between', 
                     value = betweenness(z, gmode = 'graph'))
z

# summary table 
df <- data.frame(
    ID = z %v% 'vertex.names',
    Faction = z %v% 'faction.id',
    Degree = z %v% 'degree',
    Betweeness = z %v% 'between' 
)

# distributions
library(tidyverse)

df %>% ggplot(aes(Degree)) + geom_histogram(binwidth=1)
df %>% ggplot(aes(Betweeness/max(Betweeness))) + geom_histogram()

