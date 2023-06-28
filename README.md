---
title: "about"
author: "Nikhil Bhargava"
output: html_document
---

## Author

-   Nikhil Bhargava
-   Reach me at:
    -   [nikhilb4\@illinois.edu](mailto:nikhilb4@illinois.edu)
    -   [LinkedIn](https://www.linkedin.com/in/nikhilxbhargava/)

## Purpose

A quick visualization of the Citibike usage in New York from 2013-2017. Comparing distance traveled to trip duration can help us understand the speed, distance, and time at which NYC commuters travel from different stations.

## Data

The original and official Citibike data is available on their website (<https://citibikenyc.com/system-data>) and has over 5 million data points. I used a dataset on Kaggle that randomly sampled 1% of the original data and also cleaned the data up a little.

The data contains trip duration, start station, end station, and the longitudes/latitudes of each station. However to create a distance measure using the longitudes and latitudes of each station, we need to use the [Haversine Formula](https://en.wikipedia.org/wiki/Haversine_formula). These are all the pertinent measure used in this visualization

## References

[Data](https://www.kaggle.com/datasets/fatihb/citibike-sampled-data-2013-2017)
