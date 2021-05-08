<authors_coauthors>
{

for $authors in distinct-values( doc("dblp-excerpt.xml")//author )
    return
    <author>
        <name>{data($authors)}</name>
        
         <coauthors number="{number(count(distinct-values(doc("dblp-excerpt.xml")/dblp/*[author=$authors]/author)))-1}">
            {
            for $coauthors in distinct-values( doc("dblp-excerpt.xml")/dblp/*[author=$authors]/author )
            where $authors ne $coauthors
                return 
                    <coauthor>
                    <name> { data($coauthors) } </name>
                    <nb_joint_pubs>
                        {count(distinct-values(doc("dblp-excerpt.xml")/dblp/*[author=$authors]/author[.=$coauthors] ))}
                    </nb_joint_pubs>
                    </coauthor>
            }
        </coauthors>
    </author>
        
}
</authors_coauthors>