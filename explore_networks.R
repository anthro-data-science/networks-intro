#### Introduction to Network Analysis in R ####

#### Packages #### 
#install.packages(c('statnet','igraph','intergraph'))
library(igraph)
library(statnet)

#### Matrices and Edgelist #### 

# Two steps 
# 1. Construct/import network data 
# 2. Assign data to network object

## Matrix

# If there are n nodes, then there are n^2 possible edges
# So a network of 3 nodes has 9 possible edges 

# A square matrix of three nodes
v <- letters[9:11]
v

M <- matrix(c(0,0,1,
              1,1,0,
              1,0,0), 
            nrow=length(v), 
            dimnames=list(v,v)
)
M

# Add edge from 2 to 3, and remove the loop
M[2,3] <- 1
M[2,2] <- 0
M

# the diagonal are "loops" or self connections 
diag(M) 

# Create a network object from matrix m 
o <- network(M)
gplot(o, displaylabels = T)

# Edgelist 
# Two columns representing sender (1) and receiver (2)
E <- rbind(c('i','j'), 
           c('i','k'),
           c('j','j'),
           c('k','i'))
E

# add and edge 
E <- rbind(E, c('j','k'))
E <- E[-3,]
E
# make edgelist into a network object 
o <- network(E, matrix.type = 'edgelist')
gplot(o, displaylabels = T)

#### Simulate a random graph #### 
# set parameters
set.seed(777)
N <- 25
N_edges <- N^2

# Bernoulli random graph
M <- matrix(rbinom(N_edges,
                   size = 1,
                   prob = 0.3),	
            nrow = N,
            dimnames = list(1:N,1:N))
#png("Rando.png", height = 3, width = 3, res = 600, units = "in")
par(mar=c(0,0,0,0))
gplot(network(M))
#dev.off()


#### Network objects in igraph #### 
library(igraph)
M
E

#### Make up some vertex attributes 
att <- data.frame(
  name = c("i","j","k"), 
  size = c(20,27,34),
  color = c('tomato', 
            'cornflowerblue', 
            'darkorchid')
)
att

# from a matrix
g_adj <- graph.adjacency(M)
g_adj

set_vertex_attr(g_adj, name = 'age', value = att$age)
set_vertex_attr(g_adj, name = 'color', value = att$color)

# from an edgelist
g_df <- graph.data.frame(E)
g_df

# a network with attributes 
new_g <- graph.data.frame(E, vertices = att)
new_g

V(new_g)$color

# Visualize igraph object
#png("BasicTriad.png", height = 2, width = 2, units = "in", res = 600)
par(mar=c(0,0,0,0))
plot(new_g, 
     vertex.size = 30,
     vertex.color = 'cornflowerblue',
     vertex.label.color = 'white', 
     edge.color = 'black',
     edge.arrow.size = 0.5, 
     layout = layout.kamada.kawai)
#dev.off()


#### Network objects in statnet ####
gM <- network(M, vertex.attr = att)
gE <- network(E, vertex.attr = att, matrix.type = "edgelist")
gE

gE %v% "vertex.names"
gE %v% "color"


# converting between objects 
class(gE)

class(g_df)

ig2net <- intergraph::asNetwork(g_df)
net2ig <- intergraph::asIgraph(gE)


#### Manipulating network objects 
data("zach")
z <- zach

# plot the network
#png("ZachBasic.png", height = 4, width = 4, res = 600, units = "in")
par(mar=c(0,0,0,0))
gplot(zach, usearrows = F)
#dev.off()


# set vertex attribute for degree centrality 
degree(zach, gmode = "graph") # undirected 

set.vertex.attribute(zach, attrname = 'degree', 
                     value = degree(z, gmode = 'graph'))

set.vertex.attribute(zach, attrname = 'between', 
                     value = betweenness(z, gmode = 'graph'))

# plot it

#png("ZachDegree.png", height = 6, width = 6, units = "in", res = 600)
par(mar=c(0,0,0,0))
gplot(zach, usearrows = F, 
      vertex.cex = log(zach %v% "degree"))
#dev.off()

## Change node color, edge width, and layouts
unique(zach %v% 'faction')

set.vertex.attribute(
  zach,
  attrname = 'faction.col',
  ifelse(zach %v% 'faction.id' == 2, '#18206f', 
         ifelse(zach %v% 'faction.id' == 1, '#5d77d5', 
                ifelse(zach %v% 'faction.id' == 0, '#f5e2c8', 
                       ifelse(zach %v% 'faction.id' == -1, '#fba860', '#a35f00'))))
)

# plot it
#png("ZachColors.png", height = 4, width = 5, units = "in", res = 600)
par(mar=c(1,1,1,5), xpd=T)
gplot(zach, usearrows = F, 
      vertex.cex = log(zach %v% 'degree'+1), 
      vertex.col = zach %v% 'faction.col',
      edge.lwd = zach %e% 'contexts', 
      edge.col = adjustcolor('black', alpha=0.3), 
      mode = "kamadakawai")
legend('bottomright', pch = 19, bty = 'n', inset = c(-0.2,0),
       legend=c('Mr. Hi (strong)','Mr. Hi (weak)','Neutral',
                'John (weak)','John (strong)'),
       col = c('#18206f','#5d77d5','#f5e2c8','#fba860','#a35f00' ))
#dev.off()


