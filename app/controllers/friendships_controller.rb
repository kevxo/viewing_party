class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:email])
    if friend
      if friend.id == current_user.id || current_user.friends.include?(friend)
        flash[:error] = "You can't be your own friend" if friend.id == current_user.id
        flash[:error] = 'Already friends with that user' if current_user.friends.include?(friend)
      else
        Friendship.create(user_id: current_user.id, friend_id: friend.id)
      end
    else
      flash[:error] = 'Friend could not be found'
    end
    redirect_to '/dashboard'
  end
end
