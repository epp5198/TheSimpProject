# Simpsons Scraper

It's *pretty* straightforward to use. It will grab all of the episodes but It has to be done per webpage.

1. Go to this site [Simpsons_Transcripts](https://transcripts.foreverdreaming.org/viewforum.php?f=431)
2. Find whatever seasons you're looking for and go to that page using the **page numbers** on the site.
3. Open the **simpsonsscraper.py** and paste the link from the page you want to capture episodes from.

> Example

`import requests
from bs4 import BeautifulSoup

# URL of the main page with links to each episode
main_url = '**INSERT PAGE LINK HERE**'

# Send a request to the main page and get the HTML response
main_response = requests.get(main_url)

# Parse the HTML content of the main page using BeautifulSoup
main_soup = BeautifulSoup(main_response.content, 'html.parser')

# Find all the links to each episode page on the main page
episode_links = main_soup.select('#wrap > div:nth-child(8) > div > ul > li > dl > dt > div > a.topictitle')`


It should save the text files with *minimal* cleanup. **Happy Scraping!**