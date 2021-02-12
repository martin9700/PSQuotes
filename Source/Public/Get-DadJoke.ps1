Function Get-DadJoke
{
    <#
    .SYNOPSIS
        Random Dad joke
    #>
	Invoke-RestMethod -Uri "https://icanhazdadjoke.com" -Headers @{accept="application/json"} |
		Select-Object -ExpandProperty Joke
}