## Song Popularity through ML Models

#### Introduction
The team worked to find the underlying formula behind what goes into making a “popular song” song. Answering the age-old questions about what factors make meaningful contributions to the rankings of the overall song compared to others. We want to look at what aspects music producers should get used to using in the future. The data set that we chose was from Kaggle, which is an online platform where users can find datasets and practice their data analysis skills. The dimensions of the data set are 232625 rows by 18 columns. The attributes of the data set are genre, artist name, track name, track id, popularity, acousticness, danceability, duration in milliseconds, energy, instrumentalism, key, liveness, loudness, mode, speechiness, tempo, time signature, and valence. After feature engineering, the data set consisted of 21 columns. 

#### Feature Engineering
  - Mode: Given as Major, Minor transformed into 0,1
  - Time Signature: Given as 1/4, 2/4, 3/4, 4/4, and 5/4, converted to only be the top number
  - Key: All 12 keys exist on a loop called the circle of fifths, transformed each key by positioning them equally around a circle and assigning each the value of θ =((i) π)/6 for all i ϵ {0...11} based on location.

Here is a link to the final presentation: [Song Popularity Presentation](https://1drv.ms/p/s!Alxwy6tfpIPZg7ZKrDW9046dZ6B_3Q?e=Qrf1lY)
