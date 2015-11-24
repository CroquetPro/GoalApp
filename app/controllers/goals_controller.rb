class GoalsController < ApplicationController
  before_action :require_current_user!, except: [:index, :show]

  def index
    goals = Goal.all
    if current_user
      @personal_goals = goals.where(user_id: current_user.id)
      @public_goals = goals.where(privacy: :Public) - @personal_goals
    else
      @public_goals = goals.where(privacy: :Public)
    end
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goals_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:notice] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def goals_params
    params.require(:goal).permit(:title, :description, :privacy)
  end
end
