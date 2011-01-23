module FacturaePrint
  module XMLObjectifier
  
    def self.build(node, options={})
      options = {:collection_nodes => []}.merge(options)
      return node.text if node.text?
      
      children = get_node_children(node)
      return nil if children.empty? && node.content.empty?
      
      if children.size == 1 && children.first.text?
        children.first.text
      else
        object = options.delete(:object) || OpenStruct.new
        children.each do |child|
          value = if options[:collection_nodes].include?(child.name)
            get_node_children(child).map{|c| build(c, options)}
          else 
            build(child, options)
          end
          
          object.send("#{child.name.underscore}=", value)
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