class MustacheComber
  attr_accessor :input_string, :lookup_object
  def initialize(input_string, lookup_object)
    self.input_string = input_string
    self.lookup_object = lookup_object
  end

  def combed_string
    input_string.gsub(mustache_regex).each do |m|
      comb(m.gsub('{{', '').gsub('}}', ''))
    end
  end

  def comb(attribute)
    return attribute unless lookup_object.respond_to?(attribute)

    lookup_object.public_send(attribute).try(:to_s)
  end
  private :comb

  def mustache_regex
    /\{\{(.*?)\}\}/
  end
  private :mustache_regex
end
