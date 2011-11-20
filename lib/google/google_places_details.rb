class GooglePlacesDetails
  include Google::Places
  
  def initialize(values)
    set_reference(values)
    super(values)
  end

  def set_reference(options)
    @reference ||= options[:reference]
    raise "Reference is required" if @reference.nil?
  end

  def params
    "reference=#{@reference}"
  end
end
