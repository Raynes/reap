defmodule Reap.Mixfile do
  use Mix.Project

  def project do
    [app: :reap,
     version: "0.1.3",
     deps: deps,
     author: "Anthony Grimes",
     package: [contributors: [],
               licenses: ["MIT"],
               links: %{"github" => "https://github.com/Raynes/reap"}],
     description: "A library for working with the refheap API",]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [{:hackney, ">= 0.4.2", github: "benoitc/hackney", ref: "05c5aa94b8fc18050d210292de09307254804b82"},
     {:jsex, ">= 2.0.0"}]
  end
end
