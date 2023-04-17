xquery version "3.1";
let $xml := collection('/../XML(textfiles)/Simpsons_S1/')
return $xml

(:let $songs := $disney//song
for $song in $songs
let $song_length := string-length($song)
let $song_title := $song/metadata/title
return concat("Song '", $song_title, "' length: ", $song_length, "&#xa;"):)