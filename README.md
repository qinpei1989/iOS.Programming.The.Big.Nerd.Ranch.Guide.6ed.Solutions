# iOS.Programming.The.Big.Nerd.Ranch.Guide.6ed.Solutions

This project contains my solutions for challenges in book **iOS Programming: The Big Nerd Ranch Guide (6th Edition)**, which is a very good turtorial for new iOS developers like me. 

Each solution is based on the original source code downloaded from  `www.bignerdranch.com/solutions/iOSProgramming6ed.zip`.
If you see any issues or would like to share your thoughts, please contact <qinpei1989@gmail.com>.

<br />
该项目是我在学习iOS开发入门书籍**《iOS Programming: The Big Nerd Ranch Guide (6th Edition)》**一书时对每各章结尾练习的解答。每章的解答都是在官网下载的源代码`www.bignerdranch.com/solutions/iOSProgramming6ed.zip`的基础上修改的。

作为一名iOS开发新人，答案中必然有众多不足之处。如果您发现答案中有任何问题或者有更好的思路，欢迎给我发邮件共同讨论：<qinpei1989@gmail.com>。

<br />
### Development Environment 开发环境
>
Xcode 8.3.3
>
iOS 10
>
Swift 3

<br />
## ch4:
### Bronze Challenge: Disallow Alphabetic Characters
Currently, the user can enter alphabetic characters either by using a Bluetooth keyboard or by pasting copied text into the text field. Fix this issue. Hint: You will want to use the NSCharacterSet class.  

>1. 创建一个NSCharacterSet对象，使其仅包含合法输入字符，包括0~9、'.'和‘-’  
2. 用rangeOfCharacter(from:options:range:)判断replacementString中是否包含合法输入字符.  
3. 如果只做以上两步，会发现delete键失效，所以还要对replacementString的长度进行判断，若其为0，则说明delete键被按下

<br />
## ch5:
### Silver Challenge: Dark Mode
Whenever the ConversionViewController is viewed, update its background color based on the time of day. In the evening, the background should be a dark color. Otherwise, the background should be a light color. You will need to override viewWillAppear(_:) to accomplish this. (If that is not enough excitement in your life, you can change the background color each time the view controller is viewed.)

>1. 根据Calendar.current.component(_:from)可获取当前的时间
2. 利用arc4random_uniform(_)生成一个随机数，传入值为value，则生成的范围在[0, value)

<br />
## ch6:
### Bronze Challenge: Another Tab
Create a new view controller and add it to the tab bar controller. This view controller should display a WKWebView, which is a class used to display web content. The web view should display www.bignerdranch.com for you to book your next vacation.

>WKWebView的简单应用，需要import WebKit，Apple document中有一个简单的例子可以直接参考

### Silver Challenge: User’s Location
Add a button to the MapViewController that displays and zooms in on the user’s current location. You will need to use delegation to accomplish this. Refer to the documentation for MKMapViewDelegate.

>1. 申请定位权限需要在info.plist中加入NSLocationAlwaysUsageDescription或NSLocationWhenInUseUsageDescription
2. MKMapView的showsUserLocation是一个Bool值，用于决定是否显示用户当前位置，而setUserTrackingMode(_:animated:)可时刻追踪用户位置
3. 若不使用setUserTrackingMode(_:animated:)，还可利用MKMapViewDelegate中的mapView(_:didUpdate:)来指定一个MKCoordinateRegion来确定包含用户所在位置的范围大小

### Gold Challenge: Dropping Pins
Map views can display pins, which are instances of MKPinAnnotationView. Add three pins to the map view: one where you were born, one where you are now, and one at an interesting location you have visited in the past. Add a button to the interface that allows the map to display the location of a pin. Subsequent taps should simply cycle through the list of pins.

>1. 在地图上显示大头钉需要创建MKAnnotation对象，而MKAnnotation是一个协议，它包含了一个required的坐标值，MKPointAnnotation类实现了此协议
2. 如果不需要大头钉扎向地图的动画效果，则可以简单地创建若干个MKPointAnnotation对象，将它们加进mapView即可。若需要动画效果或者是增加大头钉的功能，则需要实现mapView(_:viewFor:)来返回一个MKAnnotationView，而MKPinAnnotationView继承了此类
3. 注意不能简单地用mapView.userLocation来返回当前用户的位置，因为读取它时总是返回一个nil。我的猜想是系统此时还没有获得用户真正的位置，仍需要等一段时间。因而可换一种思路，建立一个CLLocationManager对象，实现CLLocationManagerDelegate中的locationManager(_:didUpdateLocations:)来获取位置

