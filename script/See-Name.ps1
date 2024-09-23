# Définir le chemin du répertoire
$repertoire = "SetThePath"

function AfficherMenu {
    Write-Host "---------------------------------"
    Write-Host "Menu :"
    Write-Host "1. Voir la liste des fichiers"
    Write-Host "2. Rechercher un fichier en particulier"
    Write-Host "3. Quitter"
    Write-Host "---------------------------------"
}

function ListerFichiers {
    $fichiers = Get-ChildItem -Path $repertoire -File
    if ($fichiers.Count -gt 0) {
        foreach ($fichier in $fichiers) {
            Write-Output "---------------------------------"
            Write-Host "Nom du fichier : $($fichier.Name)"
            Write-Output "---------------------------------"
            Write-Output ""
        }
    } else {
        Write-Host "Aucun fichier trouvé dans le répertoire."
    }
}

function RechercherFichier {
    do {
		Write-Host ""
        $recherche = Read-Host "Entrez le nom (ou une partie du nom) du fichier que vous recherchez"
        $fichiers = Get-ChildItem -Path $repertoire -File
        $fichiersCorrespondants = $fichiers | Where-Object { $_.Name -like "*$recherche*" }

        if ($fichiersCorrespondants.Count -gt 0) {
            foreach ($fichier in $fichiersCorrespondants) {
				Write-Host ""
                Write-Output "---------------------------------"
                Write-Host "Nom du fichier : $($fichier.Name)"
                Write-Output "---------------------------------"
                Write-Output ""
            }
        } else {
			Write-Host ""
            Write-Host "Pas de fichier avec ce nom ..."
        }

        # Demander si l'utilisateur veut continuer
		Write-Host ""
        $continuer = Read-Host "Voulez-vous continuer la recherche ? (Y/N)"
    } until ($continuer -eq 'N')
}

# Boucle principale
do {
    Clear-Host
    AfficherMenu
	Write-Host ""
    $choix = Read-Host "Entrez votre choix (1, 2, ou 3)"

    switch ($choix) {
        1 {
            ListerFichiers
            [System.Console]::ReadKey() | Out-Null
        }
        2 {
            RechercherFichier
            [System.Console]::ReadKey() | Out-Null
        }
        3 {
            Write-Host "Quitter le programme..."
        }
        default {
			Write-Host ""
            Write-Host "Choix non valide, veuillez entrer 1, 2, ou 3."
            [System.Console]::ReadKey() | Out-Null
        }
    }
} until ($choix -eq 3)
