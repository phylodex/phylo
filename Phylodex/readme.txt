==========================================================================================
CMPT 275 GROUP 11: Phylodex

Author: Steve King
Data: June 23, 2013

Readme: Version 2
==========================================================================================

If you are running this on the simulator, the capture mode will not work. Also, It might
be necessary to comment out line 231 in PXAppDelegate.m, below the comment "FOR DEVELOPMENT 
PURPOSES: DELETES THE STORE". Then stop the program, and re-comment it. This process 
deletes any existing data store that is in conflict with the one the app is trying to access.

Known Errors
------------
There was a server error retrieving the images. This is the xml returned when there was an error:

<?xml version="1.0" encoding="UTF-8"?>
<errors>
<error>Your query could not be completed, due to a technical issue.  This issue has been noted and NatureServe is working to resolve it as quickly as possible.</error>
</errors>

Try with this query:
http://www.natureserve.org/imagerepository/GetImage?SRC=2&BATCH=10&FMT=jpg&RES=768X512&NAME=mallard

We did test the function before the server error, and images can be downloaded from the web service.
Not all animals will return images. Known searches with images include: Sea Otter, Mallard, American
Black Bear, Golden Eagle.