module FacturaePrint
  module XMLObjectifier
  
    def self.build(node, options={})
      options = {:collection_nodes => []}.merge(options)
      return node.text if node.text?
      
      children = get_node_children(node)
      
      if children.size == 1 && children.first.text?
        children.first.text
      else
        object = options.delete(:object) || OpenStruct.new
        children.each do |child|
          object.send("#{child.name.underscore}=", options[:collection_nodes].include?(child.name) ? get_node_children(child).map{|c| build(c, options)} : build(child, options))
        end
        object
      end
    end
    
    private
    
    def self.get_node_children(node)
      node.children.reject { |c| c.blank? }
    end
  end
end