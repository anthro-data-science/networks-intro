#### Introduction to Network Analysis in R ####

# load packages
library(statnet)
library(tidygraph)
library(ggraph)

# network visualization
# Example: Karate club social network of Zachary (1977)
data(zach)
net_statnet <- network(zach)
net_ggraph <- intergraph::asIgraph(zach)

ggraph(net_ggraph, 
       layout = "fr") + 
    geom_edge_link(aes(color = factor(contexts))) + 
    geom_node_point(aes(color = role)) 

# different layout
# an arc diagram
ggraph(net_ggraph, 
       layout = "linear") +
    geom_edge_arc(aes(colour = factor(contexts)))

# a coord diagram
ggraph(net_ggraph, 
       layout = "linear", 
       circular = TRUE) + 
    geom_edge_arc(aes(colour = factor(contexts)))

