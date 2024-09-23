# Définir le chemin du répertoire contenant les fichiers txt
$directoryPath = "SetThePath"

# Récupérer tous les fichiers txt dans le répertoire
$files = Get-ChildItem -Path $directoryPath -Filter *.txt

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

    # Initialiser la variable de l'owner
    $owner = "No owner found"

    # Si la section "history" est trouvée
    if ($historyIndex -ne -1) {
        # Extraire la sous-chaîne à partir de l'index "history"
        $historyContent = $content.Substring($historyIndex)

        # Utiliser une expression régulière pour trouver la ligne "owner"
        $ownerMatch = [regex]::Match($historyContent, "owner\s*=\s*([A-Z]{3})")
        
        # Si la ligne "owner" est trouvée
        if ($ownerMatch.Success) {
            # Extraire l'info du "owner"
            $owner = $ownerMatch.Groups[1].Value
        }
    }

    # Afficher les informations
	Write-Output "---------------------------------------------"
    Write-Output "File: $($file.Name) - ID: $id - Owner: $owner"
	Write-Output "---------------------------------------------"

    
}
# Attendre que l'utilisateur appuie sur une touche pour continuer
    Write-Output "Press any key to exit the file..."
    [System.Console]::ReadKey() | Out-Null
