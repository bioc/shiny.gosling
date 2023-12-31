% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{build_json}
\alias{build_json}
\title{Build gosling spec from R list}
\usage{
build_json(r_list, clean_braces = TRUE, pretty = TRUE, auto_unbox = TRUE)
}
\arguments{
\item{r_list}{R list object built with other gosling functions}

\item{clean_braces}{Whether to remove extra square brackets
from the json string.}

\item{pretty}{Whether to get json with indentation, line breaks etc.}

\item{auto_unbox}{If TRUE will automatically unbox() all atomic
vectors of length 1.}
}
\value{
json spec for the gosling output
}
\description{
Build gosling spec from R list
}