<br />
## ch7:
### Bronze Challenge: Another Localization
Practice makes perfect. Localize WorldTrotter for another language. Use a translation website if you need help with the language.

>1. 仿照书中加入西班牙文的例子可很容易地加入中文支持，包括创建一个新的Main.strings用于翻译storyboard，以及一个新的Localizable.strings用于代码中NSLocalizedString对象的外文支持
2. 书中没有给出如何对Info.plist进行本地化的例子，应当新建一个Strings文件，命名为InfoPlist.strings，然后仿照Localizable.strings将需要翻译的key-value加入即可。还有一个坑是在测试时不能靠改Edit Scheme中的语言设置，而应在设备上将语言切换

<br />
## ch8:
### Bronze Challenge: Spring Animations
iOS has a powerful physics engine built in. An easy way to harness this power is by using a spring animation.

```
// UIView
class func animate(withDuration duration: TimeInterval,
delay: TimeInterval,
usingSpringWithDamping dampingRatio: CGFloat,
initialSpringVelocity velocity: CGFloat,
options: UIViewAnimationOptions,
animations: () -> Void,
completion: ((Bool) -> Void)?)
```    
Use this method to have the two labels animate on and off the screen in a spring-like fashion. Refer to the UIView documentation to understand each of the arguments.

>简单的弹簧效果动画，可尝试选用不同的usingSpringWithDamping值及initialSpringVelocity来观察效果：
>
1. usingSpringWithDamping：取值为0~1.0，即阻尼系数，值越小弹簧弹性越好、振幅越大
2. initialSpringVelocity：初始速度，若总移动距离为d，则速度为1表示d points/s


### Silver Challenge: Layout Guides
If you rotate into landscape, the nextQuestionLabel becomes visible. Instead of hardcoding the spacing constraint’s constant, use an instance of UILayoutGuide to space the two labels apart. This layout guide should have a width constraint equal to the ViewController’s view to ensure that the nextQuestionLabel remains offscreen when not animating.

>题目中的情况没有出现过。。。在设备方向变成水平后，view.frame.width也随之改变了，因而nextQuestionLabel移出屏幕的距离也变长，并不存在题目中描述的bug。。。

<br />
## ch10:
### Bronze Challenge: Sections
Have the UITableView display two sections – one for items worth more than $50 and one for the rest. Before you start this challenge, copy the folder containing the project and all of its source files in Finder. Then tackle the challenge in the copied project; you will need the original to build on in the following chapters.

>1. 将原来的allItems数组按照价格是否大于$50分成两个数组，分别对应两个section即可
2. 实现tableView(_:titleForHeaderInSection:)来用一个String简单地显示">$50"和"<=$50"。或者用tableView(_:viewForHeaderInSection:)来返回一个UIView，这样显示的内容可以更丰富，可以参考下面的Gold Challenge

### Silver Challenge: Constant Rows
Make it so the last row of the UITableView always has the text "No more items!" Make sure this row appears regardless of the number of items in the store (including 0 items).

>"No more items!"对应的section为最后一个，对应的row为数组的长度，需要在tableView(_:numberOfRowsInSection:)及tableView(_:cellForRowAt:)中加上此判断

### Gold Challenge: Customizing the Table
Make each row’s height 60 points, except for the last row from the Silver challenge, which should remain 44 points. Then, change the font size of every row except the last to 20 points. Finally, make the background of the UITableView display an image. (To make this pixel-perfect, you will need an image of the correct size depending on your device. Refer to the chart in Chapter 1.)

>1. 调整不同的行高可实现tableView(_:heightForRowAt:)
2. 有两个方法来设置header，一个简单地返回一个String，另一个返回一个UIView。若只是简单地返回String，则默认的UIView不透明，会挡住背景图片，看上去不美观，因此可实现返回UIView的方法，将UIView的背景设成透明

<br />
## ch11:
### Bronze Challenge: Renaming the Delete Button
When deleting a row, a confirmation button appears labeled Delete. Change the label of this button to Remove.

>只需实现UITableViewDelegate的tableView(_:titleForDeleteConfirmationButtonForRowAt:)方法，该方法默认返回"Delete"

