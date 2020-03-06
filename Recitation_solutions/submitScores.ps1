$recNumber = "6"
$recMaxScore = "5"

$csvFile = Import-Csv -Path .\scores.csv

For($i = 0; $i -lt 59; $i++) {
    Write-Host ""
    Write-Host ""
    Write-Host "Submitting for student $i"
    $gitUrl = $csvFile[$i].'Access to private repo' -split "/"
    $gituser = $gitUrl[3]
    $gitrepo = $gitUrl[4]

    $score = $csvFile[$i].'Recitation 6 (out of 5)'
    $comments = $csvFile[$i].'Recitation6 comments'

    git clone "https://github.com/$gituser/$gitrepo"
    $scoreFile = Get-ChildItem -Path "$gitrepo\" -Force | Where-Object -FilterScript {($_.Name -eq 'SCORE.txt')}
    if(!$scoreFile) {
        Write-Host "No SCORE file found for $gituser/$gitrepo" -ForegroundColor red -BackgroundColor white
        Remove-Item -Path "$gitrepo\" -Recurse -Force
        exit
    }

    # editing the file
    $content = Get-Content -Path "$gitrepo\SCORE.txt"
    $content = $content + "Recitation$recNumber (out of $recMaxScore):     $score               $comments"
    Set-Content -Path "$gitrepo\SCORE.txt" -Value $content



    # committing the changes
    cd "$gitrepo"
    git add SCORE.txt
    git commit -m "Added Recitation $recNumber scores"
    git push
    cd ..


    # Write-Host "Cleaning up the repo"
    Remove-Item -Path "$gitrepo\" -Recurse -Force
}
