Function Get-DadJoke
{
    <#
    .SYNOPSIS
        Random Dad joke
    .NOTES
        Author:             Martin Pugh
        Twitter:            @thesurlyadm1n
        Spiceworks:         Martin9700
        Blog:               www.thesurlyadmin.com

        Changelog:
            2/11/21         Initial Release to PowerShellGallery
    #>
	Invoke-RestMethod -Uri "https://icanhazdadjoke.com" -Headers @{accept="application/json"} |
		Select-Object -ExpandProperty Joke
}