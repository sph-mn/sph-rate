# rate
move files into 1/2/3/n rating directories. the most efficient way to sort and access large numbers of files by quality or relevancy.

## usage
rate options ... number path ...

## description
this program "rates" files by moving them into a numerically named directory.
first it searches upwards to see if a numeric directory name exists in path, if yes, the relative directory structure of the given path is moved on that level into a directory named like the given number.
if no numeric directory exists in path, and the current working directory is in path, a directory named like the given number is created in the current working directory and the given path is moved there. otherwise nothing happens.

## examples:
~~~
rate 2 /a/0/b/c -> /a/2/b/c
cwd: /a/b
rate 2 /a/b/c -> /a/b/2/c
cwd: /
rate 2 /a/b/c -> /2/a/b/c

## options
~~~
--help | -h
--interface  show a machine readable cli specification
~~~

# dependencies
* guile
* [sph-lib](https://github.com/sph-mn/sph-lib)

# license
* gpl3+

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

insert the contents of [other/uca.xml](other/uca.xml) between <action> and </action> in $HOME/.config/Thunar/uca.xml.

if uca.xml does not yet exist, it can be initialized with the following content or by creating the first custom command via the thunar gui.
~~~
<?xml version="1.0" encoding="UTF-8"?>
<actions>
</actions>
~~~
