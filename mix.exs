defmodule Reap.Mixfile do
  use Mix.Project

  def project do
    [ app: :reap,
      version: "0.1.2-dev",
      elixir: "~> 0.10.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [{:hackney, ">= 0.4.2", github: "benoitc/hackney", ref: "05c5aa94b8fc18050d210292de09307254804b82"},
     {:jsex, ">= 0.0.1", github: "talentdeficit/jsex"}]
  end
end
