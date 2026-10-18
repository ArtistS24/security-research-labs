# test-ua-cloaking.ps1
# Tests CTFtime writeup endpoint with a large UA list to detect content cloaking
# Flags any response that contains the canary indicators

$ErrorActionPreference = "Continue"
$TargetUrl = "https://ctftime.org/writeup/40845"
$CanaryStrings = @("ctfti.me", "ctftimecanary", "llm-exp", "6fc9b35adab50fbbacb1d44cf61727db54554218")

# User-Agents to test - browsers, AI bots, scrapers, search crawlers, custom guesses
$UserAgents = @(
    # Real browsers
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Safari/605.1.15",
    "Mozilla/5.0 (X11; Linux x86_64; rv:121.0) Gecko/20100101 Firefox/121.0",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X) AppleWebKit/605.1.15",

    # Anthropic / Claude
    "ClaudeBot/1.0",
    "ClaudeBot/1.0 (+https://www.anthropic.com/claudebot)",
    "Claude-Web/1.0",
    "Claude-Web",
    "anthropic-ai",
    "anthropic-ai/1.0",
    "Anthropic-AI",
    "Anthropic",
    "claude-bot",

    # OpenAI / GPT
    "GPTBot/1.0",
    "GPTBot/1.2 (+https://openai.com/gptbot)",
    "ChatGPT-User",
    "ChatGPT-User/1.0",
    "OAI-SearchBot",
    "OpenAI",

    # Google AI
    "Google-Extended",
    "GoogleOther",
    "Bard",
    "Gemini",

    # Other AI/LLM
    "PerplexityBot/1.0",
    "PerplexityBot",
    "YouBot",
    "Meta-ExternalAgent",
    "FacebookBot",
    "Bytespider",
    "Amazonbot",
    "Applebot-Extended",
    "Diffbot",
    "CCBot/2.0",

    # Search engines
    "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
    "Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)",
    "DuckDuckBot/1.1",

    # Scrapers
    "python-requests/2.31.0",
    "Python-urllib/3.11",
    "Scrapy/2.11",
    "Wget/1.21",
    "curl/8.5.0",
    "Go-http-client/2.0",
    "node-fetch/1.0",
    "axios/1.6.0",

    # Generic / suspicious
    "bot",
    "crawler",
    "spider",
    "scraper",
    "fetch",
    "llm",
    "ai-agent"
)

Write-Host "==> Testing $($UserAgents.Count) user-agents against $TargetUrl" -ForegroundColor Cyan
Write-Host "==> Looking for canary indicators: $($CanaryStrings -join ', ')" -ForegroundColor Cyan
Write-Host ""

$Results = @()
$FoundCanary = $false

foreach ($UA in $UserAgents) {
    $UADisplay = if ($UA.Length -gt 50) { $UA.Substring(0, 47) + "..." } else { $UA }

    try {
        $Response = curl.exe -s -A $UA --max-time 10 -w "`n---HTTP_STATUS:%{http_code}---" $TargetUrl 2>&1
        $ResponseStr = $Response -join "`n"

        # Parse status code
        $Status = "ERR"
        if ($ResponseStr -match "---HTTP_STATUS:(\d+)---") {
            $Status = $matches[1]
        }

        # Check for canary
        $CanaryHits = @()
        foreach ($Canary in $CanaryStrings) {
            if ($ResponseStr -match [regex]::Escape($Canary)) {
                $CanaryHits += $Canary
            }
        }

        $Result = [PSCustomObject]@{
            UserAgent  = $UA
            Status     = $Status
            CanaryHit  = $CanaryHits.Count -gt 0
            Indicators = ($CanaryHits -join ", ")
            BodyLength = $ResponseStr.Length
        }
        $Results += $Result

        if ($CanaryHits.Count -gt 0) {
            $FoundCanary = $true
            Write-Host "[HIT] $Status | $UADisplay" -ForegroundColor Red
            Write-Host "       Indicators: $($CanaryHits -join ', ')" -ForegroundColor Yellow
        } else {
            $StatusColor = if ($Status -eq "200") { "Green" } elseif ($Status -eq "403") { "DarkYellow" } else { "Gray" }
            Write-Host "[---] $Status | $UADisplay" -ForegroundColor $StatusColor
        }
    } catch {
        Write-Host "[ERR] --- | $UADisplay" -ForegroundColor DarkGray
        $Results += [PSCustomObject]@{
            UserAgent  = $UA
            Status     = "ERROR"
            CanaryHit  = $false
            Indicators = $_.Exception.Message
            BodyLength = 0
        }
    }

    Start-Sleep -Milliseconds 200
}

Write-Host ""
Write-Host "==> Summary" -ForegroundColor Cyan
Write-Host "Total tested:  $($Results.Count)"
Write-Host "200 OK:        $(($Results | Where-Object Status -eq '200').Count)"
Write-Host "403 Forbidden: $(($Results | Where-Object Status -eq '403').Count)"
Write-Host "Other:         $(($Results | Where-Object { $_.Status -notin '200','403' }).Count)"
Write-Host "Canary hits:   $(($Results | Where-Object CanaryHit -eq $true).Count)" -ForegroundColor $(if ($FoundCanary) { "Red" } else { "Green" })

if ($FoundCanary) {
    Write-Host ""
    Write-Host "==> POSITIVE HITS (UA-based content variation detected)" -ForegroundColor Red
    $Results | Where-Object CanaryHit -eq $true | Format-Table UserAgent, Status, Indicators -AutoSize
} else {
    Write-Host ""
    Write-Host "==> No UA-based canary injection detected in any tested user-agent." -ForegroundColor Green
    Write-Host "    CTFtime's HTML response does NOT contain canary strings for any of these UAs."
}

# Export full results
$ResultsPath = Join-Path $PSScriptRoot "ua-test-results.csv"
$Results | Export-Csv -Path $ResultsPath -NoTypeInformation
Write-Host ""
Write-Host "==> Full results saved to: $ResultsPath" -ForegroundColor Cyan
