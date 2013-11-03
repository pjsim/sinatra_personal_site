require 'bundler'
Bundler.require

### configuration & settings ###
configure do
	set :name, ENV['NAME'] || 'Phillip Simmonds'
	set :author, ENV['AUTHOR'] || 'Phillip Simmonds'
	#set :analytics, ENV['ANALYTICS'] || 'XXX'
	set :javascripts, %w[ ]
	set :styles, %w[ main ]
	set :fonts, %w[ Abel ]
	#set :markdown, :layout_engine => :slim
	#disable :protection
end 

helpers do
  def javascripts
    javascripts = ""
    (@javascripts?([@javascripts].flatten+settings.javascripts):settings.javascripts).uniq.each do |script|
      javascripts << "<script src=\"#{script}\"></script>"
    end
    javascripts
  end
  def styles
    styles = ""
    (@styles?([@styles].flatten+settings.styles):settings.styles).uniq.each do |style|
      styles << "<link href=\"/#{style}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    end
    styles
  end
  def webfonts
    "<link href=\"http://fonts.googleapis.com/css?family=#{(@fonts?settings.fonts+@fonts:settings.fonts).uniq.*'|'}\" rel=\"stylesheet\" />"
  end
 
end

### Routes ###
not_found { slim :'404' }
error { slim :'500' }
get('/main.css') { scss :styles }
#get('/application.js') { coffee :script }

### home page ###
get '/' do
	@title = "Phillip Simmonds's Personal Site"
	slim :index	
end

get '/:page' do
  if File.exists?('views/'+params[:page]+'.slim')
    slim params[:page].to_sym
  elsif File.exists?('views/'+params[:page]+'.md')
    markdown params[:page].to_sym
  else
    raise error(404) 
  end   
end

__END__
### views ###

@@index
h1 title='Hey hows it going?' HEY!!!
p Welcome to my website!
p My name is phil..
p Thanks!

@@404
h1 404! 
p That page is missing

@@500
h1 500 Error! 
p Oops, something has gone terribly wrong!

