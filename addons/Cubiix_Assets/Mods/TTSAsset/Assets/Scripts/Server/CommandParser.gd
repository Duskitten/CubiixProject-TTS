class_name CommandParser
extends Node



var lexcodes = {
	"DictSplitters" : [
		"\"",
		"\'",
		"+",
		"-",
		"=",
		"*",
		"/",
		"%",
		"^",
		",",
		".",
		")",
		"(",
		"}",
		"{",
		"[",
		"]",
		"\\",
		":",
		"\t"
		],
	"Operators":[
		"==",
		"+=",
		"-=",
		">=",
		"<=",
		"*=",
		"/=",
		"!=",
		"=",
		"/",
		"+",
		"-",
		"*",
		"^",
		"%",
		"&&",
		"<",
		">"
	],
	"BeginBrackets":[
		"[",
		"{",
		"("
	],
	"EndBrackets":[
		"]",
		"}",
		")"
	],
	"String":[
		"\"",
		"\'"
	],

}

func parse_data(InitialString:String) -> Array:
	##Initial parse pass with scanner
	var parsedlists = parse_base([InitialString])
	return parsedlists[0]

func parse_base(initial_lists:Array) -> Array:
	var parsedlists = []
	for i in initial_lists.size():
		#print(initial_lists[i])
		parsedlists.append([])
		var currentvar = ""
		var IsInString = false
		var IsInComment = false
		var IsInNumber = false
		var IsInOperator = false
		for n in initial_lists[i].length():
			var character:String = initial_lists[i][n]
			if character == " " && !IsInString && !IsInComment:
				IsInNumber = false
				IsInOperator = false
				if currentvar != "":
					parsedlists[i].append(currentvar)
					currentvar = ""
			elif !IsInString && !IsInComment && character.is_valid_float() && !IsInNumber && currentvar == "":
					if currentvar != "":
						parsedlists[i].append(currentvar)
						currentvar = ""
					IsInNumber = true
					currentvar += character
			elif IsInNumber:
				if character.is_valid_float() || character == ".":
					currentvar += character
				else:
					IsInNumber = false
					if lexcodes["DictSplitters"].has(character) && character != ".":
						parsedlists[i].append(currentvar)
						parsedlists[i].append(character)
						currentvar = ""
					else:
						parsedlists[i].append(currentvar)
						currentvar = character
			elif lexcodes["DictSplitters"].has(character) && !IsInComment && !IsInNumber:
				if character == "\"" && !IsInString && !IsInComment:
					IsInString = true
					currentvar += character
				elif character == "\"" && IsInString && !IsInComment:
					IsInString = false
					currentvar += character
					parsedlists[i].append(currentvar)
					currentvar = ""
				elif character == "/" && initial_lists[i].length()-1 >= n+1 && initial_lists[i][n+1] == "/":
					IsInComment = true
					currentvar += character
				elif initial_lists[i].length()-1 >= n+1 && lexcodes["Operators"].has(character + initial_lists[i][n+1]):
					IsInOperator = true
					currentvar += character
				elif IsInOperator:
					currentvar += character
				else:
					if !IsInComment:
						if currentvar != "":
							parsedlists[i].append(currentvar)
						parsedlists[i].append(character)
						currentvar = ""
					else:
						currentvar += character
			else:
				currentvar += character
			
		if currentvar != "":
			parsedlists[i].append(currentvar)
	return parsedlists
