# Broker App

This App helps brokers to handle thier data on the phone
If the broker works alone or its a company that has alot of workers

for single broker:
it has a login page to sign in.
contact page to save all his contacts into it, and not to interfere with the
smart phone contacts.
he can call and add notes and requests to each client, and whenever a request
is made , it will goes into the requests page, and always remind him about late requestes 
that is not full filled.

there is a map for the compound, and it has a feature to search for the request, and to add 
the data which the broker has directly on the map

for company:
the owner has the ability to asign new broker, activate him, and deactivate him
also he can limit the time the broker can access the app, so that he can not open it outside the
working time.

the app works on sqlite and Mysql
sqlite to save and load data fast
when new data is added, it will be added first on sqlite database
and the app check if there is a way to connect to the internet
if there is, it will save it to the server.
so that if any broker removed the app
he can easily install it, and it will get all the data back to his phone
and then he can work from the sqlite database for fast fetching of the data

NOTE: photos and recorded MSGs is not saved on the phone, only on server
so to access it, the phone will only show the player ui or photo ui, if there is an internet connection
