class DoingsController < ApplicationController
  def index
    @doings = Doing.all
  end

  def show
    @doing_log = Doing.find(params[:id])
  end

  def new
    @doing_log = Doing.new
  end

  def edit
    @doing_log = Doing.find(params[:id])
  end

  def create
    @doing_log = current_user.doings.new(doing_log_params)
    if @doing_log.save
      redirect_to @doing_log, notice: '新しいDoingが投稿されました！'
    else
      render 'new'
    end
  end

  def update
    @doing_log = Doing.find(params[:id])
    @doing_log.assign_attributes(doing_log_params)
    if @doing_log.save
      redirect_to @doing_log, notice: 'Doingの編集が完了しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @doing_log = Doing.find(params[:id])
    @doing_log.destroy
    redirect_to controller: 'doings', action: 'index'
  end

  private

  def doing_log_params
    params.require(:doing_log).permit(:title, :summary)
  end
end
