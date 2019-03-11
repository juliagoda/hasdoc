

# hasdoc 1.0 


1. [Description](#description)  
2. [Minimum system requirements](#minimum-system-requirements)  
3. [Installation of dependencies](#installation-of-dependencies)  
4. [Project downloading](#project-downloading)  
5. [Remarks](#remarks)  
6. [Building and installation of the project](#building-and-installation-of-the-project)  
7. [Uninstalling a project](#uninstalling-a-project)  
8. [Potential further development](#potential-further-development)
9. [Sources](#Sources)



## Description  


The application concerns the stages of designing a future application, before starting to create it. In hasdoc there is a series of auxiliary questions, divided into such categories as:

- Definitions
- Requirements
- Architecture
- Technology 
- Tests

The order is very important here, because filling in the fields in this order allows you to devise new ways of working and thus makes it easier to expand. 
Additional questions allow you to stimulate your imagination and prepare for most time-consuming tasks. Properly spending time on this stage helps to reduce lost time and possible costs, which becomes higher when the software development stage is coming to an end.



## Minimum system requirements


- 4 GB RAM (for link stage)
- The more memory on your hard drive, the better
- internet connection

For older computer hardware, it will be possible to increase the memory in the SWAP partition or to add it in a non-physical way, which, if desired, can run temporarily until the system restarts.

The following command in Linux can be used to check if the second line contains any memory:


`free -m`


if the last column of the first row does not even exceed 4 GB (about 4096 MB), and the SWAP memory is equal to 0, it is worthwhile to immediately execute the following commands:


```
sudo su
cd /var
touch swapfile
chmod 600 swapfile
dd if=/dev/zero of=/var/swapfile bs=1024k count=1000
mkswap /var/swapfile
swapon /var/swapfile
exit
```


If after executing the command:


`swapon -show`


a newly created place will appear, then you can start the compilation stage. Once the hasdoc compilation is complete, it's a good idea to clean up the previous steps with the following commands:


```
sudo su
swapoff /var/swapfile
rm /var/swapfile
exit
```

The above tutorial is modelled on the content of the website: [http://www.linuxandubuntu.com/home/how-to-create-or-increase-swap-space-in-linux ](http://www.linuxandubuntu.com/home/how-to-create-or-increase-swap-space-in-linux)



## Installation of dependencies  


There are several dependencies without which it will not be possible to start or build correctly. Some of them may be optional, but in order to minimize the risk of error, it is advisable to install them. Below is a list of packages whose names may vary slightly depending on the Linux distribution: 

    • git
    • pkg-config
    • webkitgtk2
    • wxgtk2
    • libglu
    • g++  (dla Windows – MinGW, dla MacOS X – Developer Tools)
    • ghc version 8.2.2 or higher
    • ghc-libs
    • stack
    • wkhtmltopdf


For Windows you can download these dependencies from the following pages:

    • git
    • Haskell Platform 8.2.23
    • wkhtmltopdf
    • MinGW
    • wxWidgets in version 3.0.4 or below (install in the path C:\Libs\wxWidgets\3.0.4) – 
  
Links:  
[wkhtmltopdf.org/downloads.html](wkhtmltopdf.org/downloads.html)
[https://git-scm.com/download/win](https://git-scm.com/download/win)
[https://haskell.org/platform/windows.html](https://haskell.org/platform/windows.html)
[sourceforge.net/projects/mingw-w64](hsourceforge.net/projects/mingw-w64)
[https://www.wxwidgets.org/downloads](https://www.wxwidgets.org/downloads)


For wxWidgets in Windows, you will probably need to run additional commands after installation to make the library detectable by wxHaskell. You can find a description of the additional steps on the page: 

[wiki.haskell.org/WxHaskell/Windows#wxWidgets_3.0_and_wxHaskell_.3E.3D_0.92](wiki.haskell.org/WxHaskell/Windows#wxWidgets_3.0_and_wxHaskell_.3E.3D_0.92)



## Project downloading


The project is located on the Github website, from which you can clone it with one command using the "git" program. The program will download the project to the path in which "git" is currently active:

`git clone https://github.com/juliagoda/hasdoc`


## Remarks


To ensure stability for the current version of the software, the wxHaskell module was downloaded from [https://github.com/wxHaskell/wxHaskell](https://github.com/wxHaskell/wxHaskell) from the commit number: b7ac21d1dba48076dc7538d1967a14d59cfeb615 . This module can be found in the main hasdoc and hasdoc-gen catalogues. The stack.yaml files contain references to these paths.

It is also required to build in a path that does not contain white characters (e.g. spaces). It is worth changing the path to another one or overwrite the white characters in the directories.

If an "out of memory" error nevertheless occurs during the building process, you can create a swap file with a larger capacity than you currently have and try again.



## Building and installation of the project


In the main directory of the hasdoc project, you have to perform the following commands with the help of stack:

`stack setup && stack build`

Once the construction is complete, it must be completed:

`stack install hasdoc`

However, if you want to install the files in a different place than the default one, you can use this option:

`stack install –-local-bin-path selected_path`

You can also run the program without installation with:

`stack exec hasdoc`

or in Windows:

`stack exec hasdoc-exe`



## Uninstalling a project


The project is uninstalled from the system by going to the path previously specified by the command "stack install --local-bin-path selected_path" or in the default path. The default path can be recalled by command:

`stack path --local-bin`


## Potential further development

During the design of this application, it was determined that it will be possible to develop during the:

- adding a new submenu
- willingness to change the appearance of the generated content (adding a new css template or modifying an existing one)
- adding a new option in the settings
- modifications to the documentation 
- adding a new section with headings and questions in the hasdoc-gen sub-project
- add an additional heading to the section on one side of the hasdoc-gen wizard page
- changes in the appearance of icons and the style of entire windows throughout the program
- possible change of format *.ini to another one for settings
- a change from an obsolete module to another with a different structure and similar functions
- adding a new wizard that would help in the choice related to software development
- adding support for another linguistic language
- changes of the start description in the main window
- changes in the position of widgets
- consideration of tests for existing and new functions
- add a support for new file formats and improving the generation of existing files


## Sources

[github.com/wxHaskell/wxHaskell](github.com/wxHaskell/wxHaskell)
[docs.wxwidgets.org/3.0/page_introduction.html#page_introduction_requirements](docs.wxwidgets.org/3.0/page_introduction.html#page_introduction_requirements)
