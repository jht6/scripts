# run-gpu

由于gpu.js依赖的gl库需要在安装时需要编译c++代码，且需要请求外网服务，因此在执行 `npm i` 之前要先做两件事：

1. 先安装c++编译环境，参考：[https://github.com/nodejs/node-gyp#on-windows](https://github.com/nodejs/node-gyp#on-windows)
2. 配置npm代理，以shadowsocks为例，执行命令:
```
npm config set proxy http://127.0.0.1:1080
npm config set https-proxy http://127.0.0.1:1080
```

然后执行 `npm i` 即可正常安装依赖。

如果事后想去掉npm代理，可执行：

```
npm config delete proxy
npm config delete https-proxy
```
