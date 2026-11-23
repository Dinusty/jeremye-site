# Downloads all images from jeremye.dev (Squarespace) into .\images\<section>\
# Run: right-click this file > "Run with PowerShell"
$ErrorActionPreference = "Continue"
$root = Join-Path $PSScriptRoot "images"
$ok=0; $fail=0
$list = @(
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/8d6e1142-6296-4cb4-a013-8b623f7334f4/OutlawsDLC2.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/c0870ca7-0c8c-4793-ab43-4b30256b7c76/SWOutlaws.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/a34122bf-8bf7-4fd2-821a-41cded132ed6/Wony.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/c59fd639-ad4d-4ef6-9db0-a837dfceb5b7/Div2.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/39b4be32-b58a-4b12-9249-eb297df1280d/Survival.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/1d8bc2d0-39cb-4a78-9075-406994b60e10/Thedivision.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/30e88a66-1cb8-4b03-883f-c7b755be3b09/Forza5.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/22c58b0e-6c87-4294-b9ac-879b3b30e5f7/ShadowofMordor.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/e42e2f0f-5b06-411d-ae34-d63f5c04c208/Skrillex.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/6eeaa304-d7e2-4a35-a407-e666b33cc718/Gotham.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/fc67bd9d-83ee-4c8f-b66f-628dca7b8491/WarintheNorth.png"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/3377e5b6-f0bc-4324-96ec-33f307e3fe41/Saw.jpg"),
  @("home", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/5500a2bc-4362-4d01-8293-dbb0a815aa84/Pirate.jpg"),
  @("pirates-fortune", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/0adf1659-3f5b-48f0-b311-2a510b0d9b40/joel-westman-dlc2-starwarsoutlaws-portfolio-nebula-joel-westman-04.jpg"),
  @("pirates-fortune", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/fb7acd3f-80a1-411e-a32d-0788c0405272/joel-westman-dlc2-starwarsoutlaws-portfolio-nebula-joel-westman-05.jpg"),
  @("pirates-fortune", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/d3b08963-3564-4673-b081-8566a58c1268/wouter-gillioen-dlc2-starwarsoutlaws-asteroid-02-min.jpg"),
  @("pirates-fortune", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/bb271979-774e-4785-bb46-0483a1028834/wouter-gillioen-dlc2-starwarsoutlaws-asteroid-07-min.jpg"),
  @("pirates-fortune", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/28234bbf-dcce-4941-9474-6f544bc92866/wouter-gillioen-dlc2-starwarsoutlaws-burialchamber-07-min.jpg"),
  @("pirates-fortune", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/0d3a0923-a263-4f3a-b0d8-4d7d78ed28b7/wouter-gillioen-dlc2-starwarsoutlaws-burialchamber-08-min.jpg"),
  @("pirates-fortune", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/7257503f-5824-47d2-bcd0-f2012811c04e/wouter-gillioen-dlc2-starwarsoutlaws-asteroid-03-min.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/14459838-0af3-40cb-860e-ad5fd836f3cb/wouter-gillioen-starwarsoutlaws-portfolio-shipwreck-01.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/d8e86b0b-2184-44b4-ae15-824dbf6740dc/melodie-delamourd-melodiedelamourd-starwarsoutlaws-portfolio-tos-cantina-entrance03.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/790405bc-4995-483a-8bfa-b0cdfb8191fc/wouter-gillioen-starwarsoutlaws-portfolio-substation-10.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/44fd58a5-9e03-4965-a259-08c96ea3efb7/rodrigo-lloret-crespo-starwarsoutlaws-portfolio-rodrigo-lloret-26.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/f648484e-9f3b-4253-a6c9-e74a9ec6ec73/zack-parkinson-starwarsoutlaws-moseisley-cantina-01.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/daa6f719-38b3-47e8-92df-6e0a99c7e8cb/raphael-tavares-starwarsoutlaws-portfolio-raphaeltavares-01.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/794fcd12-6d76-445a-bb34-ad3ab4a1ceba/alberto-viapiano-starwarsoutlaws-portfolio-palace-04.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/57d23440-2836-4805-a788-aa05904b07d1/maarten-hof-trailblazer-02.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/46558a9a-1f94-4af8-a2ee-1718507b42d1/zack-parkinson-starwarsoutlaws-mq-050-06.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/729e43f5-343f-4f9a-866b-a0cc4910f1ab/james-rinere-gameinformercover-final-nologo.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/25e66bd3-b9ad-487e-87fe-a12dc3abe8da/20004938-8f0cd3c2.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/5a26da9d-f56a-44be-a5ff-9f36aac003cd/EDGE-Mag-Cover-Top-100-games-to-watch-number-1.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/60745606-36ec-4c67-8873-0a0048c572c8/GWOy2wiWkAA4iUt.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/c1c01adb-91eb-4c43-8f79-cde08d008a7b/GWOzy1jWIAAAw98.jpg"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/8248c0f4-d6bc-43db-8a37-d94afcedf3d3/IMG_0462.png"),
  @("outlaws", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/4fcda5b5-6dea-402b-98c8-ba12afa877fc/457524813_8744308285583229_8689598404828727925_n.jpg"),
  @("blog", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/67bc3133-289c-4b24-afff-5b24046278fc/Communities.png"),
  @("site", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/fc0f7902-ed00-41a5-8fb5-8202dc27ca9a/MainBanner.png"),
  @("site", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/1739828960083-K1GN5MI12VK9OM93ZU0Y/unsplash-image-zpxKdH_xNSI.jpg"),
  @("site", "https://images.squarespace-cdn.com/content/v1/67b0b90b82865c43b831e4b3/1741068506964-769RJCMCYMBKWV93U1GF/unsplash-image-zpxKdH_xNSI.jpg")
)
foreach ($item in $list) {
  $dir = Join-Path $root $item[0]
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $name = Split-Path $item[1] -Leaf
  $out = Join-Path $dir $name
  try { Invoke-WebRequest -Uri $item[1] -OutFile $out -UseBasicParsing; $ok++; Write-Host "OK   $($item[0])\$name" }
  catch { $fail++; Write-Host "FAIL $($item[1])" -ForegroundColor Red }
}
Write-Host ""; Write-Host "Done: $ok downloaded, $fail failed." -ForegroundColor Green
Read-Host "Press Enter to close"
