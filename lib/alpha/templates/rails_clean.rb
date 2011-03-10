run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm README'
run 'rm public/favicon.ico'

create_file 'README.md' do
<<-FILE
#{app_name.humanize}
===========
FILE
end

