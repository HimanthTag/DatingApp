# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
	unless Relationship.pluck(:id).length > 3
		Relationship.create(:name=>"Single",:description=>"Open to relationship", :is_deleted=>false)
		Relationship.create(:name=>"Committed",:description=>"In relationship", :is_deleted=>false)
		Relationship.create(:name=>"Married",:description=>"Living in relationship", :is_deleted=>false)
		Relationship.create(:name=>"Divorced",:description=>"Fed up with relationship", :is_deleted=>false)
	end

	unless Gender.pluck(:id).length > 2
		Gender.create(:name=>"Male", :is_deleted=>false)
		Gender.create(:name=>"Female", :is_deleted=>false)
		Gender.create(:name=>"Other", :is_deleted=>false)
	end

	unless Ethnicity.pluck(:id).length > 7
		Ethnicity.create(:name=>"Caucasian", :is_deleted=>false)
		Ethnicity.create(:name=>"Black/African American", :is_deleted=>false)
		Ethnicity.create(:name=>"Hispanic/Latino", :is_deleted=>false)
		Ethnicity.create(:name=>"Asian", :is_deleted=>false)
		Ethnicity.create(:name=>"Middle Eastern", :is_deleted=>false)
		Ethnicity.create(:name=>"Pacific Islander", :is_deleted=>false)
		Ethnicity.create(:name=>"Native American", :is_deleted=>false)
		Ethnicity.create(:name=>"Other", :is_deleted=>false)		
	end

	unless PokemongoTeam.pluck(:id).length > 1
		PokemongoTeam.create(:name=>"Team Instinct", :is_deleted=>false)	
		PokemongoTeam.create(:name=>"Team Mystic", :is_deleted=>false)	
		PokemongoTeam.create(:name=>"Team Valor", :is_deleted=>false)	
	end

	unless RelationshipInterest.pluck(:id).length > 1
		RelationshipInterest.create(:name=>"Romance", :is_deleted=>false)	
		RelationshipInterest.create(:name=>"Friendship", :is_deleted=>false)	
		RelationshipInterest.create(:name=>"Both", :is_deleted=>false)	
	end

	unless State.pluck(:id).length > 1
		State.create([
		    {
		        :name => "Alabama",
		        :abbreviation => "AL"
		    },
		    {
		        :name => "Alaska",
		        :abbreviation => "AK"
		    },
		    {
		        :name => "American Samoa",
		        :abbreviation => "AS"
		    },
		    {
		        :name => "Arizona",
		        :abbreviation => "AZ"
		    },
		    {
		        :name => "Arkansas",
		        :abbreviation => "AR"
		    },
		    {
		        :name => "California",
		        :abbreviation => "CA"
		    },
		    {
		        :name => "Colorado",
		        :abbreviation => "CO"
		    },
		    {
		        :name => "Connecticut",
		        :abbreviation => "CT"
		    },
		    {
		        :name => "Delaware",
		        :abbreviation => "DE"
		    },
		    {
		        :name => "District Of Columbia",
		        :abbreviation => "DC"
		    },
		    {
		        :name => "Federated States Of Micronesia",
		        :abbreviation => "FM"
		    },
		    {
		        :name => "Florida",
		        :abbreviation => "FL"
		    },
		    {
		        :name => "Georgia",
		        :abbreviation => "GA"
		    },
		    {
		        :name => "Guam",
		        :abbreviation => "GU"
		    },
		    {
		        :name => "Hawaii",
		        :abbreviation => "HI"
		    },
		    {
		        :name => "Idaho",
		        :abbreviation => "ID"
		    },
		    {
		        :name => "Illinois",
		        :abbreviation => "IL"
		    },
		    {
		        :name => "Indiana",
		        :abbreviation => "IN"
		    },
		    {
		        :name => "Iowa",
		        :abbreviation => "IA"
		    },
		    {
		        :name => "Kansas",
		        :abbreviation => "KS"
		    },
		    {
		        :name => "Kentucky",
		        :abbreviation => "KY"
		    },
		    {
		        :name => "Louisiana",
		        :abbreviation => "LA"
		    },
		    {
		        :name => "Maine",
		        :abbreviation => "ME"
		    },
		    {
		        :name => "Marshall Islands",
		        :abbreviation => "MH"
		    },
		    {
		        :name => "Maryland",
		        :abbreviation => "MD"
		    },
		    {
		        :name => "Massachusetts",
		        :abbreviation => "MA"
		    },
		    {
		        :name => "Michigan",
		        :abbreviation => "MI"
		    },
		    {
		        :name => "Minnesota",
		        :abbreviation => "MN"
		    },
		    {
		        :name => "Mississippi",
		        :abbreviation => "MS"
		    },
		    {
		        :name => "Missouri",
		        :abbreviation => "MO"
		    },
		    {
		        :name => "Montana",
		        :abbreviation => "MT"
		    },
		    {
		        :name => "Nebraska",
		        :abbreviation => "NE"
		    },
		    {
		        :name => "Nevada",
		        :abbreviation => "NV"
		    },
		    {
		        :name => "New Hampshire",
		        :abbreviation => "NH"
		    },
		    {
		        :name => "New Jersey",
		        :abbreviation => "NJ"
		    },
		    {
		        :name => "New Mexico",
		        :abbreviation => "NM"
		    },
		    {
		        :name => "New York",
		        :abbreviation => "NY"
		    },
		    {
		        :name => "North Carolina",
		        :abbreviation => "NC"
		    },
		    {
		        :name => "North Dakota",
		        :abbreviation => "ND"
		    },
		    {
		        :name => "Northern Mariana Islands",
		        :abbreviation => "MP"
		    },
		    {
		        :name => "Ohio",
		        :abbreviation => "OH"
		    },
		    {
		        :name => "Oklahoma",
		        :abbreviation => "OK"
		    },
		    {
		        :name => "Oregon",
		        :abbreviation => "OR"
		    },
		    {
		        :name => "Palau",
		        :abbreviation => "PW"
		    },
		    {
		        :name => "Pennsylvania",
		        :abbreviation => "PA"
		    },
		    {
		        :name => "Puerto Rico",
		        :abbreviation => "PR"
		    },
		    {
		        :name => "Rhode Island",
		        :abbreviation => "RI"
		    },
		    {
		        :name => "South Carolina",
		        :abbreviation => "SC"
		    },
		    {
		        :name => "South Dakota",
		        :abbreviation => "SD"
		    },
		    {
		        :name => "Tennessee",
		        :abbreviation => "TN"
		    },
		    {
		        :name => "Texas",
		        :abbreviation => "TX"
		    },
		    {
		        :name => "Utah",
		        :abbreviation => "UT"
		    },
		    {
		        :name => "Vermont",
		        :abbreviation => "VT"
		    },
		    {
		        :name => "Virgin Islands",
		        :abbreviation => "VI"
		    },
		    {
		        :name => "Virginia",
		        :abbreviation => "VA"
		    },
		    {
		        :name => "Washington",
		        :abbreviation => "WA"
		    },
		    {
		        :name => "West Virginia",
		        :abbreviation => "WV"
		    },
		    {
		        :name => "Wisconsin",
		        :abbreviation => "WI"
		    },
		    {
		        :name => "Wyoming",
		        :abbreviation => "WY"
		    }
		])
	end