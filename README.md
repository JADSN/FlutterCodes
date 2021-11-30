# FlutterCodes
Flutter codes

## Flutter Setup

## Setup Docker

1. `sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev docker.io`
1. `sudo usermod -aG docker $USER`

## Setup Flutter

1. `git clone https://github.com/flutter/flutter.git`
1. `mv -f flutter repos`
1. `echo -e "\n\nexport PATH="\$PATH:~/repos/flutter/bin" >>  ~/.bashrc`
1. `source $HOME/.bashrc`

## Workflow
1. `flutter`
1. `flutter doctor`
1. `flutter config --enable-linux-desktop`
1. `cd hello`
1. `code lib/`
1. `flutter run -d linux`
   
## Create application

### One platform
`flutter create --platforms=linux -t app <app_name>`

### Multiple platform
`flutter create --platforms=linux,web -t app <app_name>` 

## Standlone Binary - AppImage

[AppImage](https://appimage-builder.readthedocs.io/en/latest/examples/flutter.html)

1. `sudo apt install -y python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev fakeroot strace fuse`
1. `wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O $HOME/bin/appimagetool`
1. `cd bin/`
1. `chmod +x appimagetool`

#### Go to project root folder

```
total 40K
-rw-rw-r-- 1 labolicha labolicha 1,5K out  2 13:06 analysis_options.yaml
drwxrwxr-x 6 labolicha labolicha 4,0K out  2 13:15 build
drwxrwxr-x 2 labolicha labolicha 4,0K out  2 13:06 lib
drwxrwxr-x 3 labolicha labolicha 4,0K out  2 13:06 linux
-rw-rw-r-- 1 labolicha labolicha 3,7K out  2 13:06 pubspec.lock
-rw-rw-r-- 1 labolicha labolicha 3,7K out  2 13:06 pubspec.yaml
-rw-rw-r-- 1 labolicha labolicha  540 out  2 13:06 README.md
drwxrwxr-x 2 labolicha labolicha 4,0K out  2 13:06 test
-rw-rw-r-- 1 labolicha labolicha  896 out  2 13:06 thecounter.iml
```

#### New project - Copy bundle to generate AppImage.
1. `flutter build linux`
1. `cp -rv ./build/linux/x64/release/bundle ./AppDir`
1. `appimage-builder --generate`
1. `appimage-builder --recipe AppImageBuilder.yml`

# Pack manager
1. [**Ref**](https://pub.dev/)
1. [**Ref**](https://dev.to/hosamhasan/package-flutter-linux-app-into-appimage-part-1-2agj)
1. [**Ref**](https://dev.to/hosamhasan/package-flutter-linux-app-into-appimage-part-2-1c5o)
1. [**Ref**](https://www.enovision.net/how-create-appimage-entries-menu-ubuntu)
1. [**Ref**](https://github.com/AppImage/awesome-appimage)

### Build any project.
1. Change title bar at lines 43 and 47 in `<folder_name>/linux/my_application.cc`
1. `flutter build linux`
1. `appimage-builder --recipe AppImageBuilder.yml`
1. `./<name-app-standalone>.AppImage`
   
### Bash helpers
1. `date +%Y-%m-%d`
1. `man strftime`
