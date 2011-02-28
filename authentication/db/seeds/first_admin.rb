administrator = Administrator.create( :username => 'admin',
                                      :email => 'admin@example.com',
                                      :password => 'password',
                                      :password_confirmation => 'password' )
administrator.confirm! if Administrator.confirmable?
administrator.add_role(:refinery)
administrator.add_role(:superuser)

