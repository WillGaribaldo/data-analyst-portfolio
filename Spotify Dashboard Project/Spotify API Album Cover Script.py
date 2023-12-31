import requests
import pandas as pd

# Load your dataset
spotify_data = pd.read_csv('spotify-2023.csv', encoding='ISO-8859-1')

def get_spotify_token(client_id, client_secret):
    # Obtain the access token from Spotify
    auth_response = requests.post('https://accounts.spotify.com/api/token', {
        'grant_type': 'client_credentials',
        'client_id': client_id,
        'client_secret': client_secret,
    })
    auth_response_data = auth_response.json()
    return auth_response_data['access_token']

def search_spotify_track(token, track_name, artist_name):
    # Make a search request to the Spotify API
    query = f"track:{track_name} artist:{artist_name}"
    response = requests.get(
        'https://api.spotify.com/v1/search',
        headers={'Authorization': f'Bearer {token}'},
        params={'q': query, 'type': 'track', 'limit': 1}
    )
    response_data = response.json()
    # Extract the album cover URL from the response
    items = response_data['tracks']['items']
    if items:
        album_cover_url = items[0]['album']['images'][0]['url']
        return album_cover_url
    return None

# Your Spotify client credentials
client_id = '4db637e886634d28a0a1b79f651f43dc'
client_secret = 'b15a7f3a864c426bab0a22349d5f2243'

# Get the Spotify access token
token = get_spotify_token(client_id, client_secret)

# Add a new column for album cover URL
spotify_data['album_cover_url'] = spotify_data.apply(
    lambda row: search_spotify_track(token, row['track_name'], row['artist(s)_name']), axis=1
)

# Save the updated dataset
spotify_data.to_csv('path_to_your_updated_spotify_dataset.csv', index=False)
