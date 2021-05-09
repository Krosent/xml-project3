for $proceeding in doc("dblp-excerpt.xml")/dblp/proceedings
    return 
        <proceedings>
        <proc_title>{$proceeding/title/text()}</proc_title>
        {
            for $inproceeding in doc("dblp-excerpt.xml")/dblp/inproceedings
            where $proceeding/@key = $inproceeding/crossref
            return 
            <title>{$inproceeding/title/text()}</title> 
        } 
        </proceedings>