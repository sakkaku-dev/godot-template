mkdir -v -p build/win
godot -v --export "Windows" ./build/win/main.exe
cd build/win && zip -r windows.zip *

mkdir -v -p build/linux
godot -v --export "Linux" ./build/linux/main.x86_64
cd build/linux && zip -r linux.zip *

mkdir -v -p build/mac
godot -v --export "Mac OSX"