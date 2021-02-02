Function Get-DadJoke
{
    <#
    .SYNOPSIS
        Random Dad joke
    #>
	Invoke-RestMethod -Uri "https://icanhazdadjoke.com" -Headers @{accept="application/json"} |
		Select-Object -ExpandProperty Joke
}


Function Get-BrainyQuote
{
    <#
    .SYNOPSIS
        Get the quote of the day from BrainyQuote.com
    .PARAMETER Type
        You can select from the following quote categories:
            Today
            Art
            Funny
            Love
            Nature
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Position=0)]
        [ValidateSet("Today","Art","Funny","Love","Nature")]
        [string]$Type = "Today"
    )

    $Page = Switch ($Type)
    {
        "Today"    { "quotebr.rss" }
        "Art"      { "quotear.rss" }
        "Funny"    { "quotefu.rss" }
        "Love"     { "quotelo.rss" }
        "Nature"   { "quotena.rss" }
    }

    [xml]$Raw = Invoke-WebRequest -Uri "https://www.brainyquote.com/link/$Page" | Select-Object -ExpandProperty Content
    $Quote = $Raw.rss.channel.item | Select-Object -First 1
    Write-Output "$($Quote.Description)  --$($Quote.Title)"
}

