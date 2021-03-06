require "orph/version"
require "nokogiri"

class Orph
  attr_accessor :content_tags

  def initialize
    self.content_tags = %w(h1 h2 h3 h4 h5 h6 p li blockquote dt dd)
  end

  def fix(html)
    doc = Nokogiri::HTML::DocumentFragment.parse(html, "ASCII")
    parse_nodes(doc.children)
    doc.to_html
  end

  private

  def parse_nodes(nodes)
    nodes.each do |node|
      if content_node?(node)
        remove_widow(node.children)
      else
        parse_nodes(node.children)
      end
    end
  end

  def text_node?(node)
    node.is_a?(Nokogiri::XML::Text)
  end

  def has_space?(node)
    node.to_s.include?(" ")
  end

  def content_tag?(node)
    content_tags.include?(node.name)
  end

  def content_node?(node)
    content_tag?(node) && !node.children.all? { |child| child.blank? || content_tag?(child) }
  end

  def replace_final_space(html)
    html.reverse.sub(" ", "&#160;".reverse).reverse
  end

  def remove_widow(nodes)
    nodes.reverse.each do |node|
      if text_node?(node) && has_space?(node)
        node.replace replace_final_space(node.to_html)
        return true
      elsif !text_node?(node)
        return true if remove_widow(node.children)
      end
    end

    false
  end
end

