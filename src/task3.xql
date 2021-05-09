xquery version "1.0";

<distances>
{
for $select_author in distinct-values( doc("dblp-excerpt.xml")//author ),  $coauthor in distinct-values(doc("dblp-excerpt.xml")/dblp/*[author=$select_author]/author) 
where data($select_author) != data($coauthor)
order by $select_author

return ( 
 <distance author1="{data($select_author)}" author2="{data($coauthor)}" distance="1"/> 
,
 for $other_coauthor in distinct-values(doc("dblp-excerpt.xml")/dblp/*[author=$coauthor]/author)
 where $select_author ne $other_coauthor
 return 
    for  $compare_author in distinct-values(doc("dblp-excerpt.xml")/dblp/*[author=$select_author]/author)
    where not($compare_author = $select_author) and $compare_author != $other_coauthor
    return (
        <distance author1="{data($select_author)}" author2="{data($other_coauthor)}" distance="2"/> ,
        for $deeper_other_coauthor in distinct-values(doc("dblp-excerpt.xml")/dblp/*[author=$other_coauthor]/author)
        where $deeper_other_coauthor ne $other_coauthor
        return
            for $compare_again_author in distinct-values(doc("dblp-excerpt.xml")/dblp/*[author=$compare_author]/author)
            where not($compare_again_author = $compare_author) and $compare_again_author != $other_coauthor
            return 
                <distance author1="{data($compare_again_author)}" author2="{data($compare_author)}" distance="3"/> 
    )
)
}
</distances>