#### A quick introduction to social network analysis in R
#### 10 September, 2021

# Install required packages
# install.packages(c("tidyverse", "igraph"), dependencies = TRUE)

# Call libraries
library(tidyverse)
library(igraph)

# Import datasets
nodes <- read_csv("nodes_data.csv")
ties <- read_csv("edges_data.csv")

View(nodes)
View(ties)

# Create network object
pol_net <- graph_from_data_frame(d = ties, vertices = nodes, directed = TRUE)

# Network attributes, adjacency matrix, nodes, and edges
pol_net
pol_net[]
V(pol_net)
E(pol_net)

# Centrality measures 
degree(pol_net, mode = "in")

# Basic plot
plot(pol_net)

# Nicer plot with custom options
plot(pol_net,
     layout = layout_with_fr,
     vertex.size = strength(pol_net),
     vertex.color = ifelse(V(pol_net)$party == "Liberal", "#E41A1C",
                           ifelse(V(pol_net)$party == "Labor", "#377EB8",
                           "#008000")),
     vertex.frame.color = NA,
     vertex.label.color = "black",
     vertex.label.cex = 1,
     vertex.label.dist = 1.5,
     edge.color = ifelse(E(pol_net)$weight >= 5, "red1", "grey"),
     edge.width = E(pol_net)$weight,
     edge.arrow.size = 0.5)

legend(x = -1, y = -1, legend = c("Liberal", "Labor", "Greens"), 
       pch = 21, pt.bg = c("#E41A1C", "#377EB8", "#008000"), pt.cex = 1, bty = "n")

# Community detection using walktrap algorithm and clustering 
friendship_community <- cluster_walktrap(pol_net)
plot(friendship_community, pol_net)
plot_dendrogram(friendship_community)


