class PostsController < ApplicationController
    before_action :authenticate_user!

    def new
        @userName = current_user.name
        @userId = current_user.id
    end

    def create
        post = Post.new(year:params[:year], month:params[:month], date:params[:date], place:params[:place], name:params[:name], desc:params[:desc], user_id:current_user.id)
        post.save
        redirect_to index_path
    end

    def edit
        @post = Post.find_by(id: params[:id])
        @month = @post.month
        @date = @post.date
    end

    def update
        @post = Post.find_by(id: params[:id])
        @post.place = params[:place]
        @post.name = params[:name]
        @post.desc = params[:desc]
        @post.save
        redirect_to index_path
    end

    def destroy
        post = Post.find_by(id: params[:id])
        post.destroy
        redirect_to index_path
    end

    def show
        @post = Post.find(params[:id])
        @month = @post.month
        @date = @post.date
        @place = @post.place
        @name = @post.name
        @desc = @post.desc
        @userId = @post.user_id
    end
end