class BooksController < ApplicationController

  def create
    # １. データを受け取り新規登録するためのインスタンス作成
    @new_book = Book.new(book_params)
    # 2. データをデータベースに保存するためのsaveメソッド実行
    if @new_book.save
      # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@new_book.id)
    else
      @book = Book.all
      render :index
    end
  end

  def index
    @book = Book.all
    @new_book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params) 
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
