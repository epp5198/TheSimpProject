
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
        <!-- x-axis bar -->
        <line x1="0" y1="{count($distCatches) * $ySpacer}" x2="{max(for $c in $allCatches return count($simpsonsAll//Q{}fam[. = $c])) * $xSpacer}" y2="{count($distCatches) * $ySpacer}" stroke="black" stroke-width="5"/>
        <!-- y-axis bar -->
        <line x1="0" y1="0" x2="0" y2="{count($distCatches) * $ySpacer}" stroke="black" stroke-width="5"/>
        {
            for $d at $pos in $distCatches
            let $matchingCatch := $allCatches[normalize-space() ! lower-case(.) ! replace(., "'", '') = $d]
            let $countThisCatch := sum(for $c in $matchingCatch return count($simpsonsAll//Q{}fam[. = $c]))
            return
            <g id="{$d}">
                <line x1="0" y1="{$pos * $ySpacer}" x2="{$countThisCatch * $xSpacer}" y2="{$pos * $ySpacer}" stroke="{$colors[position() = $pos]}" stroke-width="5"/>
                <text x="-10" y="{$pos * $ySpacer + 5}" class="legend-label" text-anchor="end">{upper-case($d)}</text>
                <text x="{$countThisCatch * $xSpacer + 5}" y="{$pos * $ySpacer + 5}" class="legend-value">{ $countThisCatch }</text>
            </g>
        }
    </g>
</svg>









