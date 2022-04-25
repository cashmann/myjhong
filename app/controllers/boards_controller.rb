class BoardsController < ApplicationController
  def index
    @tileset = Tileset.new
  end
end
