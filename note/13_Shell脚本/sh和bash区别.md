在shell脚本的开头往往有一句话来定义使用哪种sh解释器来解释脚本，目前研发送测的shell脚本中主要有以下两种方式：
1. #!/bin/sh
2. #!/bin/bash

以上两种方式有什么区别？对于脚本的实际运行会产生什么不同的影响吗？

脚本test.sh内容：
```bash
#!/bin/sh
source pcy.sh #pcy.sh并不存在
echo hello
```
执行./test.sh，屏幕输出为：`./test.sh: line 2: pcy.sh: No such file or directory`  
由此可见，在`#!/bin/sh`的情况下，source不成功，不会运行source后面的代码。
***
修改test.sh脚本的第一行，变为`#!/bin/bash`，再次执行./test.sh  
屏幕输出为：`./test.sh: line 2: pcy.sh: No such file or directory hello`

由此可见，在#!/bin/bash的情况下，虽然source不成功，但是还是运行了source后面的echo语句。
***
但是紧接着我又试着运行了一下sh ./test.sh，这次屏幕输出为：`./test.sh: line 2: pcy.sh: No such file or directory`，表示虽然脚本中指定了#!/bin/bash，但是如果使用sh 方式运行，如果source不成功，也不会运行source后面的代码，为什么会有这样的区别呢？
***
**说明：**
1. sh一般设成bash的软链
```
	[work@zjm-testing-app46 cy]$ ll /bin/sh
	lrwxrwxrwx 1 root     root          4 Nov 13   2006 /bin/sh -> bash
```
2. 在一般的linux系统当中（如redhat），使用sh调用执行脚本相当于打开了bash的POSIX标准模式
2. 也就是说 `/bin/sh` 相当于 `/bin/bash --posix`

***所以，sh跟bash的区别，实际上就是bash有没有开启posix模式的区别***，so，可以预想的是，如果第一行写成 #!/bin/bash --posix，那么脚本执行效果跟#!/bin/sh是一样的（遵循posix的特定规范，有可能就包括这样的规范：“当某行代码出错时，不继续往下解释”）