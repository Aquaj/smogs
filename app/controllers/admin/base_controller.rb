class Admin::BaseController < ApplicationController
  before_action :authenticate!
end
