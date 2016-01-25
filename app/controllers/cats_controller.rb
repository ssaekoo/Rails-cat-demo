class CatsController < ApplicationController
  def index
    self.render json: Cat.all
  end

  def show
    self.render json: Cat.find(self.params[:id])
  end

  def create
    cat = Cat.new(name: params[:cat][:name])

    if cat.save
      render json: cat
    else
      render json: cat.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update

  end

  def destroy

  end

end
