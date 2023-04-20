let $season1 := collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S30/?select=*.xml')
let $count := 0
for $file in $season1
    let $phrase-count := count($file//catchphrase[contains(normalize-space(), "why you little")])
    let $count := $count + $phrase-count
return $count












(:let $seasons := (
    collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S1/?select=*.xml'),
    collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S10/?select=*.xml'),
    collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S20/?select=*.xml'),
    collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S30/?select=*.xml')
)
for $season in $seasons
return
    <result season="{$season/@season}">
        <count>{count($season//catchphrase[contains(normalize-space() ! lower-case(.), "why you little")])}</count>
    </result>:)




(:
xquery version "3.1";

declare variable $xSpacer := 5;
declare variable $ySpacer := 20;
declare variable $colors := ("red", "green", "blue", "orange", "black", "purple", "aqua");

declare variable $simpsons_S1 := collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S1/?select=*.xml');
declare variable $simpsons_S10 := collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S10/?select=*.xml');
declare variable $simpsons_S20 := collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S20/?select=*.xml');
declare variable $simpsons_S30 := collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/Simpsons_S30/?select=*.xml');
declare variable $simpsonsAll := ($simpsons_S1, $simpsons_S10, $simpsons_S20, $simpsons_S30);

declare variable $allCatches := $simpsonsAll//catchphrase[contains(normalize-space() ! lower-case(.), "why you little")] => distinct-values();
declare variable $distCatches := $simpsonsAll//catchphrase ! normalize-space() ! lower-case(.) ! replace(., "'", '') => distinct-values();

<svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
    <g transform="translate(50, 20)">

    {for $d at $pos in $allCatches 
let $countThisCatch := $simpsonsAll//Q{}catchphrase[contains(normalize-space() ! lower-case(.), "why you little") and normalize-space() ! lower-case(.) = $d] => count()

return 
    <g id="{$d}">
        
        <line x1 = '{0}' y1 ='{$pos * $ySpacer}'  x2= '{$xSpacer * $countThisCatch}' y2="{$pos * $ySpacer}" stroke='{$colors[position() = $pos]}' stroke-width='5'/>
        
    
    </g>
}

</g>
</svg>:)