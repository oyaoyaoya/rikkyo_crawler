class Department

	DEPARTMENTS = {
		"00003" => "33",
		"00001" => "34",
		"00002" => "35",
		"01001" => "1",
		"01002" => "2",
		"01003" => "3",
		"01004" => "4",
		"01005" => "5",
		"01006" => "6",
		"01007" => "7",
		"01008" => "8",
		"01009" => "9",
		"02005" => "11",
		"03001" => "14",
		"03002" => "15",
		"04001" => "16",
		"04002" => "17",
		"04003" => "18",
		"04004" => "19",
		"05006" => "20",
		"05002" => "20",
		"06004" => "23",
		"07001" => "10",
		"08001" => "26",
		"08002" => "27",
		"09001" => "28",
		"09002" => "29",
		"09003" => "30",
		"10001" => "31",
		"10002" => "32",
		"11001" => "36"
	}
	def initialize(data)
		@department_id = data
	end

	def select_department
		department = DEPARTMENTS[@department_id]
		department
	end

end
