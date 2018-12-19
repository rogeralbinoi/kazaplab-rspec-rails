class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @posts = Post.all
    end

    def show
        @post = Post.find params[:id]
    end

    def edit
        @post = Post.find params[:id]
    end

    def update
        @post = Post.find params[:id]
        if @post.update(post_params)
            redirect_to post_path(@post), notice: 'Post atualizado com sucesso'
        else
            render :edit
        end
    end

    def destroy
        @post = Post.find params[:id]
        @post.destroy
        redirect_to posts_path, notice: 'Post excluido com sucesso'
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new post_params
        @post.user = current_user
        if @post.save
            redirect_to post_path(@post), notice: 'Post criado com sucesso'
        else
            render :new
        end
    end
    
    rescue_from ActiveRecord::RecordNotFound do
        redirect_to root_path, alert: 'Não existe esse post'
    end

    private
    
    def post_params
        params.require(:post).permit(:title, :description)
    end
end
