# Colyseus Test
A simple test for HaxeFlixel games to communicate with a TypeScript server.<br>
Max players per server: *3* (server-side setting)

## NOTICE
I OBVIOUSLY DO **NOT** OWN THE CHARACTER IN HERE.<br>
<a href="https://en.wikipedia.org/wiki/Peter_Griffin">PETER GRIFFIN<a/> BELONGS TO <a href="https://en.wikipedia.org/wiki/Family_Guy">FAMILY GUY<a/>.<br>
I LACK ANY ASSOCIATION WITH THE TEAM BEHIND <a href="https://en.wikipedia.org/wiki/Family_Guy">FAMILY GUY<a/>.<br>
IF ANYONE UNDER OWNERSHIP OF HIM OR THE SHOW HE'S IN HAS A PROBLEM WITH HIM BEING HERE, PLEASE SUBMIT AN ISSUE & I'LL REPLACE HIM.<br>
THIS SOFTWARE TEST IS NOT MONETIZED.<br>
<br>
Also, if you use ANY source code from this repository you must credit <a href="https://github.com/DillyzThe1">DillyzThe1<a/> for his work.<br>
I spent an entire day researching the library to do this from the official <a href="https://docs.colyseus.io/">Colyseus documentation<a/>.<br>
After you've properly credited me for open source networing code, you may use the source code for anything you wish. *(Exceptions: Crimes & Assets. I do not own Peter Griffin.)*<br>

## Usage & Compiling
To use this software test, you must both run the server and compile the game.<br>
If you really don't want to compile the *game*, please <a href="https://github.com/DillyzThe1/Colyseus-Test/releases/latest/">download the latest software test here<a/>.

### Compling the Game
*Note: You can skip this entirely if you download a pre-compiled client <a href="https://github.com/DillyzThe1/Colyseus-Test/releases/latest/">here<a/>.*<br>
First, make sure you have <a href="https://haxe.org/download/">Haxe 4.2.5 or later<a/> installed.<br>
Next, follow the official <a href="https://haxeflixel.com/documentation/install-haxeflixel/">installing HaxeFlixel<a/> tutorial.<br>
Now open the source code of this repository in file explorer & command prompt (or any shell for that matter).<br>
Then in command prompt, type `haxelib install colyseus` and wait for the install.<br>
Finally, you can type `build.bat` (Windows Only) or `lime test windows -debug` (Windows/Linux/Mac) to compile & run it.<br>
<br>
*Note: If your game closes immediantly on startup, that's becuase your server is not running. Please follow the tutorial below.*

### Running the Server
First, download and install <a href="https://nodejs.org/en/download/">Node.js<a/>.<br>
Next, open the source code of this repository in file explorer.<br>
Now, you need to open command prompt (or any shell for that matter) in the `.server` folder of the source code.<br>
Type `npm install -g ts-node` into the command prompt, then just `npm install`.<br>
Finally, type `npm run server` or `ts-node index.ts` and wait until it says the server was created.