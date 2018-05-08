# Visual Studio Code Demo
On 05/07/2018 we demo'd Visual Studio Code.  We went over:

* Visual Studio Code Basics
* Visual Studio Code as a replacement for PowerShell ISE
* Using version control in Visual Studio Code
* Basic debugging with PowerShell in Visual Studio Code

# Suggested Extensions

| Extension Name | Description |
|--------------- |-------------|
| [PowerShell](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell) | Adds powershell support |
| [Beautify](https://marketplace.visualstudio.com/items?itemName=HookyQR.beautify)| Formats javascript, JSON, CSS, Sass, and HTML |
| [Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer) | Uses different colored bracket pairs to help distinguish pairs |
| [Git History](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory) | View and search git log |
| [gitignore](https://marketplace.visualstudio.com/items?itemName=codezombiech.gitignore) | Assists with `.gitignore` files |
| [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme) | Nice looking theme |
| [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) | Sync your VSCode settings between computers |
| [Git Tags](https://marketplace.visualstudio.com/items?itemName=howardzuo.vscode-git-tags) | Git tags support for VSCode

# Adding Region Snippet to VSCode
*Thanks to [Justin D](https://www.meetup.com/members/188309832/) for submitting this.*

Open up `Configure User Snippets` with the Command Pallet `Ctrl + Shift + P` or `F1` and select `Preferences: Configure User Snippets`.
![Screenshot](https://i.imgur.com/VfCaLbh.png)

Select powershell
![Screenshot](https://i.imgur.com/TEvWuuC.png_)

Add the following code to your `powershell.json` snippet file:

```json
"add_region": {
    "prefix": "Snippet - Insert region",
    "description": "Insert a region",
    "body": [
        "#region MyRegion",
        "$TM_SELECTED_TEXT",
        "#endregion"
    ]
}
```

Optional: Add keybinding to the new snippet.  Open `Preferences: Open Keyboard Shortcuts`
![Screenshot](https://i.imgur.com/5zkZ3yK.png)

Click `For advanced customizations open and edit keybindings.json`.
![Screenshot](https://i.imgur.com/JrPoHvY.png)

Paste the following into your `keybindings.json` file:

```json
{
    "key": "ctrl+r ctrl+r",
    "command": "editor.action.insertSnippet",
    "args": {
        "name": "add_region"
    }
}
```

That will set `Ctrl + r + Ctrl + r` (`Ctrl + r` twice in a row) as your keybinding for the `add_region` snippet.

![Screenshot](https://i.imgur.com/DMo65wM.gifv)

# Additional Resources
There are a ton of Visual Studio Code resources out there.  Here't Microsoft's official Tips and Tricks page:
https://github.com/Microsoft/vscode-tips-and-tricks