<div style="text-align: center;">
  <a href="https://www.onlyoffice.com/download-desktop?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage#linux">
    <img alt="Platform" src="https://img.shields.io/badge/Platform-Linux-blue.svg?style=flat&logo=linux" />
  </a>
  <a href="https://www.gnu.org/licenses/agpl-3.0.en.html">
    <img alt="License" src="https://img.shields.io/badge/License-GNU%20AGPL%20V3-green.svg?style=flat" />
  </a>
</div>

<h1>AppImage for ONLYOFFICE Desktop Editors</h1>

Welcome\! This repo provides everything you need to run ONLYOFFICE Desktop Editors on your machine using AppImage.

## **What is ONLYOFFICE Desktop Editors?**

[ONLYOFFICE Desktop Editors](https://www.onlyoffice.com/desktop?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage) is a free, open-source office suite pack that allows you to create, view and edit office docs stored on your PC without an Internet connection. Along with offline work, it’s possible to connect the application to the cloud for online document collaboration. It’s fully compatible with Microsoft Office formats (DOCX, XLSX, PPTX) and provides a complete set of tools for all your document needs.

The suite includes:

* **✍️ [Document Editor](https://www.onlyoffice.com/word-processor?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage):** For creating and formatting text documents of any complexity.  
* **📊 [Spreadsheet Editor](https://www.onlyoffice.com/sheets?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage):** For managing and analyzing data with powerful tools, formulas, and charts.  
* **🖥️ [Presentation Editor](https://www.onlyoffice.com/slides?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage):** For designing stunning, professional presentations with a variety of creative tools.  
* **📝 [Form Creator](https://www.onlyoffice.com/form-creator?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage):** For building and filling out complex, fillable PDF forms.  
* **✂️ [PDF Editor](https://www.onlyoffice.com/pdf-editor?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage):** For viewing, annotating, and converting your PDF files.  
* **🖼️ [Diagram Viewer](https://www.onlyoffice.com/diagram-viewer?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage):** For viewing diagrams and flowcharts from Visio and other popular formats.

### AI integration 🤖

Connect any AI model (local or cloud-based) for tasks like chatbot requests, translation, OCR, etc. Use AI agents to generate new files, list folder contents, preview file details without opening them in the editor, auto-fill forms with provided data, etc. [More info about AI tools](https://www.onlyoffice.com/ai-assistants?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage)

## **How to get started with AppImage 🛠️**

Running the AppImage is a simple, three-step process that can be done entirely through the terminal.

### **Step 1: Download the AppImage**

Download the latest version from our official website using the wget command. This will save the file directly into your current directory.
```
$ wget https://download.onlyoffice.com/install/desktop/editors/linux/DesktopEditors-x86_64.AppImage
```
### **Step 2: Make it executable**

Before you can run the AppImage, you need to give the file permission to be executed. The ```chmod a+x``` command makes the file executable for all users on the system.

```
$ chmod a+x DesktopEditors-x86_64.AppImage
```
### **Step 3: Run the editors**

Now you can launch the application directly from your terminal. Just execute the file you downloaded.
```
$ ./DesktopEditors-x86_64.AppImage
```
Perfect! The ONLYOFFICE Desktop Editors suite will now start. You've done it! You can begin creating and editing your documents immediately.

## **For developers: Building from source 👨‍💻**

If you prefer to build the AppImage from the source code yourself, follow these steps.

### **Step 1: Install dependencies**

First, ensure you have the necessary tools to build the project. This command installs ```build-essential```, ```git```, and ```wget``` on Debian-based systems like Ubuntu.
```
sudo apt-get install --force-yes -yq \  
    build-essential \  
    git \  
    wget
```
### **Step 2: Get the source code**

Clone this repository to download the build scripts and configuration files to your local machine.
```
git clone https://github.com/ONLYOFFICE/appimage-desktopeditors.git
```
### **Step 3: Compile the AppImage**

Navigate into the project directory you just cloned and run the make command. This will clean any previous builds and then compile the new AppImage.
```
cd appimage-desktopeditors  
make clean && make
```
Once the process is complete, the compiled AppImage will be available in the project folder, ready to run.

## **Useful links & resources 🔗**

* **Official website:** Click [here](https://www.onlyoffice.com/desktop?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage) to learn more about ONLYOFFICE Desktop Editors.
* **Main GitHub repository:** Check out the [source code](https://github.com/ONLYOFFICE/DesktopEditors) for the complete project information. 
* **Help Center (Tutorials):** Learn [how to work with the app](https://helpcenter.onlyoffice.com/desktop?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage). 

## **Need help or have an idea? Get support here 💡**

* **🐞 Found a bug?** Please report it by creating an issue [here](https://github.com/ONLYOFFICE/appimage-desktopeditors/issues).  
* **❓ Have a question?** Ask our community and developers on the [ONLYOFFICE Forum](https://community.onlyoffice.com).  
* **💡 Want to suggest a feature?** Share your ideas on our [feedback platform](https://feedback.onlyoffice.com/forums/966080-your-voice-matters).
* **🧑‍💻 Need help for developers?** Check our [API documentation](https://api.onlyoffice.com/?utm_source=github&utm_medium=cpc&utm_campaign=GitHubAppImage).