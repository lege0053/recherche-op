# Recherche Opérationnelle

Application regroupant différent algorithmes en lua en rapport avec la théorie des graphes.

## Built with
* JavaScript
* Lua

## Prérequis

Pour faire fonctionner les scripts en .lua, il faut avoir lua installer sur son ordinateur.

**Etape 1**
* Copier le dossier `Lua` présent dans /api
![alt text](image-1.png)
* Le coller dans dans `C:\Program Files`
![alt text](image-2.png)

**Etape 2**
* Ouvrir ses variables d'environnement
![alt text](image.png)
![alt text](image-3.png)
* Double cliquer sur `Path`
![alt text](image-4.png)
* Ajouter une nouvelle variable d'environnement en cliquant sur le bouton `Nouveau` en haut à droite. Entrer le chemin où Lua se trouve: `C:\Program Files\Lua`
![alt text](image-5.png)
* Vous pouvez fermer les fenêtres

**Etape 3**
* Pour tester que Lua a bien été installer, ouvrez un terminal.
![alt text](image-6.png)
* Entrez la commande `lua54`. Vous devriez avoir la même chose que l'image ci-dessous.
![alt text](image-7.png)

## Installer les dependences et lancer l'application
* Le dossier **api** contient l'api et les scripts lua
* Le dossier **app** contient l'application
```bash
# dans /api
npm install
npm run start
```
```bash
# dans /app
npm install
npm run dev
```