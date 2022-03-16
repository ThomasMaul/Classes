<!-- build + notarize class for Mac -->
# _build_

This class helps to to build, notarize and zip components, clients or server application.
Configured correctly, it allows doing the full component building (from compile, build, zip, notarize, stamp), similar to Client/Server Applications.

You need to register your Apple App password for notarization upfront to Apple's keychain for "notarytool". To learn about doing so, see (Apple Documentation)[https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution/customizing_the_notarization_workflow]
‚

## Example
For full example how to build a Client/Server app see method "Example_build". For an example how to automate component building, see my component "FileTransfer" on Github


## new

### cs._build__.new()

creates and returns a _build object.

#### Description

Builds the object


### .Compile({$options: Object}) -> $error : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|options|Object|->|compile options|
|error|Object|<-|result object|  

#### Description
Run Compile project. See 4D documentation for options content. Result is directly returned.


### .Build({$PathToSettings: Text}) -> $error : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|PathToSettings|Text|->|platform path to build settings|
|error|Object|<-|result object|  

#### Description
Run BUILD APPLICATION, either with default settings file or with the given one. Use the Build Application dialog upfront to create your settings - or manipulate it using Text Editor or language.

Returns $error.success with true/false, if false with $error.log with details.


### .Zip({$sourcepath: Text; $targetpath: Text}) -> $error : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|sourcepath|Text|->|platform path to source|
|targetpath|Text|->|platform path to target.zip|
|error|Object|<-|result object|  

#### Description
Zip the given source using Apple's ditto command in the format as expected to notarize.
If sourcepath is not passed, it tries to find component location based on prevoius .Build().
If targetpath is not passed, it uses sourcepath and replace file extension with .zip

Returns $error.success with true/false, if false with $error.reason with details.


### .Notarize({$zippath: Text}) -> $error : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|zippath|Text|->|platform path to source|
|error|Object|<-|result object|  

#### Description
Uploads the given zip to Apple and waits for notarization.

Returns $error.success with true/false, if false with $error.log with more details. If application was successfully uploaded but rejected by Apple, rejection details are in $error.invalid, the job ID is in $error.id



### .Staple({$sourcepath: Text}) -> $error : Object
|Parameter|Type||Description|
|---------|--- |:---:|------|
|sourcepath|Text|->|platform path to source|
|error|Object|<-|result object|  

#### Description
After a successful .Notarize() call, run .Staple() to assign the ticket as returned by Apple to the source application.

Note: tickets can only be assigned to source, not to a zip. The zip was only needed to upload for notarization. For deployment, the source is automatically zipped again, now including the ticket. If you deploy using .dmg format, just use the source files and copy them into the dmg.





