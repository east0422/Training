#  核心动画

## 开发步骤：
### 1、初始化一个动画对象(CAAnimation)并设置一些动画相关属性(如opacity、position、transform、bounds、             contents等)。
### 2、添加动画对象到层(CALayer)中，开始执行动画：调用CALayer的addAnimation:forKey。
### 3、停止层中的动画：removeAnimationForKey。

## 1、CAAnimation
### 1.1、所有动画对象的父类，负责控制动画的持续时间和速度、是个抽象类、不能直接使用、应使用它具体的子类。
### 1.2、常用属性         duration：动画持续时间；         repeatCount：动画的重复次数；         repeatDuration：动画的重复时间；         removedOnCompletion：默认为YES，代表动画执行完毕后就行图层上移除，图层恢复到动画执行前的状态。         若想让图层保持显示动画执行后的状态，就设置为NO，并且还要设置fillMode为kCAFillModeForwards；         fillMode：决定当前对象在非active时间段的行为，如动画开始前后动画结束后。         beginTime：可以用来设置动画延迟执行时间、若想延迟2s，就设置为CACurrentMediaTime()+2。
      timingFunction：速度控制函数、控制动画运行的节奏。
      delegate：动画代理。

##  2、CAPropertyAnimation
###  2.1、是CAAnimation的子类，也是个抽象类，要想创建动画对象，应该使用它的两个子类：CABasicAnimation和         CAKeyframeAnimation。
### 2.2、属性解析         keyPath：通过指定CALayer的一个属性名称为keyPath(NSString类型)，并且对CALayer的这个属性的值进行         修改，达到相应的动画效果。比如指定@“position”为keyPath，就修改CALayer的position属性的值，以达到         平移的动画效果。

## 3、CABasicAnimation
### 3.1、CAPropertyAnimation子类。
### 3.2、属性解析         fromValue：keyPath相应属性的初始值。         toValue：keyPath相应属性的结束值。
      byValue：动画增加值
      随着动画的进行，在长度为duration的持续时间内，keyPath相应属性的值从fromValue渐渐地变为toValue。
      如果fillMode=kCAFillModeForwards和removedOnCompletion=NO,那么在动画执行完毕后，图层会保持显示动画执行后的状态。
      但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。比如，CALayer的position初始值为(0,0)，
      CABasicAnimation的fromValue为(10,10)，toValue为(100,100)，虽然动画执行完毕后图层保持在(100,100)这个位置，实质
      上图层的position还是为(0,0)。或者设置animation的delegate在代理方法animationDidStop中处理让动画保持执行后的状态。
      
  ## 4、CAKeyframeAnimation
  ### 4.1、CAPropertyAnimation子类，跟CABasicAnimation的区别是:CABasicAnimation只能从一个数值(fromValue）         变到另一个数值(toValue)，而CAKeyframeAnimation会使用一个NSArray保存这些数值。
  ### 4.2、属性解析         values：就是上述的NSArray对象。里面的元素称为”关键帧”(keyframe)。动画对象会在指定的时间(duration)         内，依次显示values数组中的每一个关键帧。         path：可以设置一个CGPathRef\CGMutablePathRef，让层跟着路径移动。path只对CALayer的anchorPoint         和position起作用。如果你设置了path，那么values将被忽略。         keyTimes：可以为对应的关键帧指定对应的时间点，其取值范围为0到1.0，keyTimes中的每一个时间值都对应         values中的每一帧。当keyTimes没有设置的时候，各个关键帧的时间是平分的。         CABasicAnimation可看做是最多只有2个关键帧的CAKeyframeAnimation。
        可用于监听设备的抖动即实现摇一摇功能。

## 5、CAAnimationGroup
### 5.1、CAAnimation的子类，可以保存一组动画对象，将CAAnimationGroup对象加入层后，组中所有动画对象可以同         时并发运行。
### 5.2、属性解析
        animations：用来保存一组动画对象的NSArray。默认情况下，一组动画对象是同时运行的，也可以通过设置动画对象的beginTime属性来更改动画的开始时间。
        
## 6、CATransition
### 6.1、CAAnimation的子类，用于做转场动画，能够为层提供移出屏幕和移入屏幕的动画效果。
### 6.2、UINavigationController就是通过CATransition实现了将控制器的视图推入屏幕的动画效果。
### 6.3、属性解析
        type：动画过渡类型。
        subtype：动画过渡方向。
        startProgress：动画起点(在整体动画的百分比)。
        endProgress：动画终点(在整体动画的百分比)。
        
        
## 开发遇到issue及解决方法
### 1. tabBarItem的image不显示
        ios7之后tabBarItem默认渲染为automatic不会显示图片需设置为alwaysOriginal
        详细参考官方文档：By default, unselected and selected images are automatically created from the alpha values in the source images. To prevent system coloring, provide images with alwaysOriginal.
### 2.  默认图片会向上偏移
        需设置tabBarItem的imageInsets
### 3. UITabBarController使用addChildViewController只能显示5个tabitem且不会有more
        直接更改viewcontrollers
        

