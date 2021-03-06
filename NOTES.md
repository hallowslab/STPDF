### TODO

  * Converter supports resizing by a percentage but neither the cli or gui is using this
  * Options to control the slider max value and tick interval in the gui




#### Notes

`img.rotate(-rotate,resample=Image.BICUBIC, expand=True)`
This tells it to use the highest quality interpolation algorithm that it has available,
and to expand the image to encompass the full rotated size instead of cropping.
The documentation does not say what color the background will be filled with.

[from here](https://stackoverflow.com/a/17822099)

##### Themes

**It seems that most of these values hadn't changes because the theme fusion wasn't set in the whole app**

  * To test:
    1. Most is tested there are still some stuff not being used below is a list of all possible objects that can have it's color changed
    * Active <- Selected item???
    * All <- I'm not even going to try this
    * AlternateBase <- no idea
    * Background <- changes background of window
    * Base <- changes background of QTextEdit and QComboBox but not window
    * BrightText
    * Button <- changes color of button background
    * ButtonText <- change the color of the button text but just QPushButton
    * ColorGroup <- ???
    * ColorRole <- ???
    * Current <- ???
    * Dark <- ???
    * Disabled <- Probably for disabled items like actions checkboxes and buttons, not tested
    * Foreground <- changes QLabel color
    * Highlight <- changes the highlight for QComboBox items and menu items
    * HighlightedText
    * Inactive
    * Light
    * Link <- I don't think there will be any links in the app...
    * LinkVisited <- same as above
    * Mid
    * Midlight
    * NColorGroups
    * NColorRoles
    * NoRole
    * Normal
    * PlaceholderText
    * Shadow
    * Text <- This seems to change most of the text, changes text from QComboBox, menu QAction, and QTextEdit
    * ToolTipBase <- seems to make no changes to TipSlider however it could be that i'm setting this the wrong way
    * ToolTipText <- same as above
    * Window <- seems to have no effect?
    * WindowText <- same as above

https://stackoverflow.com/questions/48256772/dark-theme-for-in-qt-widgets
https://gist.github.com/gph03n1x/7281135

###### The color groups:

The Active group is used for the window that has keyboard focus.
The Inactive group is used for other windows.
The Disabled group is used for widgets (not windows) that are disabled for some reason.

##### Deskewing

This requires the user to have tesseract installed

Tessseract is not easily available for windows [however](https://github.com/UB-Mannheim/tesseract/wiki)

>The Mannheim University Library (UB Mannheim) uses Tesseract to perform OCR of historical German newspapers (Allgemeine Preu??ische Staatszeitung, Deutscher Reichsanzeiger). The latest results with OCR from more than 360,000 scans are available online.
>Normally we run Tesseract on Debian GNU Linux, but there was also the need for a Windows version. That's why we have built a Tesseract installer for Windows.


##### Translation

`python C:\Python36\Tools\i18n\pygettext.py -d base -o locales/base.pot file.py`
this will generate a "base" pot in the locales folder, which can then be edited and generate the appropiate compiled translations

**for some reason [this](https://stackoverflow.com/a/3838090/9646483) seems necessary when running the app as an executable after building**

### however to work with all langs on all systems requires some modifications

```
current_locale, _ = locale.getdefaultlocale()
cl = current_locale.split("_")
if lang != cl[0]:
    # however this stupid hack seems to work
    current_locale = "%s_%s" % (lang, lang.upper())
lang = gettext.translation(modl,
                            "locale/", [current_locale])
lang.install()
```

All of the imported modules are not detected by pygettext so individual translations must be generated and the language must be inherited from the parent so that the module can be translated

Ex:
```
self.installed_lang = getattr(self.parent, "app_lang", None)
if self.installed_lang is None:
    # default to english strings
    gettext.install("stpdf-core")
else:
    self.installed_lang.install()
```

The current modules that use translated string are
* src/components.py
* src/stpdf/converter.py

the naming of the pot files should be "component.pot"
and the translated .po and .mo files should be "lang_component.po"


### Requirements

python3.7 is required

Linux requires the following packages `python3.7 python3.7-dev libpython3.7 libpython3.7-dev`

### Building

[Making Linux apps forward-compatible](https://pythonhosted.org/PyInstaller/usage.html#making-linux-apps-forward-compatible)