# mqtt和ssl库交叉编译

## OpenSSL交叉编译

1. 源码下载：`wget https://www.openssl.org/source/openssl-1.1.1k.tar.gz`

2. 解压：tar -vxzf openssl-1.1.1k.tar.gz     进入目录cd openssl-1.1.1k

3. 创建安装目录：mkdir _install

4. ```shell
   ./config no-asm shared --prefix=$PWD/_install --cross-compile-prefix=arm-linux-gnueabihf-
   #no-asm : Do not use assembler code
   #shared : 编译连接成动态库
   #--prefix=$PWD/_install : 指定编译后安装路径(绝对路径)
   #--cross-compile-prefix=arm-none-linux-gnueabi- : 指定交叉编译工具链
   ```

5. 删除Makefile下包含-m64的两行（vim下使用/-m64查找）

6. 执行`make`和`make install`


## paho.mqtt交叉编译

1. 源码下载：`git clone https://github.com/eclipse/paho.mqtt.c.git`

   **注意**：有以下提示时，将https改为http：

   fatal: unable to access 'https://github.com/eclipse/paho.mqtt.c.git/': gnutls_handshake() failed: Error in the pull function.

2. 进入目录：cd paho.mqtt.c

3. 修改Makefile：在**126行**处增加以下（替换为刚才编译生成openssl的实际路径）

   ```shell
   CFLAGS += -I../openssl-1.1.1k/_install/include
   LDFLAGS += -L../openssl-1.1.1k/_install/lib
   ```

4. 执行`make CC=arm-linux-gnueabihf-gcc`（更换为自己需要的编译器）

5. 不用执行make install，目前没有找到安装到制定目录的方法，make执行后生成到build/output下即可找到生成的库

## 使用例程

<https://github.com/xieyingqi/mqtt.git>
