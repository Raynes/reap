# Reap

Reap is a simple Elixir library for working with the
[refheap](https://www.refheap.com) API. It uses the excellent
[hackney](https://github.com/benoitc/hackney) HTTP client and
[JSEX](https://github.com/talentdeficit/jsex) JSON encoder/decoder.

## Usage

Reap only has one function you should care about: `request/2`, `request/3`.
Here's some examples:

```elixir
iex(1)> Reap.start
:ok
iex(2)> Reap.request(:post, "/paste", [contents: "foo"])
{:ok,
 [{"lines", 1}, {"date", "2013-08-01T04:42:44.155Z"}, {"paste-id", "17091"},
  {"fork", nil}, {"random-id", "6249eaf9c9c8186230243bb46"},
  {"language", "Plain Text"}, {"private", false}, {"views", 0},
  {"url", "https://www.refheap.com/17091"}, {"user", nil}, {"contents", "foo"}]}
iex(3)> Reap.request(:get, "/paste/17091")
{:ok,
 [{"lines", 1}, {"date", "2013-08-01T04:42:44.155Z"}, {"paste-id", "17091"},
  {"fork", nil}, {"random-id", "6249eaf9c9c8186230243bb46"},
  {"language", "Plain Text"}, {"private", false}, {"views", 0},
  {"url", "https://www.refheap.com/17091"}, {"user", nil}, {"contents", "foo"}]}
```

As you can see, if the request and json decode is successful we get back `{:ok,
body}`. Let's see what happens if things go wrong:

```elixir
iex(11)> Reap.request(:post, "/paste")
{:error, :refheap, [{"error", "Your paste cannot be empty."}]}
```

In this case, something went wrong on refheap and it gave us back an error. The
second element of the tuple is the type of the error, and it can be `:refheap`
if something bad happens on refheap, `:json` if JSON parsing of the body fails
for some reason, or `:http` if we fail to make an http request at all. In the
latter two cases, the entire hackney response gets returned as the third element
of the tuple.
