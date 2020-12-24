class RelationshipsController < ApplicationController
  def create
    current_user.create(params[:id])
    redirect_to request.referer
  end

  def destroy
    current_user.destroy(params[:id])
    redirect_to request.referer
  end
end
