extends Control

var current_os = OS.get_name()
var dir = Directory.new()

var home_path = ""

var mc_path = ""
var swap_path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	#
	# Set paths
	if (current_os == "X11"):
		home_path = OS.get_environment("HOME")
		
		# Check if Minecraft Directory exists
		if (dir.dir_exists(home_path + "/.minecraft")): # Normal Install
			mc_path = (home_path + "/.minecraft")
		elif (dir.dir_exists(home_path + "/.var/app/con.mojang.Minecraft/data/minecraft")): # Flatpak
			mc_path = (home_path + "/.var/app/con.mojang.Minecraft/data/minecraft")
		else:
			print("No Minecraft directory found!")
	elif (current_os == "Windows"):
		home_path = OS.get_environment("AppData")
		
		if (dir.dir_exists(home_path + "/.minecraft")):
			mc_path = (home_path + "/.minecraft")
		else:
			print("No Minecraft directory found!")
	elif (current_os == "OSX"):
		home_path = OS.get_environment("HOME")
		
		if (dir.dir_exists(home_path + "/Library/Application Support/minecraft")):
			mc_path = (home_path + "/Library/Application Support/minecraft")
		else:
			print("No Minecraft directory found!")
	else:
		print("Sorry, I haven't added support for your OS yet.")
		print("This is not an automatic process, I need to find the minecraft directory and such.")
		print("Once again, sorry.")
		
		throw_error(1) # No OS Support
		
	
	#
	# Check and add modswap directory
	if (mc_path != ""):
		if (dir.dir_exists(mc_path + "/modswap")):
			print("Modswap directory exists")
			swap_path = (mc_path + "/modswap")
		else:
			print("No Modswap directory exists")
			print("Making Modswap directory")
			
			dir.make_dir(mc_path + "/modswap")
	else:
		throw_error(2) # No Minecraft Folder
	
	
	#
	# Add contents of modswap directory
	#
	if (swap_path != ""):
		dir.open(swap_path)
		
		dir.list_dir_begin()
		while true:
			var swap = dir.get_next()
			if swap == "":
				break
			elif not(swap.begins_with(".")):
				# Add item
				$UIroot/Panel/Swaps.add_item(swap)
		
		dir.list_dir_end()
	
	if $UIroot/Panel/Swaps.get_item_count() == 0:
		throw_error(3) # No swap folders in modswap directory


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func throw_error(code):
	$UIroot/ErrorPanel.visible = true
	$UIroot/Panel.visible = false
	
	var description = ""
	match[code]:
		[1]:
			description = "No support for your current OS. I need to find out where the .minecraft folder is on your OS."
		[2]:
			description = "No .minecraft folder found. Either minecraft isn't installed or the folder is somewhere unexpected."
		[3]:
			description = "No swap folders in your swap directory. A folder in your .minecraft folder has been made called 'modswap', requiring folders with mods to be placed within. For more information, refer to the github page."
		[_]:
			description = "Unknown Error. How!?"
	
	$UIroot/ErrorPanel/Description.text = ("Something seems to have went wrong.\n Error Code %d: %s" % [code, description])

func _on_Swaps_item_selected(index):
	var swap = $UIroot/Panel/Swaps.get_item_text(index)
	print("Selected ", $UIroot/Panel/Swaps.get_item_text(index))
	
	if (dir.dir_exists(mc_path + "/mods")):
		# Operate
		print("Swapping...")
		
		# Remove all files from mods folder
		dir.open(mc_path + "/mods")
		dir.list_dir_begin()
		while true:
			var file = dir.get_next()
			if file == "":
				break
			elif not(file.begins_with(".")):
				# Add item
				print(dir.remove(mc_path + "/mods/" + file))
		dir.list_dir_end()
		
		# Copy all files from modswap to mods folder
		dir.open(swap_path + "/" + swap)
		dir.list_dir_begin()
		while true:
			var file = dir.get_next()
			if file == "":
				break
			elif not(file.begins_with(".")):
				# Add item
				print(dir.copy((swap_path + "/" + swap + "/" + file), (mc_path + "/mods/" + file)))
		dir.list_dir_end()
		
		print("All done!")
		get_tree().quit()
		
	else:
		print("No mods folder, can't swap")
