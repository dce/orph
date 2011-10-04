require "riot"
require "orph"

context "Orph, removing orphans" do
  setup { Orph.new }

  context "with a single HTML tag" do
    setup { topic.fix("<p>these are words</p>") }
    asserts_topic.equals("<p>these are&#160;words</p>")
  end

  context "with multiple HTML tags" do
    setup { topic.fix("<p>one word</p><p>two words</p>") }
    asserts_topic.equals("<p>one&#160;word</p><p>two&#160;words</p>")
  end

  context "with a non-block-level nested tag" do
    setup { topic.fix "<p>This is <strong>important</strong>.</p>" }
    asserts_topic.equals("<p>This is&#160;<strong>important</strong>.</p>")
  end

  context "with nested HTML tags" do
    setup { topic.fix("<ul><li>one word</li><li>two words</li></ul>").gsub(/\n/, '') }
    asserts_topic.equals("<ul><li>one&#160;word</li><li>two&#160;words</li></ul>")
  end

  context "with a space inside an HTML tag" do
    setup { topic.fix('<p><a href="http://google.com/">Google</a></p>') }
    asserts_topic.equals('<p><a href="http://google.com/">Google</a></p>')
  end

  context "with text and a short link" do
    setup { topic.fix('<p>This is a <a href="#">link</a></p>') }
    asserts_topic.equals('<p>This is a&#160;<a href="#">link</a></p>')
  end

  context "with text, a long link, and ending text" do
    setup { topic.fix('<p>This is a <a href="#">long link</a>.</p>') }
    asserts_topic.equals('<p>This is a <a href="#">long&#160;link</a>.</p>')
  end

  context "with paragraph consisting of two links" do
    setup { topic.fix('<p><a href="#">link one</a><a href="#">link two</a></p>') }
    asserts_topic.equals('<p><a href="#">link one</a><a href="#">link&#160;two</a></p>')
  end

  context "with a div with two paragraphs and free text" do
    setup do
      html = '<div>some text<p>paragraph 1</p><p>paragraph 2</p></div>'
      topic.fix(html).gsub(/(  |\n)/, "")
    end

    asserts_topic.includes("some text")
    asserts_topic.includes("<p>paragraph&#160;1</p>")
    asserts_topic.includes("<p>paragraph&#160;2</p>")
  end

  context "with a UL containing paragraphs" do
    setup do
      html = <<-HTML
        <div>
          <ul>
            <li>some text</li>
            <li>
              <p>par. 1</p>
              <p>par. 2</p>
            </li>
          </ul>
        </div>
      HTML

      topic.fix(html).gsub(/(  |\n)/, "")
    end

    asserts_topic.includes("<li>some&#160;text</li>")
    asserts_topic.includes("<li><p>par.&#160;1</p><p>par.&#160;2</p></li>")
  end

  context "with span as a content container" do
    setup do
      topic.content_tags << "span"
      topic.fix("<p><span>span 1</span><span>span 2</span></p>")
    end

    asserts_topic.includes("<span>span&#160;1</span>")
    asserts_topic.includes("<span>span&#160;2</span>")
  end
end

