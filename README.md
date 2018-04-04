draft-goserv
--------

**WIP**

使用静态网页 + `ajax` 的方式来表现网页或APP。

## 后端

使用 fastcgi 的方式来联接 nginx 与 go 后端.

* [ ] 使用 HTTPS, 这是集成各种登录(例如微信)的必要条件

* [ ] 添加 websocket 用于推送.

* [ ] 轻量型数据库

  - [ ] 添加 session 功能.

## 前端

* 单页？

* polyfill for IE8:

  - [x] event: only `preventDefault, stopPropagation`
  - [x] classList.js
  - [ ] es6-promise.auto.js
  - [ ] fetch.js

* 图标工具, 及库

  - 如果从字体里选图标的话，还是使用 `BMFont` 可以直观地选择想要的图标, 只是感觉不怎清晰, 因为很多都是非点阵的。
 