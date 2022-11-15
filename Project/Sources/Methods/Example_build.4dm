//%attributes = {}
/* internal method, only to build/update
handles component build, notarize (needs to run on Mac) for Client and Server

to use setup build application settings using dialog.requires to enter an Apple certificate
certificate such as "Developer ID Application: Companyname (id)"
follow https://blog.4d.com/how-to-notarize-your-merged-4d-application/

in case you have several xcode, select the 'good' one with
###########
sudo xcode-select -s /path/to/Xcode13.app

Tested with XCode 13. Minimum Version XCode 13, for older you need to use altool, see:
https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution/customizing_the_notarization_workflow/notarizing_apps_when_developing_with_xcode_12_and_earlier

Run XCode at least once manual to make sure it is correctly installed and license is accepted.
After an XCode/System update another manual run might be necesssary to accept modified license.

###########
expects that you have installed your password in keychain named "altool" with:
xcrun altool --list-providers -u "AC_USERNAME" -p secret_2FA_password
Sign in to your Apple ID account page. In the Security section, click the “Generate Password” option below the “App-Specific Passwords” option, enter a password label as requested and click the “Create” button.
If unclear, read Apple docu above!

###########  NOTES
you might need to start Xcode once manually after every macOS update to accept Xcode changes
you might need to start Xcode to accept Apple contract changes or update expired certificates (visit developer.apple.com)
*/

var $builder : cs:C1710._build

$builder:=cs:C1710._build.new()

var $progress : Integer
var $error; $sourcefolder : Object
var $buildpath; $settingsXML; $Found; $pathsettings; $value; $buildname; $clientpath; $serverpath; $clientzippath; $serverzippath; $target : Text
C_COLLECTION:C1488($sourcefolderfiles)

$progress:=Progress New
Progress SET MESSAGE($progress; "Compile...")

$error:=$builder.Compile()
If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Build...")
	$pathsettings:=File:C1566(Build application settings file:K5:60).platformPath
	$error:=$builder.Build($pathsettings)  // $1 could be path to settings, if you have other than default ones
End if 

$buildpath:=""
$settingsXML:=DOM Parse XML source:C719($pathsettings)
$Found:=DOM Find XML element:C864($settingsXML; "/Preferences4D/BuildApp/BuildMacDestFolder")
If (ok=1)
	DOM GET XML ELEMENT VALUE:C731($Found; $value)
	Case of 
		: ($value="::@")
			// cannot use Folder(fk database folder).parent, as we need to go outside of protected area
			$sourcefolder:=Folder:C1567(Get 4D folder:C485(Database folder:K5:14); fk platform path:K87:2)
			$sourcefolder:=Folder:C1567($sourcefolder.parent.platformPath+Substring:C12($value; 3); fk platform path:K87:2)
			$sourcefolderfiles:=$sourcefolder.folders()
			If ($sourcefolderfiles.length>0)
				$buildpath:=$sourcefolderfiles[0].platformPath
			End if 
		: ($value=":@")
			$sourcefolder:=Folder:C1567(Folder:C1567(fk database folder:K87:14).platformPath+Substring:C12($value; 2); fk platform path:K87:2)
			$sourcefolderfiles:=$sourcefolder.folders()
			If ($sourcefolderfiles.length>0)
				$buildpath:=$sourcefolderfiles[0].platformPath
			End if 
		Else 
			$buildpath:=$value
	End case 
End if 
$buildname:=""
$Found:=DOM Find XML element:C864($settingsXML; "/Preferences4D/BuildApp/BuildApplicationName")
If (ok=1)
	DOM GET XML ELEMENT VALUE:C731($Found; $buildname)
End if 
DOM CLOSE XML:C722($settingsXML)

// loop for Client + Server
$clientpath:=$buildpath+$buildname+" Client.app"
$clientzippath:=Replace string:C233($clientpath; ".app"; ".zip")
If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Zip Client...")
	$error:=$builder.Zip($clientpath; $clientzippath)
End if 
$serverpath:=$buildpath+$buildname+" Server.app"
$serverzippath:=Replace string:C233($serverpath; ".app"; ".zip")
If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Zip Server...")
	$error:=$builder.Zip($serverpath; $serverzippath)
End if 

If ($error.success=True:C214)
	$target:=$error.target
	Progress SET MESSAGE($progress; "Notarize Client and wait for Apple's approval...")
	$error:=$builder.Notarize($clientzippath)  // returned by zip
End if 

If ($error.success=True:C214)
	$target:=$error.target
	Progress SET MESSAGE($progress; "Notarize Server and wait for Apple's approval...")
	$error:=$builder.Notarize($serverzippath)  // returned by zip
End if 

If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Staple Client")
	$error:=$builder.Staple($clientpath)
End if 

If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Staple Server")
	$error:=$builder.Staple($serverpath)
End if 

Progress QUIT($progress)


If ($error.success=False:C215)
	ALERT:C41(JSON Stringify:C1217($error; *))
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($error; *))
End if 