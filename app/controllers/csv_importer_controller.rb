class CsvImporterController < ApplicationController

  def new
    @article = Article.new
  end

  def import


    CSV.foreach(params[:file].path, headers: true) do |row|
      puts '------------------------------'

      puts row.to_hash
      puts '------------------------------'
      @article=Article.new(row.to_hash)
      @article.user = current_user
      if @article.save
        flash[:success] = "Articles were successfully added"
        #redirect_to articles_path
      else
        flash[:danger] = "An error occurent while importing the csv file"
      end
    end


      render 'new'
    end


end

