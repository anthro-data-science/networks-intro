# An introduction to network analysis in R

Shane Scaggs, Liying Wang

## Details 

Date and time: 2/22/2021 9am-11am Pacific Standard Time 

[Register for the workshop](https://urldefense.com/v3/__https://washington.zoom.us/meeting/register/tJYtdu6hrjwoGNL3RBQg_qTlVz1O62d9NlwF__;!!KGKeukY!jEfDzmnD6akKdd16Ejt0Nl7rAPcTXdQGarKiOCggIjSmJ0r5REcB2kXbUMyF6Yd1oA$)

Backup is https://rstudio.cloud/ if you have a problem with your Rstudio. 

Here are the [slides](https://docs.google.com/presentation/d/1vbKs6gitBsAar0ynncBq_asySp0cBwt3q5YGHZ5rLAM/edit?usp=sharing)

Join our low-volume [mailing list](https://groups.google.com/u/2/g/anthro-data-science) (must be signed into google) 

# Outline 

## Install and load packages 

- Create a new project directory "Intro to networks"
- Install `statnet`, `igraph`, and `intergraph` packages

```{r}
install.packages("statnet", dependencies = TRUE)
install.packages("igraph")
install.packages("intergraph")
```

## Matrices and Edgelists

- Manually create a matrix 
- Manually create an edgelist 

## Network Objects 

- Create network objects in `igraph` and `statnet`
- Add vertex attributes to network objects 
- Extract attributes from network objects 
- Compute centrality measures and add them as vertex attributes 
- Convert `igraph` objects into `network` objects and vice versa using the `intergraph` package 

## Visualization with `statnet`

- Compute centrality measure for Zachary's karate network (`data(zach`))
- Visualize centrality 
- Change node color, edge width, and layout

## Visualization with `ggraph`
