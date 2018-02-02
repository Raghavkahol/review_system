class BooksController < ApplicationController
	before_action :find_book, only: [:show,:edit,:update,:destroy]
	before_action :category_map, only: [:edit,:update,:new,:create]
	def new
			
			@book=current_user.books.build
	end
	
	def index
		if params[:category].blank?
			@books=Book.all.order("created_at DESC")
		else
			@category_id=Category.find_by(name: params[:category]).id
			@books=Book.where(:category_id=>@category_id)
		end
	end
	
	def show
		
	end
	
	def create
		@book=current_user.books.build(book_params)
		@book.category_id= params[:category_id]
		if @book.save
			redirect_to root_path
		else
			render 'new'
		end
	end
	
	def edit
		
	end
	
	def update
		@book.category_id= params[:category_id]
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'new'
		end
	end
	
	def destroy
		@book.destroy
		redirect_to root_path
	end
	
	private
	
	def book_params
		params.require(:book).permit(:title,:description, :author, :category_id, :book_img)
	end
	
	def category_map
			@category= Category.all.map{ |c| [c.name, c.id] }
	end
	
	def find_book
		@book=Book.find(params[:id])
	end
end
