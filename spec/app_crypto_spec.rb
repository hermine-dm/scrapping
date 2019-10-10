require_relative '../lib/app_crypto'

describe "the finding_the_page method" do
	it "should return a page of internet" do
    expect(finding_the_page("https://coinmarketcap.com/all/views/all/")).not_to be_nil
  end
end

describe "the perform method" do
   it "should return a normal size of the array & one curr include" do
       expect(perform("https://coinmarketcap.com/all/views/all/").to_a.size.to_i).to be >1000
       expect(perform("https://coinmarketcap.com/all/views/all/")[0]).to include("BTC")
     end

	it "should be an array" do
       expect(perform("https://coinmarketcap.com/all/views/all/")).to be_a_kind_of(Array)
   end
end 
