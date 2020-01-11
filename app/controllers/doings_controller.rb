class DoingsController < ApplicationController
  def index
    @doings = Doing.all
  end

  def show
    @doing = Doing.find(params[:id])
  end

  def new
    @doing = Doing.new
  end

  def edit
    @doing = Doing.find(params[:id])
  end

  def create
    @doing = current_user.doings.new(doing_params)
    if @doing.save
      redirect_to @doing, notice: '新しいDoingが投稿されました！'
    else
      render 'new'
    end
  end

  def update
    @doing = Doing.find(params[:id])
    @doing.assign_attributes(doing_params)
    if @doing.save
      redirect_to @doing, notice: 'Doingの編集が完了しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @doing = Doing.find(params[:id])
    @doing.destroy
    redirect_to controller: 'doings', action: 'index'
  end

  private

  def doing_params
    params.require(:doing).permit(:title, :summary)
  end
end
