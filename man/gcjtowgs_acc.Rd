\name{gcjtowgs_acc}
\alias{gcjtowgs_acc}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
GCJ02 to WGS84 Accurate
}
\description{
Function to convert GCJ02 coordinates to WGS84 coordinates.

This function uses bisection method to find more accuate WGS84 coordinates. This function requires heavy computation and it is good for scenarios in which great accuracy, as good as less than a few meters error, is needed.

Geographic data from Baidu and coordinates in Baidu maps are BD09 coordinates. Geographic data from Chinese official websites and coordinates from Chinese map providers such as Gaode and QQ map are GCJ02 coordinates. GCJ02 coordinates is the first encryption applied to WGS84 coordinates. BD09 adds one more layer of encryption on top of GCJ02.
}
\usage{
gcjtowgs_acc(coordinates)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{coordinates}{
  A vector of coordinate pair c(lat, lon)
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
lat, lon
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
#Coordinate data from official websites eg. c(39.8673, 116.366)
#Convert to WGS84 coordinates

gcjtowgs_acc(c(39.8673, 116.366))
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
