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
    return attribute unless can_comb?(lookup_object, attribute.to_sym)

    lookup_object.public_send(attribute).try(:to_s)
  end
  private :comb

  def can_comb?(lookup_object, attribute)
    lookup_object.respond_to?(:combable?) && lookup_object.combable?(attribute) &&
    lookup_object.respond_to?(attribute)
  end

  def mustache_regex
    /\{\{(.*?)\}\}/
  end
  private :mustache_regex
end
