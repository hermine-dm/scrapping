require_relative '../lib/townhall'


describe "perform method" do
	it "should be an array and not nil" do
		expect(perform()).not_to be_nil
    	expect(perform()).to be_a_kind_of(Array)
   end
end 

describe "the get_towhall_city method" do
	it "should be including 185 cities of Val d'oise" do
		expect(get_towhall_city().size).to eq(185)
    	
   end
end 