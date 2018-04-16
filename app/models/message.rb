class Message < String
  def initialize *args
    replace format(template, *args)
  end

  def template
    ''
  end
end
