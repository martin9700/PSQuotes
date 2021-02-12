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
    .PARAMETER Author
        You can also get quotes from a favorite author. 
            1. Go to: https://www.brainyquote.com/authors
            2. Click on your author
            3. Find the author name in the Address Bar
                a. Example: https://www.brainyquote.com/authors/a-boogie-wit-da-hoodie-quotes
                b. Author name would be: a-boogie-wit-da-hoodie
            4. Put that into the Author parameter
    #>
    [CmdletBinding(DefaultParameterSetName="type")]
    Param (
        [Parameter(Position=0,
            ParameterSetName="type")]
        [ValidateSet("Today","Art","Funny","Love","Nature")]
        [string]$Type = "Today",

        [Parameter(Position=0,
            ParameterSetName="author")]
        [string]$Author
    )

    If ($PSCmdlet.ParameterSetName -eq "type")
    {
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
        Write-Output "$($Quote.Description) - $($Quote.Title)"
    }
    ElseIf ($PSCmdlet.ParameterSetName -eq "author")
    {
        $Author = $Author -replace "-quotes"
        $Author = $Author -replace "https://www\.brainyquote\.com/authors"

        $Quotes = Invoke-WebRequest -URI "https://www.brainyquote.com/authors/$Author-quotes"
        $Quote = $Quotes.Images.Alt | Where-Object { $_ -ne "BrainyQuote" } | Get-Random
        Write-Output $Quote
    }
}
