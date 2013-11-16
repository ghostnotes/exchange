# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Exchange::Application.config.secret_key_base = 'acf199a84f5f644d131abe3b37b1714636f76829b2037f79eb6a6f151d45f7721bffea869ee10c3a1d140c4cb305146f081ff81f520d88d79e6808b46d68276b'
