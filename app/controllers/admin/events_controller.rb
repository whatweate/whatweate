class Admin::EventsController < ApplicationController
  # before_action :authenticate_admin!
  before_action :assign_event, except: [:index, :new, :create]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to(admin_events_url, notice: "Event successfully created")
    else
      render(:new)
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to(admin_event_url(@event), notice: "Event successfully updated")
    else
      render(:edit)
    end
  end

  def destroy
    if @event.present?
      @event.destroy
      redirect_to(root_path, notice: "Event successfully deleted")
    else
      redirect_to(edit_admin_event_url(@event))
    end
  end

  private

  def assign_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :location, :description, :menu, :seats, :price_in_pennies, :currency)
  end

end