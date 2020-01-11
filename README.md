# Adjustable-Seat

# Content 
Once you add the *Adjustable Seat* folder to your Unity project, you will find several game objects in it:

- Adjustable Seat
- Adjustable Seat Pose Repository
- Adjustable Seat Serverside
- Adjustable Seat Server Simulator

# Whats what ?
The first three are furniture items which you will upload to SineSpace later, after a few minor changes.
The last one, "Adjustable Seat Server Simulator", is used instead of the serverside scripting item when you are using it inside of Unity.

# How to start ?
Add the following three items to your unity scene.
- Adjustable Seat
- Adjustable Seat Pose Repository
- Adjustable Seat Server Simulator
Once you hit run, and sit on the cube seat, you will find a small arrow left hand side of your window, clicking that arror will unfold a seat adjust menu.

# The parts: "Adjustable Seat"
This is your furniture item ;-) Or at least a stand in for it.
In this sample, it contains two child items. "Model", the visual part, and "Seat Adjuster", the active adjustment component.
This way, the model can be exchanged for any other single seat.
If you want to have more than one sitter, duplicate the "Seat Adjuster".
Inside the "Seat Adjuster", there is the HUD and the actual scripting. Feel free to fiddle around in it, but if you break it... Repair it :)

# The parts: "Adjustable Seat Pose Repository"
To enable easy adding of poses and animations in the future, the animations are kept separate from the furniture objects.
This "Repository" item can contain an arbitrary number of animations and poses, and your scene can contain any number of repositories placed as furniture.
You don't need a repository per furniture item, any pose in single repository is available to all furniture items in the same scene.
Even if the repository is made by a different creator...
*So if you are an animation creator, create repositories and put them on the store. Every furniture owner using the seat adjust can add them, no coding required*

# The parts: "Adjustable Seat Serverside"
This is the part of the seat adjuster that stores the configuration settings on the SineSpace servers.
You have to upload this furniture item, and use the furniture ID it returns for the "Require Server Script" component on the "Seat Adjust" object above!
This item won't show up in your inventory, and you won't have to sell it either. It is just used internally, and with any number of your furniture items!

# The parts: "Adjustable Seat Server Simulator"
Basically a simulator for "Adjustable Seat Serverside". Serverside scripts don't run in Unity, so this is a workaround to make testing easier...

# Final words
Enjoy :)
Feel free to add it to your products!
If you should have any technical fixes / updates / extensions that you add feel free to send them in so we can all enjoy the results.