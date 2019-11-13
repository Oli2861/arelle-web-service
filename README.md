### How to reproduec
1. `docker build . -t arelle-demo:daims-zip`
1. `docker run arelle-demo:daims-zip -p 8080`
1. `docker ps` - see container name or id
1. `docker exec -t -i <container name or id> /bin/sh`
1. `arelleCmdLine -f /app/AppropriationsAccountPackage.xbrl -v --plugins xbrlDB --store-to-XBRL-DB "localhost,5432,user,111111,test_db,600,pgSemantic"`

Expected result `AppropriationsAccountPackage.xbrl` imported into postgres db
Actual result container consumed a lot of memory and finally `Killed`

Http request with AppropriationsAccountPackage.xbrl works from time to time (but consumes about 7.5Gb) 
```
GET http://localhost:8080/rest/xbrl/view?file=/app/AppropriationsAccountPackage.xbrl&view=factTable&media=html     
```

Http request with FinancialAccountPackage.xbrl holds forever 
```
GET http://localhost:8080/rest/xbrl/view?file=/app/FinancialAccountPackage.xbrl&view=factTable&media=html     
```
  
