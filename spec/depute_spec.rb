require_relative '../lib/depute'


describe "scrapper des noms prénoms des députés" do
   it "should return an array of hash with names, surname of all the deputes" do
       expect(create_hash_member("M. Florian Bachelier")).not_to be_empty
   end
   it "should return an array of hash with names, surname of all the deputes" do
       expect(create_hash_member("M. Florian Bachelier")).to eq({"first_name"=>"Florian", "last_name"=>"Bachelier"})
   end
end

describe "perform method" do
	it "should be an array and not nil" do
		expect(perform()).not_to be_nil
    	expect(perform()).to be_a_kind_of(Array)
   end
end 