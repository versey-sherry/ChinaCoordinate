# ChinaCoordinate

This package provides arithmetic solutions to convert Chinese encrypted coordinates such as GCJ02 or BD09 coordinates to WGS84 coordinates and vice versa. This package doesn't need any API or internet access to work.

According to [Restrictions on geographic data in China](https://en.wikipedia.org/wiki/Restrictions_on_geographic_data_in_China) on Wekipedia, China mainly uses two kinds of cryptic coordinates systems, namely GCJ02 and BD09.

Here are the explanations for GCJO2 and BD09 from Wekipedia:

**GCJ-02** (colloquially Mars Coordinates :alien:) is a geodetic datum formulated by the Chinese State Bureau of Surveying and Mapping (Chinese: 国测局; pinyin: guó-cè-jú), and based on WGS-84. It uses an obfuscation algorithm which adds apparently random offsets to both the latitude and longitude, with the alleged goal of improving national security.

**BD-09** is a geographic coordinate system used by Baidu Maps, adding further obfuscation to the already cryptic GCJ-02 "to better protect users' privacy".

This package uses pure arithmetic methods to perform the conversion and the current available conversion are: GCJ02 from/to WGS84, BD09 from/to WGS84, CGJ02 from/to BD09 and GCJ02 to WGS84 accurate. GCJ02 to WGS84 accurate uses [bisection method](https://en.wikipedia.org/wiki/Bisection_method) since WGS84 to GCJ02 function is continuous and monotonically increasing within China.

这个R package提供火星坐标系(GCJ02)和百度坐标系(BD09)和地球坐标系(WGS84)的相互转换。这个解决方案不需要连接任何API，其中GCJ02转换到WGS84有两个版本，一个是普通的计算版本gcjtowgs()，另外一个是利用二分法更加精确的版本gcjtowgs_acc()。


## Getting Started

### Installing
Simply install devtools package and use install_github() to install this package.

安装方法如下：

```
install.packages("devtools")
library(devtools)
devtools::install_github("versey-sherry/ChinaCoordinate")
```

## Example

**From GCJ02 to BD09 or WGS84**

火星坐标系转百度坐标系或地球坐标系

GCJ02 coordinates eg. c(39.8673, 116.366)

```
library(ChinaCoordinate)
#convert to BD09 coordinates
gcjtobd(c(39.8673, 116.366))
#convert to WGS84 coordinates
gcjtowgs(c(39.8673, 116.366))
#convert to WGS84 coordinates with improved accuracy
gcjtowgs_acc(c(39.8673, 116.366))
```
**From BD09 to GCJ02 or WGS84**

百度坐标系转火星坐标系或地球坐标系

Accuate conversion could be done by first converting BD09 to GCJ02 and then perform gcjtowgs_acc().

BD09 coordinates eg. c(39.806602, 116.64099)

```
library(ChinaCoordinate)
#convert to GCJ02 coordinates
bdtogcj(c(39.806602, 116.64099))
#convert to WGS84 coordinates
bdtowgs(c(39.806602, 116.64099))
```

**From WGS84 to BD09 or GCJ02**

地球坐标系转百度坐标系或火星坐标系

WGS84 coordinates eg. c(39.8659, 116.3597)

```
library(ChinaCoordinate)
#convert to BD09 coordinates
wgstobd(c(39.8659, 116.3597))
#convert to GCJ02 coordinates
wgstogcj(c(39.8659, 116.3597))
```
**Data frame Conversion**

For example, you have a data frame of GCJ02 coordinates like below called df, and you want to convert these coordinates to WGS84 coordinates.

Please make sure there is no NA in the coordinates or there will be an error.

如果需要转换的坐标在数据框(data frame)里面，请使用按行计算的apply()，或其他类似函数，请注意坐标不要有NA, 例子如下：

Location | Lat | Lon 
------------ | ------------- | -------------  
Location1 | 39.141 | 116.535
Location2 | 39.433 | 117.484
Location3 | 39.541 | 116.135
Location4 | 39.473 | 117.489

```
library(ChinaCoordinate)
apply(df[c("Lat", "Lon")], 1, gcjtowgs)
```

## Contributing
If you have any request or questions, please go to the [issue page](https://github.com/versey-sherry/ChinaCoordinate/issues) and submit a New Issue.

## Authors

* **Sherry Lin** - *Initial work* - [versey-sherry](https://github.com/versey-sherry)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Algorithm adpated from [this post](https://segmentfault.com/a/1190000009041866)
* [Online tool](https://tool.lu/coordinate/) for coordinate checking
* [README.md template](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
