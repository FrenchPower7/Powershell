# Définir les chemins des répertoires source et destination
$sourceDirectory = "C:\Users\frenc\Desktop\script\test1"
$destinationDirectory = "C:\Users\frenc\Desktop\script\test2"

# Créer le répertoire de destination s'il n'existe pas
if (-Not (Test-Path -Path $destinationDirectory)) {
    New-Item -ItemType Directory -Path $destinationDirectory
}

# Récupérer tous les fichiers txt dans le répertoire source
$files = Get-ChildItem -Path $sourceDirectory -Filter *.txt

# Parcourir chaque fichier
foreach ($file in $files) {
    # Lire le contenu du fichier
    $content = Get-Content -Path $file.FullName

    # Utiliser une expression régulière pour trouver la ligne "id"
    $idMatch = [regex]::Match($content, "id\s*=\s*(\d+)")
    if ($idMatch.Success) {
        # Extraire l'info de l'id
        $id = $idMatch.Groups[1].Value
    } else {
        $id = "No ID found"
    }

    # Remplacer "owner" par "FFF"
    $modifiedContent = $content -replace "owner\s*=\s*[A-Z]{3}", "owner = FFF"

    # Définir le chemin de destination pour le fichier modifié
    $destinationPath = Join-Path -Path $destinationDirectory -ChildPath $file.Name

    # Écrire le contenu modifié dans le fichier de destination
    Set-Content -Path $destinationPath -Value $modifiedContent

    # Afficher les informations
    Write-Output "---------------------------------------------"
    Write-Output "File: $($file.Name) - ID: $id - Owner: FFF"
    Write-Output "---------------------------------------------"
}

# Attendre que l'utilisateur appuie sur une touche pour continuer
Write-Output "Press any key to exit the file..."
[System.Console]::ReadKey() | Out-Null
