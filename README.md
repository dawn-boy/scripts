# timestamper.sh:
This script changes the date of creation of the given files.
- It expects a video, audio, and a meta folder to begin with.
- The meta folder should contain .json files with the corresponding names of the video and audio files.
- the .json file should have a key called "photoTakenTime" and an inner key called "formatted" with a value like "Oct 21, 2023, 2:06:18 AM UTC"

- This timestamper.sh script is crafted accordingly to work with the media exported using Google Takeout from Google Photos
