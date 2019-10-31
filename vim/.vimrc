"Affiche les numeros de ligne
set nu

"Activation des numeros de ligne relatifs
set relativenumber

"Highlighted Search
set hlsearch

"Change l'affichage pour les fonds sombres
set bg=dark

"Change le nombre de commandes gardées en historique
set history=1000

"Affiche la position du curseur
set ruler

"Affiche les commandes incomplètes
set showcmd

"Affiche un menu pour l'autocomplétion (TAB)
set wildmenu

"Garder des lignes affichées en scrollant
set scrolloff=5

"recherche
set incsearch

set ignorecase
set smartcase

"fait un backup du fichier en cours d'édition
set backup
set bex=-old

"change les linebreaks
set lbr

"copy l'indentation de la ligne précédente
set ai
"indentation intelligente

set si

"Activation des buffers Hidden
set hidden

"changer de thème
color slate

"Créer un bloc de commentaire avec des #
map <F2> 80i#<ESC>a<CR><ESC>80i#<ESC>2O#<ESC>ka

"Highlight des Adresses IP
syn match ipaddr /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)/
hi link ipaddr Identifier
