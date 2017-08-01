# rails360

网站：[rails360](http://www.rails360.com:8080)

### 依赖

* Rails 5.0
* Ruby 2.4
* MySQL 5.7
* Redis
* ImageMagick 

**---- branch elastic ----**

* ElasticSearch 5.*

### 运行

MySQL、Redis服务必须先启动好。

如果是branch elastic的话，还需要启动ElasticSearch服务。

```
bundle install
rake db:create
rake db:migrate
rake db:seed
rails s
```

或者修改 `config/deploy.rb` 配置文件，使用mina自动部署

``` 
mina setup
mina deploy
```

### 测试

```
bundle exec rspec
```

### API接口文档

[rails360 API](http://www.rails360.com:8080/docs)