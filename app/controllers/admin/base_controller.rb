class Admin::BaseController < ApplicationController
  before_action :authenticate!

  layout 'admin'
end
