class NoticeController < ApplicationController

  # skip_before_action :authenticate_user!

  def index
    App_LOG.info("Time:#{Time.now} start #{self.class.name}.#{__method__}")
    App_LOG.info("Time:#{Time.now} end #{self.class.name}.#{__method__}")
  end
end
