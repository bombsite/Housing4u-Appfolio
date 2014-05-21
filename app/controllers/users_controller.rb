class UsersController < ApplicationController
  def show
    @user = current_user
    @i = 0
    @max = 0
  end

  def matching
    @user = current_user
    @i = 0
    @max = 0
    end

  def roommates
    @user = current_user
    @array = Array.new(20)
    @i = 0
    if @user.survey_completed
      User.all.each do |u|
        if u.email != @user.email
          if u.survey_completed == TRUE
            @i = 0
            if u.gender == @user.gender
              @i += 1
            end
            if u.language_spoken == @user.language_spoken
              @i += 1
            end
            if u.smoker == @user.smoker || @user.smoker_accepted == "Dont Care"
               @i += 1
            end
            if u.pets == @user.pets || @user.pets_accepted == "Dont Care"
               @i += 1
            end
            if u.bed_before_11pm == @user.bed_before_11pm || @user.bed_before_11pm_accepted == "Dont Care"
               @i += 1
            end
            if u.wake_before_9am == @user.wake_before_9am || @user.wake_before_9am_accepted == "Dont Care"
               @i += 1
            end
            if u.music_often == @user.music_often || @user.music_often_accepted == "Dont Care"
               @i += 1
            end
            if u.visitors_often == @user.visitors_often || @user.visitors_often_accepted == "Dont Care"
               @i += 1
            end
            if u.social == @user.social || @user.social_accepted == "Dont Care"
              @i += 1
            end
            if @array[0].nil? || @i > @array[0]
              for k in 19..4
                @array[k] = @array[k-4]
              end
              @array[3] = u.email
              @array[2] = u.id
              @array[1] = u.fb_photo_url
              @array[0] = @i
            elsif @array[4].nil? || @i > @array[4]
              for k in 19..8
                @array[k] = @array[k-4]
              end
              @array[7] = u.email
              @array[6] = u.id
              @array[5] = u.fb_photo_url
              @array[4] = @i
            elsif @array[8].nil? || @i > @array[8]
              for k in 19..12
                @array[k] = @array[k-4]
              end
              @array[11] = u.email
              @array[10] = u.id
              @array[9] = u.fb_photo_url
              @array[8] = @i
            elsif @array[12].nil? || @i > @array[12]
              for k in 19..16
                @array[k] = @array[k-4]
              end
              @array[15] = u.email
              @array[14] = u.id
              @array[13] = u.fb_photo_url
              @array[12] = @i
            elsif @array[16].nil? || @i > @array[16]
              @array[16] = @i
              @array[17] = u.fb_photo_url
              @array[18] = u.id
              @array[19] = u.email
            end
          end
        end
      end
    end
  end

  def viewuser
      @user = User.find(params[:id])
  end
end