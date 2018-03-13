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

* 移动客户端优先, 因此暂时忽略低于 IE11 浏览器的支持, 由于是静态网页因此将使用 `meta` 标签来跳转

  ```html
  <!--[if lt IE 11]>
    <meta http-equiv="refresh" content="0; url=http://example.com/" />
  <![endif]-->
  ```