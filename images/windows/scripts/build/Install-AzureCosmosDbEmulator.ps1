####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "AB040B9A0FBC4766E179554B9899B947C41E3A259F8A0FC63022DB8D0C562769" # 7BAFEE9F90272C01F7924A1D8E62EE0954F555E229C7166B8

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
