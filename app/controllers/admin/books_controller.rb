class Admin::BooksController < Admin::BaseController
  before_action :find_book, only: [:edit, :show, :update, :destroy]
  
  def index
      @books = Book.available
                    .with_attached_cover_image
                    .page(params[:page])
                    .per(4)
      #select * from books
    end
  
  def new
    @book = Book.new
  end

  def edit
    # @book = Book.find_by(id: params["id"])
    # redirect_to root_path unless @book, notice: '查無此書'

    # begin
    #   @book = Book.find(params["id"])
    # rescue => exception
    #   redirect_to root_path unless @book, notice: '查無此書'
    # end
  end

  def update

    if @book.update(book_params)
    #   flash[:notice] = "新增書本成功"
      redirect_to edit_admin_books_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to admin_books_path, notice: '資料已刪除'
  end

  def show
  
  end

  def create
    @book = Book.new(book_params) 

    if @book.save
    #   flash[:notice] = "新增書本成功"
      redirect_to admin_books_path, notice: '新增書本成功'
    else
      render :new
    end
  end
  
  private

  def find_book
    @book = Book.find_by(id: params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, :list_price, :sell_price, :page_num, :isbn, :isbn13, :cover_image, :on_sell, :published_at, :publisher_id)  
  end

      
end
