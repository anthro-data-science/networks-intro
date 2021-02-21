#### Introduction to Network Analysis in R ####

# load packages
library(statnet)
library(tidygraph)
library(ggraph) # ggplot2 of networks

# network visualization
data(zach)
net_ggraph <- intergraph::asIgraph(zach)

# get degree
graph_tbl <- net_ggraph %>% 
    as_tbl_graph() %>% 
    activate(nodes) %>% 
    mutate(degree = centrality_degree())

#net_ggraph <- create_layout(graph_tbl, 
                        #layout = 'igraph', 
                        #algorithm = 'nicely')

# basic visualization
ggraph(graph_tbl, 
       layout = "stress") + 
    geom_edge_link() +
    geom_node_point() +
    theme_graph()

# aesthetics for edges
ggraph(graph_tbl, 
       layout = "stress") + 
    geom_edge_link(aes(width = contexts),
                       alpha = 0.6) +
    scale_edge_width_continuous(range = c(0.2,1.5)) +
    geom_node_point() +
    theme_graph()

# aesthetics for nodes
ggraph(graph_tbl, 
       layout = "stress") + 
    geom_edge_link(aes(width = contexts),
                   alpha = 0.6) +
    scale_edge_width_continuous(range = c(0.2,1.5)) +
    geom_node_point(aes(size = degree,
                        color = role)) + 
    geom_node_text(aes(filter = degree >= 12, 
                       label = club)) +
    theme_graph()

# facet nodes by node attributes
ggraph(graph_tbl) + 
    geom_edge_link(aes(width = contexts),
                   alpha = 0.6) + 
    scale_edge_width_continuous(range = c(0.2,1.5)) +
    geom_node_point(aes(size = degree,
                        color = role)) +
    facet_nodes(~club) +
    theme_graph()

# different layout- circle
ggraph(graph_tbl, 
       layout = "linear",
       circular = TRUE) + 
    geom_edge_link(alpha = 0.5) +
    geom_node_point(aes(size = degree,
                        color = role)) + 
    theme_graph()

# different layout- star
ggraph(graph_tbl, 
       layout = "star") + # grid, dh, gem, etc.
    geom_edge_link(alpha = 0.5) +
    geom_node_point(aes(size = degree,
                        color = role)) + 
    theme_graph()
