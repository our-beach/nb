class AuthorizationRequestToken < String
  def initialize
    replace Array.new(6) { rand(10) }.join
  end
end
