public with sharing class Characters {
    public class Alternate_names {
	}

	public String id;
	public String name;
	//public List<Alternate_names> alternate_names;
	public String species;
	public String gender;
	public String house;
	public String dateOfBirth;
	public Integer yearOfBirth;
	public Boolean wizard;
	public String ancestry;
	public String eyeColour;
	public String hairColour;
	public Wand wand;
	public String patronus;
	public Boolean hogwartsStudent;
	public Boolean hogwartsStaff;
	public String actor;
	//public List<Alternate_names> alternate_actors;
	public Boolean alive;
	public String image;

	public class Wand {
		public String wood;
		public String core;
		public String length;
	}

	public class Wand_Y {
		public String wood;
		public String core;
		public Double length;
	}

	public class Wand_Z {
		public String wood;
		public String core;
		public Object length;
	}

	
	public static List<Characters> parse(String json) {
		return (List<Characters>) System.JSON.deserialize(json, List<Characters>.class);
	}
}