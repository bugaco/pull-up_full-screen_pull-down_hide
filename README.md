# pull-up_full-screen_pull-down_hide

iOS UITableView上拉全屏，下拉隐藏Demo。  
效果如下：  
![image](https://github.com/zanyzephyr/pull-up_full-screen_pull-down_hide/blob/master/pull-up_full-screen_pull-down_hide/res/%E6%95%88%E6%9E%9C%E5%9B%BE.gif)  
  
    
       
全屏、隐藏的逻辑在方法`scrollViewWillEndDragging(_:withVelocity:targetContentOffset:)`中。  
详细见源码（提示：引入了snapkit进行布局，需要用pod安装）。  
