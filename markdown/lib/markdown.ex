defmodule Markdown do
  @italic {"_", "em"}
  @bold {"__", "strong"}
  @unordered_list {"", "ul"}

  @italic_pattern ~r/(?<=_)(.*)(?=_)/
  @bold_pattern ~r/(?<=__)(.*)(?=__)/
  @unordered_list_pattern ~r/\<li\>(.*)\<\/li\>/

  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(text) do
    text
    |> String.split("\n")
    |> Enum.map(&parse_paragraphs/1)
    |> Enum.map(&parse_bolds/1)
    |> Enum.map(&parse_italics/1)
    |> Enum.map(&parse_headers/1)
    |> Enum.map(&parse_unordered_list_items/1)
    |> Enum.join("")
    |> enclose_unordered_lists()
  end

  defp parse_paragraphs(<<first, _any::binary>> = text) when first in '#*', do: do_nothing(text)
  defp parse_paragraphs(text), do: "<p>#{text}</p>"

  defp parse_italics(text), do: to_html(text, @italic, @italic_pattern)
  defp parse_bolds(text), do: to_html(text, @bold, @bold_pattern)
  defp enclose_unordered_lists(text), do: to_html(text, @unordered_list, @unordered_list_pattern)

  defp to_html(text, {markdown, tag}, regex_pattern) do
    html = Regex.replace(regex_pattern, text, fn value, _ -> "<#{tag}>#{value}</#{tag}>" end)
    String.replace(html, markdown, "")
  end

  defp parse_headers("###### " <> text), do: "<h6>#{text}</h6>"
  defp parse_headers("##### " <> text), do: "<h5>#{text}</h5>"
  defp parse_headers("#### " <> text), do: "<h4>#{text}</h4>"
  defp parse_headers("### " <> text), do: "<h3>#{text}</h3>"
  defp parse_headers("## " <> text), do: "<h2>#{text}</h2>"
  defp parse_headers("# " <> text), do: "<h1>#{text}</h1>"
  defp parse_headers(not_a_header), do: do_nothing(not_a_header)

  defp parse_unordered_list_items(<<"* ", text::binary>>), do: "<li>#{text}</li>"
  defp parse_unordered_list_items(not_a_list), do: do_nothing(not_a_list)

  defp do_nothing(text), do: text
end
