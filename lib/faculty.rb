class Faculty

	FACULTIES = {
		"00" => "11",
		"01" => "1",
		"02" => "2",
		"03" => "3",
		"04" => "4",
		"05" => "5",
		"06" => "6",
		"07" => "7",
		"08" => "8",
		"09" => "9",
		"10" => "10",
		"11" => "12"
}
	def initialize(data)
		@faculty_id = data
	end

	def select_faculty
		faculty = FACULTIES[@faculty_id]
		faculty
	end
end
