defmodule Crypt do

  def en(plaintext) do
    iv    = :crypto.strong_rand_bytes(16)
    key = List.duplicate(100, 16)
    state = :crypto.stream_init(:aes_ctr, key, iv)

    {_state, ciphertext} = :crypto.stream_encrypt(state, to_string(plaintext))
    iv <> ciphertext
  end

  def de(ciphertext) do
    key = List.duplicate(100, 16)
    <<iv::binary-16, ciphertext::binary>> = ciphertext
    state = :crypto.stream_init(:aes_ctr, key, iv)

    {_state, plaintext} = :crypto.stream_decrypt(state, ciphertext)
    plaintext
  end

end
