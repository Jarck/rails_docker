#!/bin/bash
#文件的换行模式要选UNIX风格的LF,不然脚本执行会出错!

REDIS_HOST=redis
echo "export REDIS_HOST=${REDIS_HOST}" >> ${HOME}/.bashrc

#如果读不到环境变量RUN_CONTEXT，默认设为dev
if [ -z $RUN_CONTEXT ]; then
    RUN_CONTEXT='dev'
    echo "export RUN_CONTEXT=${RUN_CONTEXT}" >> ${HOME}/.bashrc
fi

#使设置的环境变量即时生效
source ~/.bashrc

#开发环境
if [ "$RUN_CONTEXT" = "dev" ]; then
    #启动cron
    /etc/init.d/cron start
    #执行rake任务
    bundle exec rake db:migrate

    nohup /bin/bash -c "bundle exec sidekiq -e production -C config/sidekiq.yml" &

    #启动rails
    #echo `bundle exec rails s -b 0.0.0.0 -p 3000`
    passenger start --environment development --port 3000

#生产环境
elif [ "$RUN_CONTEXT" = "prod" ]; then
    #启动cron
    /etc/init.d/cron start

    #执行assets:precompile
    RAILS_ENV=production bundle exec rake assets:precompile
    #执行db:migrate
    RAILS_ENV=production bundle exec rake db:migrate

    nohup /bin/bash -c "bundle exec sidekiq -e production -C config/sidekiq.yml" &

    #启动rails
    passenger start
else
    echo "unknown RUN_CONTEXT:${RUN_CONTEXT}"
fi
