<authors_coauthors>
{
  for $material in doc("dblp-excerpt.xml")/dblp/*
    for $authors in $material/author
        return
        for $coauthors in $material/author
                where $authors ne $coauthors
        return 
            <author>
                <name>{$authors/text()}</name>
                <coauthors number="{count($coauthors)}">
                    <coauthor> {$coauthors/text()} </coauthor> 
                </coauthors>
            </author>
}
</authors_coauthors>

(:~ 
<authors_coauthors>
{
let $intermidiateResults :=
  for $material in doc("dblp-excerpt.xml")/dblp/*
    for $authors in $material/author
        return
        for $coauthors in $material/author
                where $authors ne $coauthors
        return 
            <author>
                <name>{$authors/text()}</name>
                <coauthors number="{count($coauthors)}">
                    <coauthor> {$coauthors/text()} </coauthor> 
                </coauthors>
            </author>

return
    <author>
    {
        for $authors in distinct-values($intermidiateResults/name)
        return $authors
    }
    </author>
}
</authors_coauthors> ~:)