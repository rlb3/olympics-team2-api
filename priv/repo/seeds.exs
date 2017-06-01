# ["Sport", "Event", "Gold", "Silver", "Bronze", "Gold Country",
#  "Gold Winner", "Silver Country", "Silver Winner", "Bronze Country",
#  "Bronze Winner"]

defmodule NameParser do
  def parse(names) do
    case Regex.scan(~r/[A-Z]+\s[A-Z]\S+/, String.trim(names)) do
      [first, second, third] -> [first, second, third] |> Enum.join(", ")
      [first, last] -> [first, last] |> Enum.join(", ")
      [first] -> first |> Enum.join(", ")
      [] -> names
    end
  end
end

defmodule CountryABV do
  @codes File.stream!("country_codes.csv") |> CSV.decode! |> Enum.into([])

  def find(abv) do
    country_name= for [name, _, ^abv | _] <- @codes, do: name || [""]
    case country_name do
      [name] -> name
      [] -> ""
    end
  end
end

API.Repo.delete_all API.Medal
API.Repo.delete_all API.TopNews

csv_data = File.stream!("2016-summer-olympic-medals.csv") |> CSV.decode! |> Enum.into([])

for [sport, event, gold_count, silver_count, bronze_count, gold_country, gold_winner, silver_country, silver_winner, bronze_country, bronze_winner] <- csv_data do
    API.Repo.insert %API.Medal{sport: sport, event: event, gold: String.to_integer(gold_count), silver: String.to_integer(silver_count), bronze: String.to_integer(bronze_count), gold_country: CountryABV.find(gold_country), silver_country: CountryABV.find(silver_country), bronze_country: CountryABV.find(bronze_country), gold_winner: NameParser.parse(gold_winner), silver_winner: NameParser.parse(silver_winner), bronze_winner: NameParser.parse(bronze_winner)}
end

image_string = File.read!("image_files.txt")
images = String.split(image_string, "\n")
images_count = images |> Enum.count


1..25 |> Enum.each(fn _ ->
  API.Repo.insert %API.TopNews{body: Elixilorem.paragraph,
                               title: Elixilorem.sentence,
                               date: Timex.shift(Date.utc_today, days: :random.uniform(10) * -1),
                               photo_url: "/images/#{Enum.at(images, :random.uniform(images_count))}"}
end)
