class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @x = 0
    if params[:n].present?
      @x = params[:n].to_i + 1
    elsif params[:p].present?
      @x = params[:p].to_i - 1
    else
      @x = 0
    end
  
    @now = Date.today
    @wday = ["日", "月", "火", "水", "木", "金", "土"]
    @this_year = params[:year].to_i
    @this_month = params[:month].to_i + @x
  
    if @this_month > 12
      @this_month -= 12
      @this_year += 1
    elsif @this_month < 1
      @this_month += 12
      @this_year -= 1
    end

    def adjust_year_and_month(year, month)
      while month > 12
        month -= 12
        year += 1
      end
      while month < 1
        month += 12
        year -= 1
      end

      [year, month]
    end

    @this_year, @this_month = adjust_year_and_month(@this_year, @this_month)
  
    @first_day = Date.new(@this_year, @this_month, 1)
    @last_day = @first_day.end_of_month
    
    @posts = {}
  
    (@first_day..@last_day).each do |day|
      @posts[day.day] = Post.where(year: @this_year, month: @this_month, date: day.day)
    end

    @addedScheduleLength = Post.where(year: @this_year, month: @this_month).length
  end
end