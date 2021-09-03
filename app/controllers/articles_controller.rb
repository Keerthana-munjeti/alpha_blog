class ArticlesController < ApplicationController
    before_action:set_article , only: [:show, :edit, :update, :destroy]
    before_action:require_user, except: [:index, :show]
    before_action:require_same_user, except: [:index, :show, :new, :create]
    def show
       # @article=Article.find(params[:id])
    end

    def index
        @articles=Article.all
    end

    def new
        @article=Article.new
    end

    def edit
       # @article=Article.find(params[:id])
        

    end

    def set_article
        begin
           @article=Article.find(params[:id])
        rescue 
            render plain: "article  with given id not found"
        end
    end

    def destroy
       # @article=Article.find(params[:id])
        if @article.destroy
            flash[:notice] = "The article is deleted successfully"
            redirect_to articles_path
        end
    end

    # def update
     #   @article=Article.find(params[:id])
     #  if  @article.update(params.require(:article).permit(:title,:description))
           
      #      flash[:notice]= "The article is updated successfully"
       #     redirect_to (@article)

        #else
         #  render 'edit'
        
       # end
    #end

    def update
      #  @article = Article.find(params[:id])
       if @article.update(title: params[:article][:title], description: params[:article][:description])
          flash[:notice]= "The article is updated successfully"
           redirect_to article_path(@article)
       else
         render "edit"
      end
    end
      


    def create
        @article=Article.new(params.require(:article).permit(:title,:description))
        @article.user= current_user
        if @article.save
        redirect_to (@article)
        flash[:notice]= "The article is created successfully"

        else
        render 'new'
        end
    end

    private

    def require_same_user
        if  current_user != @article.user
            flash[:error] = "you are not allowed to change others details"
            redirect_to @article
        end
end
end
