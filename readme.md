# rate
move files into 1/2/3/n rating directories. the most efficient way to sort and access large numbers of files by quality or relevancy.

## usage
rate options ... number path ...

## description
this program sorts files by moving them into and between numerically named directories.
first it searches upwards to see if a numeric directory name exists in path, if yes, then only the file hierarchy under that number is moved into a directory with the given number.
if no numeric directory exists in path, a numeric directory is created in the current working directory and given paths are moved under there.

## examples:
~~~
cwd: /
rate 2 /a/0/b/c -> /a/2/b/c
~~~

~~~
cwd: /
rate 2 /a/b/c -> /2/a/b/c
~~~

~~~
cwd: /a/b
rate 2 /a/b/c -> /a/b/2/c
~~~

## options
~~~
--help | -h
--interface  show a machine readable cli specification
~~~

# dependencies
* [guile](https://www.gnu.org/software/guile/)
* [sph-lib](https://github.com/sph-mn/sph-lib)

# license
* gpl3+

# installation
* install dependencies
* execute ./exe/install

# custom thunar right-click-menu actions
## option: manually add with commands like this
~~~
rate 1 %F
~~~

## option: insert the ready-made code

this adds five new right-click commands in thunar:
* rate 1
* rate 2
* rate 3
* rate 4
* rate 5

insert the contents of [other/uca.xml](other/uca.xml) between the action and /action tags in $HOME/.config/Thunar/uca.xml.

if uca.xml does not yet exist, it can be initialized with the following content or by creating the first custom command via the thunar gui.
~~~
<?xml version="1.0" encoding="UTF-8"?>
<actions>
</actions>
~~~

# possible enhancements
* reduce dependencies
* rewrite in c