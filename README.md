# `.dotfiles`

## Usage

* Clone this repository into `~`.
* Install [GNU Stow](http://www.gnu.org/software/stow/)
    * Or if on Windows, use the included `stow.py`
* Use `stow` (or `stow.py` as necessary) to install the dotfiles by package, like so:

```
bash$ stow bash
bash$ stow git
...
PS> python stow.py windows
```

## References

* [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
