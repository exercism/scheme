grep --color 'href=\"/tracks' closet/tracks.html | awk -F '(=| |>|<|"|/)' '{print $11}' > closet/tracks.txt
