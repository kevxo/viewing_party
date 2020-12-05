class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:email])
    if friend
      unless friend.id == current_user.id || current_user.friends.include?(friend)
        Friendship.create(user_id: current_user.id, friend_id: friend.id)
        redirect_to '/dashboard'
      else
        flash[:error] = "You can't be your own friend" if friend.id == current_user.id
        flash[:error] = "Already friends with that user" if current_user.friends.include?(friend)
        redirect_to '/dashboard'
      end
    else
      flash[:error] = "Friend could not be found"
      redirect_to '/dashboard'
    end
  end
end
