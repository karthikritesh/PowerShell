$date= get-date -Format "HH:mm"
$day= get-date -Format "dddd"
$RAM= (Get-counter '\Memory\Available Mbytes').CounterSamples.Cookedvalue
$CPU= (Get-counter '\Processor(_total)\% Processor Time').CounterSamples.Cookedvalue
Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.rate= 0.6
$speak.SelectVoice('Microsoft Zira Desktop')
$speak.volume= 80
#####$speak.GetinstalledVoices() | ForEach{$_.VoiceInfo}-U can select different voice if you need.
$speak.speak("Hi Karthik, Welcome back")
function Monday
    {
        $speak.speak("Today is motivational $day and the time is $date, your recently used applications will open soon")
    }
function Tuesday
    {
        $speak.speak("Today is taco $day and the time is $date, your recently used applications will open soon")
    }
function Wednesday
    {
        $speak.speak("Today is workout $day and the time is $date, your recently used applications will open soon")
    }
function Thursday
    {
        $speak.speak("Today is thoughtfull $day and the time is $date, your recently used applications will open soon")
    }
function Friday
    {
        $speak.speak("Today is fashion $day and the time is $date, your recently used applications will open soon")
    }
function Saturday
    {
        $speak.speak("Today is fun $day and the time is $date, your recently used applications will open soon")
    }
function Sunday
    {
        $speak.speak("Today is party $day and the time is $date, your recently used applications will open soon")
    }
if($day -eq "Monday")
    {
      Monday;  
    }
    if($day -eq "Tuesday")
        {
            Tuesday;
        }
        if($day -eq "Wednesday")
            {
                Wednesday;
            }
            if($day -eq "Thursday")
                {
                    Thursday;
                }
                if($day -eq "Friday")
                    {
                        Fiday;
                    }
                    if($day -eq "Saturday")
                        {
                            Saturday;
                        }
                        if($day -eq "Sunday")
                            {
                                Sunday;
                            }

#starting Chrome
Start chrome
#Stop Teams
Get-Process "Teams" -ErrorAction SilentlyContinue | Stop-Process
# change to the correct directory
Set-Location ($ENV:USERPROFILE + '\AppData\Local\Microsoft\Teams')
#start mwatch in edge browser
[system.Diagnostics.Process]::Start("msedge","https://sdp.mymwatch.com")
# start Teams
Start-Process -File "$($env:USERProfile)\AppData\Local\Microsoft\Teams\Update.exe" -ArgumentList '--processStart "Teams.exe"'
start-sleep -seconds 4
    if(($CPU -lt 90) -and ($RAM -gt 5000))
        {
            $speak.speak("Your RAM & CPU usage is normal, have a nice day")
        }
        else {
            $speak.speak("Your RAM & CPU usage is not normal, I think you should try restarting your laptop")
        }
Function Get-Weather {
    [CmdletBinding()]
              
    # Parameters used in this function
    Param
    (
        [Parameter(Position=0, Mandatory = $True, HelpMessage="Provide city name", ValueFromPipeline = $true)] 
        $City
    ) 
      
    $ErrorActionPreference = "Stop"
    $WeatherResults = @()
    $Uri = "https://www.weatherbit.io/api/location/search/?query=" + "$City"
     
    Try
    {
        $Location = Invoke-WebRequest -URI $Uri
    }
    Catch
    {
        $_.Exception.Message
        Break
    }
 
    If($Location)
    {
        $Location = $Location.content | ConvertFrom-Json
        $Woeid = $Location.woeid
        $WeatherLink = "https://www.weatherbit.io/api/location/" + $Woeid + "/"
     
        Try
        {
            $Weather = Invoke-WebRequest -URI $WeatherLink
        }
        Catch
        {
            $_.Exception.Message
            Break
        }
     
        If($Weather)
        {
            $Weather = $Weather.content  | ConvertFrom-Json
            $Results = $Weather.consolidated_weather[0]
 
            $Object = New-Object PSObject -Property @{ 
     
                State                  = $Results.weather_state_name
                Date                   = $Results.created
                "Temperature(Min)"     = $Results.min_temp  
                "Temperature(Max)"     = $Results.max_temp          
                WindSpeed              = $Results.wind_speed
                WindDirection          = $Results.wind_direction_compass
                AirPressure            = $Results.air_pressure
                Predictability         = $Results.predictability     
            }
 
                $WeatherResults += $Object
        }
    }
 
    If($WeatherResults)
    {
        Write-Host "`nWeather for " -NoNewline
        Write-Host "$City" -ForegroundColor Green -NoNewline
 
        $WeatherResults | select State,Date,"Temperature(Min)","Temperature(Max)",WindSpeed,WindDirection,AirPressure,Predictability
    }
 
}
$today_weather=Get-Weather -City Bangalore
$state= $today_weather.State
[int]$temperature= $today_weather.'Temperature(Min)'
$speak.speak("the current weather is $state and the temperature is $temperature degree celcius")
if($temperature -lt "20"){
        $speak.Speak("The weather is nice today, enjoy!!")
    }
else{
        start-sleep -Seconds 2
        $speak.Speak("The weather is hotter today, you better stay home")
    }
exit;