### Silver Challenge: Preventing Reordering
Make it so the table view always shows a final row that says “No more items!” (This part of the challenge is the same as a challenge from the last chapter. If you have already done it, you can copy your code from before.) Now, make it so that the final row cannot be moved.

>实现UITableViewDataSource的tableView(_:canMoveRowAt:)方法

### Gold Challenge: Really Preventing Reordering
After completing the Silver challenge, you may notice that even though you cannot move the No more items! row itself, you can still drag other rows underneath it. Make it so that – no matter what – the No more items! row can never be knocked out of the last position. Finally, make it undeletable.

>1. UITableViewDataSource的tableView(_:canEditRowAt:)方法阻止最后一行被删掉
2. UITableViewDelegate的tableView(_:targetIndexPathForMoveFromRowAt:toProposedIndexPath:)方法可控制行间的移动。Silver challenge中已经使得最后一行不能移动，因此在该方法中，当toProposedIndexPath为最后一行及之后的位置时，返回自身，即targetIndexPathForMoveFromRowAt，阻止移动

<br />
## ch12:
### Bronze Challenge: Cell Colors
Update the ItemCell to display the valueInDollars in green if the value is less than 50 and red if the value is greater than or equal to 50.

>1. 可在ItemCell的layoutSubviews()调用时对颜色进行调整
2. 需要先将textLabel的String转换成Double，而String的第一个字符为$，所以需要从第2个字符开始进行转换

<br />
## ch14:
### Bronze Challenge: Displaying a Number Pad
The keyboard for the UITextField that displays an Item’s valueInDollars is a QWERTY keyboard. It would be better if it were a number pad. Change the Keyboard Type of that UITextField to the Number Pad. (Hint: You can do this in the storyboard file using the attributes inspector.)

>简单，可在代码或Storyboard中改

### Silver Challenge: A Custom UITextField
Make a subclass of UITextField and override the becomeFirstResponder() and resignFirstResponder() methods (inherited from UIResponder) so that its border style changes when it is the first responder. You can use the borderStyle property of UITextField to accomplish this. Use your subclass for the text fields in DetailViewController.

>override两个方法，改变borderStyle即可

### Gold Challenge: Pushing More View Controllers
Currently, instances of Item cannot have their dateCreated property changed. Change Item so that they can, and then add a button underneath the dateLabel in DetailViewController with the title “Change Date.” When this button is tapped, push another view controller instance onto the navigation stack. This view controller should have a UIDatePicker instance that modifies the dateCreated property of the selected Item.

>用同样的方法将item传给新的view controller，将改变后的日期赋给item.dateCreated即可

<br />
## ch15:
### Bronze Challenge: Editing an Image
UIImagePickerController has a built-in interface for editing an image once it has been selected. Allow the user to edit the image and use the edited image instead of the original image in DetailViewController.

>1. 需要将UIImagePickerController的allowsEditing改成true，允许用户编辑
2. 通过imagePickerController(_:didFinishPickingMediaWithInfo:)将图片取出时，UIImagePickerControllerOriginalImage的key对应的value为原图，UIImagePickerControllerEditedImage对应的是用户编辑后的图

### Silver Challenge: Removing an Image
Add a button that clears the image for an item.

>当没有图片的时候，将button的alpha值设为0，有图片的时候设为1.0

### Gold Challenge: Camera Overlay
UIImagePickerController has a cameraOverlayView property. Make it so that presenting the UIImagePickerController shows a crosshair in the middle of the image capture area.

>新建一个UIView，其frame为pickerController.cameraOverlayView?.frame。然后再建一个UILabel作为其subview，令其内容为“+”。把该UIView设为pickerController.cameraOverlayView即可

<br />
## ch16:
### Bronze Challenge: PNG
Instead of saving each image as a JPEG, save it as a PNG.

>改一行代码：将UIImageJPEGRepresentation改成UIImagePNGRepresentation

<br />
## ch17:
### Bronze Challenge: Stacked Text Field and Labels
In a compact height environment, make it so the text fields and labels are stacked vertically instead of horizontally.

>在storyboard中，将包含UILabel和UITextField的UIStackView在compact height时改成vertical

<br />
## ch18:
### Silver Challenge: Colors
Make it so that the angle at which a line is drawn dictates its color once it has been added to currentLines.

>1. 角度的计算：atan(dy/dx)和atan2(dy,dx)都可计算出角度，但atan2允许dx为0，返回的结果为弧度值，范围在[-pi, +pi]
2. 可建立一个UIColor数组，对角度进行归一化处理后得到一个数组的index来决定用哪个颜色

