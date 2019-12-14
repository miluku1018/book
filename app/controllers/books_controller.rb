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
    # @comment = Comment.new(comment_params)
    # book角度
    @comment = @book.comments.build(comment_params)
    # @comment = current_user.comments.build(comment_params, book: @book) user角度
    if @comment.save
      respond_to do |form|
       format.js{}
      #  後面大誇號沒寫, 就會render同名的檔案
      end
      # render json: {status: "ok"}; #標準做法
      # render js: 'alert("hi")'; for前端是rails設計師
      # redirect_to @book, notice: '留言成功'
    else
      render js: 'alert("發生錯誤");'     
    end
  end
  
  private
  def find_book
    @book = Book.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :content).merge(user: current_user)
  end
end


