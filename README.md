Orph
====

Orphans (commonly referred to as 'widows') are single-word lines at the end of paragraphs and are generally considered bad form by type nerds. This library removes them with non-breaking spaces.

## Usage

    >> orph = Orph.new
    => #<Orph:0x000001008e7578 @content_tags=["h1", "h2", "h3", "h4", "h5", "h6", "p", "li", "blockquote", "dt", "dd"]> 

    >> orph.fix("<p>Here's some content.</p>")
    => "<p>Here's some&#160;content.</p>" 

    >> orph.fix "<p><span>some content</span><span>more content</span></p>"
    => "<p><span>some content</span><span>more&#160;content</span></p>" 

    >> orph.content_tags << "span"
    => ["h1", "h2", "h3", "h4", "h5", "h6", "p", "li", "blockquote", "dt", "dd", "span"] 

    >> orph.fix "<p><span>some content</span><span>more content</span></p>"
    => "<p><span>some&#160;content</span><span>more&#160;content</span></p>"

* * *

(c) 2011 David Eisinger
