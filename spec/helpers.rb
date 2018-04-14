%w(
  api_params
).each do |fn|
  require File.join(File.dirname(File.absolute_path __FILE__), 'helpers', fn)
end
