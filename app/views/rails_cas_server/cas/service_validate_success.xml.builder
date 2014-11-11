xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.tag!("cas:serviceResponse", 'xmlns:cas' => "http://www.yale.edu/tp/cas") do
  xml.tag!("cas:authenticationSuccess") do
    xml.tag!("cas:user", @ticket.username)
  end
end
