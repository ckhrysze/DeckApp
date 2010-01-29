require("spec_helper.js");
require("../../public/javascripts/command_parser.js");

Screw.Unit(function(){
  describe("CommandParser", function(){

    it("handles # name", function(){
	 var parsed = parseInput("4 forest");
	 expect(parsed.name).to(equal, "forest");
	 expect(parsed.count).to(equal, 4);
    });

    it("handles +# name", function(){
	 var parsed = parseInput("+13 forest");
	 expect(parsed.name).to(equal, "forest");
	 expect(parsed.count).to(equal, 13);
    });

    it("handles x# name", function(){
	 var parsed = parseInput("x5 island");
	 expect(parsed.name).to(equal, "island");
	 expect(parsed.count).to(equal, 5);
    });

    it("handles #x name", function(){
	 var parsed = parseInput("3x ball lightning");
	 expect(parsed.name).to(equal, "ball lightning");
	 expect(parsed.count).to(equal, 3);
    });

    it("handles -# name", function(){
	 var parsed = parseInput("-2 forest");
	 expect(parsed.name).to(equal, "forest");
	 expect(parsed.count).to(equal, -2);
    });
  });
});
