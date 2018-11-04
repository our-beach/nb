class ChangeExpirationTimeToIntegerOnAuthorizationTokens < ActiveRecord::Migration[5.1]
  def change
    remove_column :authorization_tokens, :expiration_time, :time
    add_column :authorization_tokens, :expiration_time, :integer
  end
end
