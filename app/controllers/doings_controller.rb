class DoingLogsController < ApplicationController
  def index
    @doing_logs = DoingLog.all
  end

  def show
    @doing_log = DoingLog.find(params[:id])
  end

  def new
    @doing_log = DoingLog.new
  end

  def edit
    @doing_log = DoingLog.find(params[:id])
  end

  def create
    @doing_log = current_user.doing_logs.new(doing_log_params)
    if @doing_log.save
      redirect_to @doing_log, notice: '新しいDoingLogが投稿されました！'
    else
      render 'new'
    end
  end

  def update
    @doing_log = DoingLog.find(params[:id])
    @doing_log.assign_attributes(doing_log_params)
    if @doing_log.save
      redirect_to @doing_log, notice: 'DoingLogの編集が完了しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @doing_log = DoingLog.find(params[:id])
    @doing_log.destroy
    redirect_to controller: 'doing_logs', action: 'index'
  end

  private

  def doing_log_params
    params.require(:doing_log).permit(:title, :summary)
  end
end
