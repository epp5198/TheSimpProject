xquery version "3.1";

declare variable $ySpacer := -.5;
(: ebb If you make this a decimal it'll help with the spacing! 
Flpping the graph to go up the screen, make the $ySpacer negative so we plot up from 0,0:)
declare variable $xSpacer := 20;
declare variable $colors := ("red", "green", "blue", "orange", "black", "purple", "aqua");

declare variable $simpsons_S1 := collection('../XML(ready)/XML(textFiles)/Simpsons_S1/?select=*.xml');
declare variable $simpsons_S10 := collection('../XML(ready)/XML(textFiles)/Simpsons_S10/?select=*.xml');
declare variable $simpsons_S20 := collection('../XML(ready)/XML(textFiles)/Simpsons_S20/?select=*.xml');
declare variable $simpsons_S30 := collection('../XML(ready)/XML(textFiles)/Simpsons_S30/?select=*.xml');
declare variable $simpsonsAll := ($simpsons_S1, $simpsons_S10, $simpsons_S20, $simpsons_S30);

declare variable $allCatches := $simpsonsAll//fam => distinct-values();
declare variable $distCatches := $simpsonsAll//fam ! normalize-space() ! lower-case(.) ! replace(., "'", '') => distinct-values();
(:ebb  You could plot this as percentages since the counts are so big! Get a count of all the catches to use for division in the for loop
below. Or run with a decimal value for the $xSpacer! :)

(: ebb: With your plot spacer set to .5, the largest value is in the 500s. So the graph needs to scale to around 700 or 800.
Let's make the plot flip around to plot bars going up the screen. 
:)

<svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
    <g transform="translate(50, 800)">
    <!-- For plotting up the screen, set y below the max y value, and reset 0,0 down there. 
    Plot backwards with negative vals. (Make $ySpacer negative to help.) -->
    {
        for $d at $pos in $distCatches
        let $matchingCatch := $allCatches[normalize-space() ! lower-case(.) ! replace(., "'", '') = $d]
        let $countThisCatch := sum(for $c in $matchingCatch return count($simpsonsAll//Q{}fam[. = $c]))
        return
        <g id="{$d}">
            <line y1 = '{0}' x1 ='{$pos * $xSpacer}'  y2= '{$ySpacer * $countThisCatch}' x2="{$pos * $xSpacer}" stroke='{$colors[position() = $pos]}' stroke-width='5'/>
        </g>
    }
    </g>
</svg>








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

declare variable $allCatches := $simpsonsAll//fam => distinct-values();
declare variable $distCatches := $simpsonsAll//fam ! normalize-space() ! lower-case(.) ! replace(., "'", '') => distinct-values();

<svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
    <g transform="translate(50, 20)">
    {for $d at $pos in $distCatches 
    let $countThisCatch := $simpsonsAll//Q{}fam[normalize-space() ! lower-case(.) ! replace(., "'", '') = $d] => count()
return 
    <g id="{$d}">
        
        <line x1 = '{0}' y1 ='{$pos * $ySpacer}'  x2= '{$xSpacer * $countThisCatch}' y2="{$pos * $ySpacer}" stroke='{$colors[position() = $pos]}' stroke-width='5'/>
        
    
    </g>
}

</g>
</svg>:)

