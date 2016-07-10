require 'rubygems'
require 'HTTParty'
require 'multi_xml'
require 'multi_json'
# require 'rest-client'
# require 'json'
# require 'net/http'
# require 'pp'
# require 'oauth2'
# require 'net/http'
# require 'uri'

class Client
    include HTTParty

  	debug_output $stdout
    base_uri "https://www.evisitor.hr/testApi/Resources/AspNetFormsAuth/Authentication/Login"

    basic_auth "0033643", "Komodor1"


    def home_page
        self.class.get "/"
    end

    def login
    	# @login_uri = "https://www.evisitor.hr/eVisitorRhetos_API/Resources/AspNetFormsAuth/Authentication/"
        @login_uri = "https://www.evisitor.hr/testApi/Resources/AspNetFormsAuth/Authentication/Login"
    	# auth2 = { 'Username' => "80048002604.ts7", 'Password' => "Sandyk777", 'PersistCookie' => 'false'}
        service_url = "https://www.evisitor.hr/testApi"
        auth = { 'UserName' => "0033643", 'Password' => "Komodor1", 'PersistCookie' => 'false' }
        response0 = HTTParty.get(@login_uri, query: { "set-cookie" => "set-cookie"})
        cookie = response0.headers["set-cookie"]
        options = { basic_auth: auth, 
                use_ssl: true, 
                verify_peer: false, 
                headers: { "Content-Type" => "application/json; charset=utf-8",
                    "LoginParameters" => auth, 
                    "set-cookie" => cookie  } }
        headers2 = { "Content-Type" => "application/json; charset=utf-8", "set-cookie" => cookie }
        query = { "Method" => "Login" , "LoginParameters" => auth }
        response = HTTParty.post(@login_uri, query: auth,  options: options)
		puts response.body
		puts response.code
		# puts response.headers.inspect
        puts '---------------------'
        puts cookie
    end

end

c = Client.new
puts c.login
