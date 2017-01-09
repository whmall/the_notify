class Work::NotificationsController < Work::BaseController
  before_action :set_notification, only: [:show, :url, :read, :edit, :update, :destroy]

  def index
    @notifications = current_user.notifications.order(read_at: :asc)
    if params[:scope] == 'have_read'
      @notifications = @notifications.have_read
    else
      @notifications = @notifications.unread
    end
    @notifications = @notifications.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def read_all
    @notifications = current_user.notifications
    @notifications.update_all(read_at: Time.now)
    Notification.update_unread_count(current_user.id)
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(params[:notification].permit!)

    if @notification.save
      redirect_to(notifications_path, notice: 'Notification 创建成功。')
    else
      render action: "new"
    end
  end

  def show
  end

  def url
    @notification.update_unread
    redirect_to @notification.link
  end

  def read
    @notification.update_unread
  end

  def edit
  end

  def update
    if @notification.update_attributes(params[:notification].permit!)
      redirect_to(notifications_path, notice: 'Notification 更新成功。')
    else
      render action: "edit"
    end
  end

  def destroy
    @notification.destroy
    redirect_to(notifications_path, notice: "删除成功。")
  end

  private
  def set_notification
    @notification = Notification.find(params[:id])
  end

end