# Godot inside Docker

## Why use this?

Honestly, most people don't need to run Godot inside a Docker container. 

I'm an IT teacher, which means I use a ton of different frameworks and languages in my classes, ranging from Python to C# to C++ to JavaScript/Typescript. Installing each of these frameworks and dependencies is a pain, and keeping each of those frameworks up to date can be even more painful. 
This is where Docker is extremely useful. It keeps my system clean, I don't have to worry about conflicts between different versions of the same framework or library, and it makes it easy for me to switch between different environments (e.g., development, testing, production).

Coming from Unity, where I could install Unity seperately and run the project inside of a .NET devcontainer, I wanted to have a similar experience with Godot. However, Godot Mono needs to have the .NET runtime installed on your system, which is exactly what I wanted to avoid.

## Caveats

I made this project specifically for my own systems. Specifically, I'm running Arch Linux on an AMD CPU/GPU system. I haven't tested it on any other operating system or CPU/GPU combination. If you encounter issues, figure it out yourself!

## requirements:

- install docker
- install xhost
- run `xhost +local:docker`
- make the file `godot-docker.sh` executable with `chmod +x godot-docker.sh`

