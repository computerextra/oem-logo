$compress = @{
    Path             = ".\OEM Logo", ".\OEM Info", ".\StanSoft"
    CompressionLevel = "Fastest"
    DestinationPath  = ".\OEMLogo.zip"
}

Compress-Archive @compress