### Gold Challenge: Circles
Use two fingers to draw circles. Try having each finger represent one corner of the bounding box around the circle. Recall that you can simulate two fingers on the simulator by holding down the Option key. (Hint: This is much easier if you track touches that are working on a circle in a separate dictionary.)

>模仿Line，新建一个Circle的struct，通过两个触摸点可计算出圆的圆心位置以及直径大小

<br />
## ch19:
### Silver Challenge: Mysterious Lines
There is a bug in the application. If you tap on a line and then start drawing a new one while the menu is visible, you will drag the selected line and draw a new line at the same time. Fix this bug.

>问题的根源在于当一条线被选中时，selectedLineIndex不为nil，此时UIPanGestureRecognizer便会开始识别拖拽的手势。解决方式为修改成仅在长按一条线后才允许拖拽：

>1. 增加一个类似的longPressSelectedLineIndex，它和selectedLineIndex不能同时set，仅当长按手势识别出且触摸点在某一条线上时它会有值
2. 仅当longPressSelectedLineIndex不为nil时，UIPanGestureRecognizer才开始起作用

### Gold Challenge: Speed and Size
Piggy-back off of the pan gesture recognizer to record the velocity of the pan when you are drawing a line. Adjust the thickness of the line being drawn based on this speed. Make no assumptions about how small or large the velocity value of the pan recognizer can be. (In other words, log a variety of velocities to the console first.)

>1. UIPanGestureRecognizer的velocity(in:)返回拖拽的速度，单位为points/s。返回的是一个CGPoint值，可由x、y计算出斜边的速度即为真正的拖拽速度
2. 记录目前监测到的最大速度和最小速度，与当前速度作比较，可得出一个适合的线宽，例如速度越快画出的线越细

### Platinum Challenge: Colors
Have a three-finger swipe upward bring up a panel that shows colors. Selecting one of those colors should make any lines you draw afterward appear in that color. No extra lines should be drawn by putting up that panel – or any lines drawn should be immediately deleted when the application realizes that it is dealing with a three-finger swipe.

>1. 新增一个UISwipeGestureRecognizer，令其delaysTouchesBegan为true，则轻扫的时候不会触发而导致画线。同时它的优先级应比UIPanGestureRecognizer高，否则拖拽手势也会被识别出来
2. 利用UIMenuController来选择线条颜色

<br />
## ch20:
### Bronze Challenge: Printing the Response Information
The completion handler for dataTask(with:completionHandler:) provides an instance of URLResponse. When making HTTP requests, this response is of type HTTPURLResponse (a subclass of URLResponse). Print the statusCode and headerFields to the console. These properties are very useful when debugging web service calls.

>简单，直接打印

### Silver Challenge: Fetch Recent Photos from Flickr
In this chapter, you fetched the interesting photos from Flickr using the flickr.interestingness.getList endpoint. Add a new case to your Method enumeration for recent photos. The endpoint for this is flickr.photos.getRecent. Extend the application so you are able to switch between interesting photos and recent photos. (Hint: The JSON format for both endpoints is the same, so your existing parsing code will still work.)

>1. 按书中的例子加上一个新的method及由之生成的URL，然后修改PhotoStore的fetchInterestingPhotos方法，将URL传入，由此决定是interesting还是recent photos
2. 两种相片的切换可使用UISegmentedControl来操作

<br />
## ch21:
### Silver Challenge: Updated Item Sizes
Have the collection view always display four items per row, taking up as much as the screen width as possible. This should work in both portrait and landscape orientations.

>1. 需要实现UICollectionViewDelegateFlowLayout中的collectionView(_:layout:sizeForItemAt:)计算每个cell的大小，需要注意的是若要令每行显示4个，则需要减去5个spacing的宽度
2. 方向在水平与垂直进行切换时，会调用viewWillTransition(to:with:)，在这里面调用reloadData()

<br />
## ch22:
### Bronze Challenge: Photo View Count
Add an attribute to the Photo entity that tracks how many times a photo is viewed. Display this number somewhere on the PhotoInfoViewController interface.

>1. 在Photo中增加一个viewCount属性，重新生成NSManagedObject子类
2. 当图片下载成功后，每点开一张图片，使得viewCount自增1，并在NSManagedObjectContext中保存，同时更新UI

