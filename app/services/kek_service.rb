class KekService
  def self.call
    Figaro.env.kek.freeze
  end
end
