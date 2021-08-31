class ArticlesController < ApplicationController
    before_action:set_article , only: [:show, :edit, :update, :destroy]
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
        @article=Article.find(params[:id])
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
        if @article.save
        redirect_to (@article)
        flash[:notice]= "The article is created successfully"

        else
        render 'new'
        end
    end
end
