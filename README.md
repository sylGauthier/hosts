# Description

This is a small and efficient hosts file generator, that lets you select
categories of websites you want to filter and redirect to 0.0.0.0

# Configuration

Before anything, edit the `select` file to select website categories that you
want to filter. This file should have one directory name per line, the
directories are the ones contained in the `modules` directory. For example, to
ban all malware, spying, tracking, scamming website (contained in `base`) as
well as gambling and facebook and reddit but keep other social media, your
`select` file should look like:

```
base/
gambling/
social/facebook
social/reddit
```

You can then allow specific websites included in a banned category by editing
the `unselect` file. For instance, if you banned all social media by adding a
line `social/` in the `select` file, but you still want to use Whatsapp, your
`unselect` file should look like:

```
social/whatsapp
```

You can also specify custom redirections in the `header/hosts` file, that will
be appended at the top of the final `hosts` file.

# Installation

Once you have configured your `select` and `unselect` files, simply run:

```
sudo make install
```
