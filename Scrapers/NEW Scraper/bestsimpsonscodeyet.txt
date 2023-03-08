import requests
from bs4 import BeautifulSoup

# URL of the main page with links to each episode
main_url = 'https://transcripts.foreverdreaming.org/viewforum.php?f=431&sid=0695f7b460b8f09045f42e8fc4ea2456&start=702'

# Send a request to the main page and get the HTML response
main_response = requests.get(main_url)

# Parse the HTML content of the main page using BeautifulSoup
main_soup = BeautifulSoup(main_response.content, 'html.parser')

# Find all the links to each episode page on the main page
episode_links = main_soup.select('#wrap > div:nth-child(8) > div > ul > li > dl > dt > div > a.topictitle')

# Loop through each episode link and scrape the transcript text
for link in episode_links:
    try:
        # Get the URL of the episode page
        episode_url = 'https://transcripts.foreverdreaming.org/' + link['href']

        # Send a request to the episode page and get the HTML response
        episode_response = requests.get(episode_url)

        # Parse the HTML content of the episode page using BeautifulSoup
        episode_soup = BeautifulSoup(episode_response.content, 'html.parser')

        # Find the Div Container that contains the transcript text
        transcript_div = episode_soup.find('div', {'class': 'postbody'})

        # Get the text of the transcript
        transcript_text = transcript_div.get_text()

        # Get the season and episode number from the link text
        link_text = link.get_text()
        if link_text.startswith('01x'):
            season_number = '1'
            episode_number = link_text.split('-')[0][-2:]
        else:
            season_number = link_text.split('x')[0]
            episode_number = link_text.split('x')[1]

        # Create a filename for the transcript
        filename = f'Season {season_number} Episode {episode_number}.txt'

        # Write the transcript text to a file
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(transcript_text)

        print(f'{filename} saved successfully!')
    except Exception as e:
        print(f"Error occurred for episode {link_text}: {e}")
        continue

print('Done processing all episodes.')


