
# 文件说明
  - CircleProgressView： 不支持渐变色设置，纯色圆环进度条
  - GradientCircleProgress： 支持渐变色设置的圆环进度条 （OC + Swift 两个版本）
  - LineProgress: 虚线型进度条
  - LoadingView: 基于 CircleProgressView 实现的 loading View
  - QSMStyleDownloadView: 基于 CircleProgressView 实现的 下载进度条
# GradientCircleProgressView 可设置属性以及方法简述
### 属性
  - shouldWithDashPattern 可设置是否是虚线
  - startAngle 可设置起始角度
  - isClockwise 可设置进度条方向
  - lineWidth 可设置进度条线宽
  - dashPattern 可设置虚线的长度
  - maxTintColor 可设置背景圆环颜色
  - lineCap 可设置进度条的闭合样式
  - showBottomProgress 可设置是否显示背景圆环
### 方法

  - 设置进度条渐变色 layer 的相关属性
  ```
  - (void)setProgressGradientLayerHandle:(void(^)(CAGradientLayer *gradientLayer))handle
  ```
  
  - 设置进度条进度条 maskLayer 的相关属性（线宽，虚线，进度等）
  ```
  - (void)setProgressLayerHandle:(void(^)(CAShapeLayer *progressLayer))handle
  ```
  
  - 设置底部圆环相关属性
  ```
  - (void)setBottomLayerHandle:(void(^)(CAShapeLayer *bottomLayer))handle;
  ```
# 图片预览
<img width="375" height="667" src="https://github.com/xiweinian/CircleProgress/blob/main/CircleProgress-Master/1.png"/>
<img width="375" height="667" src="https://github.com/xiweinian/CircleProgress/blob/main/CircleProgress-Master/2.png"/>
<img width="375" height="667" src="https://github.com/xiweinian/CircleProgress/blob/main/CircleProgress-Master/3.png"/>
