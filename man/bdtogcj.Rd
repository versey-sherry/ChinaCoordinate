\name{bdtogcj}
\alias{bdtogcj}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
BD09 to GCJO2
}
\description{
Function to convert BD09 coordinates to GCJ02 coordinates.

Geographic data from Baidu and coordinates in Baidu maps are BD09 coordinates. Geographic data from Chinese official websites and coordinates from Chinese map providers such as Gaode and QQ map are GCJ02 coordinates. GCJ02 coordinates is the first encryption applied to WGS84 coordinates. BD09 adds one more layer of encryption on top of GCJ02.
}
\usage{
bdtogcj(coordinates)
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
#Coordinate data from Baidu eg. c(39.806602, 116.64099)
#Convert to GCJ02 coordinates

bdtogcj(c(39.806602, 116.64099))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
