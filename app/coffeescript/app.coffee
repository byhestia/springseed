$ ->
	# Parse Initial Text
	#window.noted.parseText()

	# Event Handlers
	$("#content header .edit").click ->

		# There should be a better way to do this
		if $(this).text() is "save"
			$(this).text "edit"
			editor.preview()
		else
			$(this).text "save"
			editor.edit()


	editor = new EpicEditor
		container: 'contentbody'
	editor.load()
	editor.importFile('some-file',"#Imported markdown\nFancy, huh?");
	editor.preview();



window.noted =
	blank ->
		console.log("hey")
