defmodule Tucano.Validations do
  def get_regex_of(:email) do
    ~r/@/
  end

  def get_regex_of(:registro) do
    ~r/(\d{2}[\.]?\d{3}[\.]?\d{3}[\/]?\d{4}[-]?\d{2})|(\d{3}[\.]?\d{3}[\.]?\d{3}[-]?\d{2})/
  end

  def get_regex_of(:telefone) do
    ~r/^([\(]?\d{2}[\)]?[\d]?\d{4}[-]?\d{4})$/
  end
end
