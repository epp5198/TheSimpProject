xquery version "3.1";

let $simpsons_S1 := collection("file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S1")/xml/txt
let $simpsons_S10 := collection("file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S10")/xml/txt
let $simpsons_S20 := collection("file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S20")/xml/txt
let $simpsons_S30 := collection("file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S30")/xml/txt
let $simpsonsAll := ($simpsons_S1, $simpsons_S10, $simpsons_S20, $simpsons_S30)

let $bartCounts := for $season in (1, 10, 20, 30)
                   let $count := count($simpsonsAll/mixed[ep/epTitle/fam = 'Bart' and ep/szn = $season])
                   return concat("Bart:Season", $season, ":", $count)

return distinct-values($bartCounts)







(:^^^^^^^^^^^ The Code ^^^^^^^^^^^:)
(:^^^^^^^^^^^ The  SVG ^^^^^^^^^^^:)

(:<svg width="400" height="300">
  <!-- Bar chart title -->
  <text x="180" y="40" font-size="20" font-weight="bold">Counts of Family Members by Season</text>

  <!-- Horizontal axis -->
  <line x1="50" y1="250" x2="350" y2="250" stroke="black"/>
  <line x1="50" y1="250" x2="50" y2="50" stroke="black"/>
  <text x="200" y="280" font-size="16">Season</text>
  <text x="30" y="120" font-size="16" transform="rotate(-90, 30, 120)">Count</text>
  <text x="65" y="265" font-size="14">01</text>
  <text x="165" y="265" font-size="14">10</text>
  <text x="265" y="265" font-size="14">20</text>
  <text x="365" y="265" font-size="14">30</text>

  <!-- Vertical bars -->
  <rect x="60" y="198" width="40" height="12" fill="blue"/>
  <text x="65" y="190" font-size="12" fill="black">Homer:Season01:0</text>
  <rect x="160" y="198" width="40" height="12" fill="blue"/>
  <text x="165" y="190" font-size="12" fill="black">Homer:Season10:0</text>
  <rect x="260" y="198" width="40" height="12" fill="blue"/>
  <text x="265" y="190" font-size="12" fill="black">Homer:Season20:0</text>
  <rect x="360" y="198" width="40" height="12" fill="blue"/>
  <text x="365" y="190" font-size="12" fill="black">Homer:Season30:0</text>
  </svg>:)



