require "spec_helper"

describe FacturaePrint::XMLObjectifier do
  
  it "should build from one node xml" do
    xml = "<lonely>1</lonely>"
    
    object = FacturaePrint::XMLObjectifier.build(Nokogiri::XML(xml))
    object.should be_a(OpenStruct)
    object.lonely.should == "1"
  end
  
  it "should build from xml with nested nodes" do
    xml = <<-XML
    <zoo>
      <tiger>
        <name>Shere Khan</name>
      </tiger>
      <lion>
        <name>Mufasa</name>
        <dimensions>
          <height>
            <unit>inches</unit>
            <value>30</value>
          </height>
          <length>
            <unit>meters</unit>
            <value>2</value>
          </length>
        </dimensions>
      </lion>
    </zoo>
    XML
    
    object = FacturaePrint::XMLObjectifier.build(Nokogiri::XML(xml).root)
    object.tiger.name.should == "Shere Khan"
    object.lion.name.should == "Mufasa"
    object.lion.dimensions.height.unit.should == "inches"
    object.lion.dimensions.height.value.should == "30"
    object.lion.dimensions.length.unit.should == "meters"
    object.lion.dimensions.length.value.should == "2"
  end
  
  it "should underscore node names" do
    xml = "<Person><PersonName>Ronald</PersonName></Person>"
    object = FacturaePrint::XMLObjectifier.build(Nokogiri::XML(xml))
    object.person.person_name = "Ronald"
  end
  
  it "should build on a given object" do
    xml = "<arm><wrist>2</wrist><hand>3</hand></arm>"
    object = OpenStruct.new({"elbow" => "1"})
    
    FacturaePrint::XMLObjectifier.build(Nokogiri::XML(xml).root, :object => object)
    object.elbow.should == "1"
    object.wrist.should == "2"
    object.hand.should == "3"
  end
  
  it "should build array for nodes with name in collection_nodes option" do
    xml = <<-XML
    <agenda>
      <size>3</size>
      <contacts>
        <contact>
          <name>Muddy Waters</name>
          <numbers>
            <number>555-1234</number>
            <number>555-2341</number>
          </numbers>
        </contact>
        <contact>
          <name>Keith Richards</name>
          <numbers>
            <number>555-5678</number>
          </numbers>
        </contact>
        <contact>
          <name>Steve Marriott</name>
        </contact>
      </contacts>
    </agenda>
    XML
    
    object = FacturaePrint::XMLObjectifier.build(Nokogiri::XML(xml).root, :collection_nodes => ["contacts", "numbers"])
    object.size.should == "3"
    object.contacts.should be_a(Array)
    object.contacts[0].name.should == "Muddy Waters"
    object.contacts[0].numbers.should be_a(Array)
    object.contacts[0].numbers.size.should == 2
    object.contacts[0].numbers[0].should == "555-1234"
    object.contacts[0].numbers[1].should == "555-2341"
    object.contacts[1].name.should == "Keith Richards"
    object.contacts[1].numbers.should be_a(Array)
    object.contacts[1].numbers.size.should == 1
    object.contacts[1].numbers[0].should == "555-5678"
    object.contacts[2].name.should == "Steve Marriott"
    object.contacts[2].numbers.should be_nil
  end
  
end