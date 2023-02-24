import requests
from bs4 import BeautifulSoup
import os
import re

url = 'https://subslikescript.com/series/The_Simpsons-96697'

# Make request
response = requests.get(url)

# Parse content
soup = BeautifulSoup(response.content, 'html.parser')

# Find all season containers
season_containers = soup.select('div.season, div.season.wide')
if not season_containers:
    print('Could not find seasons')
    exit()

# Ask user to enter season number
season_number = input('Enter the season number you want to download: ')

# Loop through season containers to find selected season
for season_container in season_containers:
    # Get season number
    current_season_number = re.search(r'Season (\d+)', season_container.find('h4').text.strip()).group(1)

    # If the current season number matches the selected season number, download episodes for that season
    if current_season_number == season_number:
        # Create directory for season
        season_dir = os.path.join('Simpsons', f'Season {season_number}')
        if not os.path.exists(season_dir):
            os.makedirs(season_dir)

        # Get all episode links for the season
        episode_links = season_container.find_all('a', href=True)

        # Loop through episode links
        for episode_link in episode_links:
            # Get episode title
            episode_title = episode_link.text.strip()

            # Create file name
            file_name = re.sub(r'\W+', '', episode_title) + '.txt'

            # Make request to episode page
            episode_url = f"https://subslikescript.com{episode_link['href']}"
            episode_response = requests.get(episode_url)
            episode_soup = BeautifulSoup(episode_response.content, 'html.parser')

            # Find script container and extract script
            script_container = episode_soup.find('div', class_='full-script')
            if not script_container:
                print(f"No script found for {episode_title}")
                continue

            script_text = script_container.text.strip()

            # Write script to file
            file_path = os.path.join(season_dir, file_name)
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(script_text)

        # Exit loop once episodes for selected season have been downloaded
        break

if not os.path.exists(season_dir):
    print(f"Season {season_number} not found")
else:
    print(f"Done downloading scripts for Season {season_number}")
