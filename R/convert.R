#online tool for checking accuracy: https://tool.lu/coordinate/

#constants used the algorithm
#projection factor
a = 6378245.0
#eccentricity
ee = 0.00669342162296594323
#PI
PI = 3.14159265358979324
x_PI = 3.14159265358979324 * 3000.0 / 180.0

#transform helper
transformlat <- function(x, y){
  ret <- -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(abs(x))
  ret <- ret + (20.0 * sin(6.0 * x * PI) + 20.0 * sin(2.0 * x * PI)) * 2.0 / 3.0
  ret <- ret + (20.0 * sin(y * PI) + 40.0 * sin(y / 3.0 * PI)) * 2.0 / 3.0
  ret <- ret + (160.0 * sin(y / 12.0 * PI) + 320 * sin(y * PI / 30.0)) * 2.0 / 3.0
  return(ret)
}
transformlon <- function(x, y){
  ret <- 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(abs(x))
  ret <- ret + (20.0 * sin(6.0 * x * PI) + 20.0 * sin(2.0 * x * PI)) * 2.0 / 3.0
  ret <- ret + (20.0 * sin(x * PI) + 40.0 * sin(x / 3.0 * PI)) * 2.0 / 3.0
  ret <- ret +  (150.0 * sin(x / 12.0 * PI) + 300.0 * sin(x / 30.0 * PI)) * 2.0 / 3.0
  return(ret)
}

#quick check if the coordinates are in China
#regtangle assumption for now
#could improve with ray casting algorithm or multiple rectangle
#http://www.cnblogs.com/Aimeast/archive/2012/08/09/2629614.html
inchina <- function(lat, lon){
  #extreme points source: https://en.wikipedia.org/wiki/List_of_extreme_points_of_China
  return(ifelse((lat >=20.333333 & lat <= 53.55) &
           (lon >=73.816667 & lon <= 134.75), TRUE, FALSE))
}

#from GCJ02 to WGS84
gcjtowgs <- function(coordinates){
  gcjlat <- coordinates[1]
  gcjlon <- coordinates[2]
  if (inchina(gcjlat, gcjlon)){
    dlat <- transformlat(gcjlon - 105, gcjlat -35)
    dlon <- transformlon(gcjlon - 105, gcjlat -35)
    radlat <- gcjlat/180 * PI
    magic <- sin(radlat)
    magic <- 1 - ee*magic*magic
    dlat <- (dlat*180)/((a*(1 - ee))/magic*sqrt(magic)*PI)
    dlon <- (dlon*180)/(a/sqrt(magic)*cos(radlat)*PI)
    wgs <- c(wgslat = gcjlat - dlat, wgslon = gcjlon -dlon)
  }else{
    wgs <- c(wgslat = gcjlat, wgslon = gcjlon)
  }
  return(wgs)
}

#from GCJ02 to WGS84 using Bisection method
#more accurate but more computation
gcjtowgs_acc <- function(gcjlat, gcjlon){
  if (inchina(gcjlat, gcjlon)){
    init_delta <- 0.1
    threshold <- 0.000000001
    mlat <- gcjlat - init_delta
    mlon <- gcjlon - init_delta
    plat <- gcjlat + init_delta
    plon <- gcjlon + init_delta
    #bisection method 10000 times
    a = 1
    for (a in 1:10000){
      wgslat <- (mlat + plat)/2
      wgslon <- (mlon + plon)/2
      templat <- wgstogcj(wgslat, wgslon)[1]
      templon <- wgstogcj(wgslat, wgslon)[2]
      ilat <- templat - gcjlat
      ilon <- templon - gcjlon
      if (ilat >= 0){
        plat <- wgslat
      }else{
        mlat <- wgslat
      }
      if (ilon >= 0){
        plon <- wgslon
      }else{
        mlon <- wgslon
      }
      a = a+1
      wgs <- c(wgslat = wgslat, wgslon = wgslon)
    }

  }else{
    wgs <- c(wgslat = gcjlat, wgslon = gcjlon)
  }
  return(wgs)
}

#from WGS84 to GCJ02
wgstogcj <- function(wgslat, wgslon){
  if(inchina(wgslat, wgslon)){
    dlat <- transformlat(wgslon - 105, wgslat - 35)
    dlon <- transformlon(wgslon - 105, wgslat - 35)
    radlat <- wgslat/180*PI
    magic <- sin(radlat)
    magic <- 1 - ee*magic*magic
    dlat <- (dlat*180)/((a*(1 - ee))/magic*sqrt(magic)*PI)
    dlon <- (dlon*180)/(a/sqrt(magic)*cos(radlat)*PI)
    gcj <- c(gcjlat = wgslat + dlat, gcjon = wgslon + dlon)
  }else{
    gcj <- c(gcjlat = wgslat, gcjon = wgslon)
  }
  return(gcj)
}

#from BD09 to GCJ02
bdtogcj <- function(bdlat, bdlon){
  x <- bdlon - 0.0065
  y <- bdlat - 0.006
  z <- sqrt(x*x +y*y) - 0.00002*sin(y*x_PI)
  theta <- atan2(y,x) - 0.000003*cos(x*x_PI)
  gcj <- c(gcjlat = z*sin(theta), gcjlon = z*cos(theta))
  return(gcj)
}

#from GCJ02 to BD09
gcjtobd <- function(gcjlat, gcjlon){
  x <- gcjlon
  y <- gcjlat
  z <- sqrt(x*x + y*y) + 0.00002*sin(y*x_PI)
  theta <- atan2(y, x) + 0.000003*cos(x*x_PI)
  bd <- c(bdlat = z*sin(theta) +0.006, bdlon = z*cos(theta) + 0.0065)
  return(bd)
}

#from BD09 to WGS84
bdtowgs <- function(bdlat, bdlon){
  if (inchina(bdlat, bdlon)){
    #from BD09 to GCJ02
    templat <- bdtogcj(bdlat, bdlon)[1]
    templon <- bdtogcj(bdlat, bdlon)[2]
    #from GCJ02 to WGS84
    wgs <- c(gcjtowgs(templat, templon)[1], gcjtowgs(templat, templon)[2])
    names(wgs) <- c("wgslat", "wgslon")
  }else{
    wgs <- c(wgslat = bdlat, wgslon = bdlon)
  }
  return(wgs)
}

#from WGS84 to BD09
wgstobd <- function(wgslat, wgslon){
  if(inchina(wgslat, wgslon)){
    #from WGS84 to GCJ02
    templat <- wgstogcj(wgslat, wgslon)[1]
    templon <- wgstogcj(wgslat, wgslon)[2]
    #from GCJ02 to BD09
    bd <- c(gcjtobd(templat, templon)[1], gcjtobd(templat, templon)[2])
    names(bd) <- c("bdlat", "bdlon")
  }else{
    bd <- c(bdlat = wgslat, bdlon = wgslon)
  }
  return(bd)
}

