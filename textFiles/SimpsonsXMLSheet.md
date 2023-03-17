# Simpsons XML Markup
 I will be showing how to mark up each season of 1,10,20,and 30 ** Some are different

* XML Tags we will be using *

- `ep` = episode
- `epTitle` - episode Title
- `szn` - season
- `epNum` - episode number
- `txt` - this covers the entire episode (we already used episode previously)
- `xml` - needed
- `fam` - used to mark the family
- `stage` - marks various stage notes
- `sp` - each line of the episode

======================================================

1. Replacing the basics = Removing the amp and alligator marks
```

- Change `&` to `&amp;`
- Then change `<` to `&lt;` and `>` to `&gt;`


```
1. Cleanup of Top junk
```

These will all require Dot Matches All = OFF
`\n\n\n` Dot Matches All = OFF

`\nby bunniefuu .*$` Dot Matches All = OFF

`\nPost` Dot Matches All = OFF

`\nQuote` Dot Matches All = OFF

REPLACE all with Nothing


```



1. Episode Section = Season, Title, ...
```

- Find `(\d\d)x(\d\d) - (.*)` and Replace with `<ep><epTitle>\3</epTitle><szn>\1</szn>x<epNum>\2</epNum></ep>` ** Dot Matches All = OFF **

```

** This part changes from each season **

1. Stage tag for Seasons 10 and 30
```

- Find `\[(.*?)\]` and Replace with `<stage>\1</stage>`

```

1. Stage tag for Season 20
```

- Find `\((.*?)\)` and Replace with `<stage>\1</stage>`

```

1. Stage tag for Season 1 
```

- Find `([A-Z ]+):\s` and Replace with `<stage>\1</stage>`

```

1. Capturing the main family
```

- Find `\b(Homer|Lisa|Bart|Grampa|Marge)\b` and Replace with `<fam>\0</fam>` 
* We do this because according to Google, there's nearly 400 characters so naming them out would be useless

```

1. Capturing  Lines, Episode, and XML
```

- Find `^(.+?)(\n\n)` and replace with <sp>\1</sp>\2 ** Dot Matches All = OFF **
- Find `^(.*)$` and replace with <txt>\0</txt> ** Dot Matches All = ON **
- Find `^(.*)$` and replace with <xml>\0</xml> ** Dot Matches All = OFF ** * Must happen after `txt` *

```
=====================================================================

```

the first `\n\n\n` code and `^(.+?)(\n\n)` doesn't work across multiple filess. Kind of annoying.

```



