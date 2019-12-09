class BooksController < ApplicationController
before_action :find_book, only: [:show, :comment]
layout 'book'

  def index
    @books = Book.available
                 .with_attached_cover_image
                 .page(params[:page])
                 .per(4)
    #select * from books
    @publishers = Publisher.available
  end

  def show
    @comment = Comment.new
    @comments = @book.comments.order(id: :desc)
  end

  def comment
    @comment = Comment.new(comment_params)
    
    # @comment = @book.comments.build(comment_params, user:current_user) book角度
    # @comment = current_user.comments.build(comment_params, book: @book) user角度
    if @comment.save
      redirect_to @book, notice: '留言成功'
    else
      redirect_to comment_book_path #待確認
    end
  end
  
  private
  def find_book
    @book = Book.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :content).merge(user: current_user, book: @book)
  end
end


