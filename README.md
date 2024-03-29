[![License](https://img.shields.io/badge/License-GNU%20AGPL%20V3-green.svg?style=flat)](https://www.gnu.org/licenses/agpl-3.0.en.html)

## Overview

ONLYOFFICE Desktop Editors is a free office suite that combines text, spreadsheet and presentation editors allowing to create, view and edit documents stored on your Windows/Linux PC or Mac without an Internet connection. It is fully compatible with Office Open XML formats: .docx, .xlsx, .pptx.

## Functionality

ONLYOFFICE Desktop Editors include the following editors:

* ONLYOFFICE Document Editor
* ONLYOFFICE Spreadsheet Editor
* ONLYOFFICE Presentation Editor
 
The editors allow you to create, edit, save and export text, spreadsheet and presentation documents.

## Getting started

    $ wget https://download.onlyoffice.com/install/desktop/editors/linux/DesktopEditors-x86_64.AppImage
    $ chmod a+x DesktopEditors-x86_64.AppImage
    $ ./DesktopEditors-x86_64.AppImage

## Building ONLYOFFICE Desktop Editors AppImage from source code
### Installing dependency
```
sudo apt-get install --force-yes -yq \
    build-essential \
    git \
    wget
```
### Getting source code
```
git clone https://github.com/ONLYOFFICE/appimage-desktopeditors.git
```
### Compiling AppImage 
```
cd appimage-desktopeditors
make clean && make
```
## Project Information

Official website: [https://www.onlyoffice.com/desktop.aspx](https://www.onlyoffice.com/desktop.aspx?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppimage)

Code repository: [https://github.com/ONLYOFFICE/DesktopEditors](https://github.com/ONLYOFFICE/DesktopEditors "https://github.com/ONLYOFFICE/DesktopEditors")

## User Feedback and Support

If you have any problems with or questions about ONLYOFFICE Desktop Editors, please visit our official forum to find answers to your questions: [forum.onlyoffice.com][1] or you can ask and answer ONLYOFFICE development questions on [Stack Overflow][3].

  [1]: https://forum.onlyoffice.com
  [2]: https://github.com/ONLYOFFICE/DocumentServer
  [3]: http://stackoverflow.com/questions/tagged/onlyoffice
