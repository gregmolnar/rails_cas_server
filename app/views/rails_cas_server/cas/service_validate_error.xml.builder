xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.tag!("cas:serviceResponse", 'xmlns:cas' => "http://www.yale.edu/tp/cas") do
  xml.tag!("cas:authenticationFailure", {:code => 'BAD_PGT'}, 'Invalid ticket')
end