describe "Fakeweb" do

  it "should disallow web requests" do
    lambda {
      no_web {
        Net::HTTP.get(URI.parse("http://example.com/"))
      }
    }.should raise_error
  end
end
