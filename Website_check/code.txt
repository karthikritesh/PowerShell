$file_name=get-date -format "MM_dd_yyyy"    #logfile creation for storing logs
$HTTP_Request = [System.Net.WebRequest]::Create('example.com')   #sending HTTP request for given URL
$HTTP_Response = $HTTP_Request.GetResponse()    #response function from requested site
   if($HTTP_Response -eq $null)
	{
	   #commands to be executed
           Restart-computer xxx
	}
   else{
	write-host "site is reachable" 
       }
