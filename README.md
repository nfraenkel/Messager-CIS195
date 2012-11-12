Messager-CIS195
===============

message reader and sender for CIS195

--- by Nathan Fraenkel

DESIGN CHOICES
    - refresh button just calls getMessages
    - network spinner to show network activity of POSTing, GETing
    - users can select messages, view them in detailVC
    - clicking '+' brings up a modal VC where they can enter new message information. clicking 'Done' will make POST request. Modal closes ONLY upon successful confirmation from connection
    - alert views for user to retry or not upon failed GET or POST

