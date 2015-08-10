class XmlDocument
  def initialize(indent = false)
    @indent = 0 if indent
  end

  def method_missing(method_name, attributes = {}, &prc)
    if prc.nil?
      xml_string = "<#{method_name.to_s}"
      attributes.each do |key, value|
        xml_string << " #{key.to_s}=\"#{value.to_s}\""
      end
      @indent ? xml_string << "/>\n" : xml_string << "/>"
    else
      if @indent
        xml_string = "<#{method_name.to_s}>\n"
        @indent += 1
        xml_string << "  " * @indent + "#{yield}"
        @indent -= 1
        xml_string << "  " * @indent + "</#{method_name.to_s}>\n"
      else
        xml_string =
          "<#{method_name.to_s}>#{yield}</#{method_name.to_s}>"
      end
    end
  end
end
