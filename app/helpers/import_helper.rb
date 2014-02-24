module ImportHelper


  def find_number_of_bedrooms(ad)

    @name
    ad.xpath('unitinfo/*').each do |i|

      if i.name() =~ /propertybedrooms\d\d?/
        @name = i.name()
        break
      end
    end

    @name = @name[16..-1].to_i

    #returns num_bedrooms
    @name = @name > 9 ? @name / 10.0 : @name

  end

  def find_number_of_bathrooms(ad)

    @name
    ad.xpath('unitinfo/*').each do |i|

      if i.name() =~ /propertybathrooms\d\d?/
        @name = i.name()
        break
      end
    end

    @name = @name[17..-1].to_i

    #returns num_bedrooms
    @name = @name > 9 ? @name / 10.0 : @name

  end


  #i found something called find_or_create_by
  #(http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-find_or_create_by)
  #although this shouldn't be used in this case due to the unique passwords/company name/phone number
  def find_or_create_user(username, company, phone)

    #find the user (if not, create)
    @user = nil
    if username.empty?
      false #if there's no username, don't create.
    else
      #add on dummy email @
      username << '@appfolio.com'

      #find the user
      @user = User.where(email: username).take
      if @user.nil?
        @user = User.new(:email => username,
                         :password => 'appfolio_dummy',
                         :password_confirmation => 'appfolio_dummy',
                         :company_name => company,
                         :phone_number => phone
        )
        @user.save

      end

      @user

    end

  end
end