class ConfirmationCodeService
  def self.create
    output = ""
    6.times { output += rand(10).to_s }
    output
  end
end
