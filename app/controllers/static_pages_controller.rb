class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @next_events, @just_added = [ Thread.new{ Event.active.order(:date).first(5) },
                                  Thread.new{ Event.active.order(:created_at).last(2) } ]
  end
end
