# mcmodswap

## Tool to quickly and easily swap different mods in Minecraft - Now in Godot

This is a tool used to swap Minecraft mods. By creating folders of mods in a modswap folder, you will be able to swap out these custom folders of mods with your current mods folder with one click.

This tool is versatile, as in the background, all it really does is replace the contents of one folder with another. This allows for you to create any combination of mods; one could create a folder for fabric mods and another folder for forge mods, for example.

I decided to recreate this tool in Godot versus Python/Qt5 as it allowed for much easier exporting. While building the app with Python/Qt5 allowed for a fully customizable interface, Godot isn't too far behind, and is way easier to export into an executable.

### Setup

Setting up this app will require you to go into your .minecraft folder. [Refer here to find out where it is on your OS.](https://minecraft.fandom.com/wiki/.minecraft)

STEP 1:<br>
Launch the app once. You will reach the welcome screen. This will create the `modswap` folder in the `.minecraft` folder. Once the welcome screen opens, you can close the window.

STEP 2:<br>
In your `modswap` folder, add more folders, each containing different mods. An example of this is shown below.

    .minecraft
    |
    └───modswap
        |
        └───fabric_mods
        |   |   mod1.jar
        |   |   mod2.jar
        |   |   mod3.jar
        |
        └───forge_mods
        |   |   forge_mod1.jar
        |   |   forge_mod2.jar
        |
        └───old_mods
        |   |   old_mod1.jar
        |   |   old_mod2.jar
        |
        └───fabric_mods_lite
            |   mod1.jar


STEP 3:<br>
Once you have created all the folders, you can now relaunch the app. You should see all the folder names. Click on one to swap the mods in that folder with those in your mods folder.

### To do

- Proper Help Screen
- UI improvements
