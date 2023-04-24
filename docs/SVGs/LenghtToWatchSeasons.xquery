xquery version "3.1";

declare variable $simpsons := collection('file:///C:/github/TheSimpProject/XML(ready)/XML(textFiles)/AllSeasons/?select=*.xml');

let $runtimes := $simpsons//runtime
let $total-seconds := sum(for $runtime in $runtimes
                          let $split := tokenize($runtime, ':')
                          return xs:integer($split[1]) * 60 + xs:integer($split[2]))

let $total-minutes := xs:integer($total-seconds div 60)
let $total-hours := xs:integer($total-minutes div 60)
let $total-days := xs:integer($total-hours div 24)

return concat($total-days, ' days, ', $total-hours mod 24, ' hours, ', $total-minutes mod 60, ' minutes')















