# Projekt Dev


```bash
# zobraz stav (sledované / ignorované súbory)
git status
# stiahni zmeny z GitHubu
git pull
# pridaj zmeny a commitni
git add .
git commit -m "Popis zmeny"
# odošli na GitHub
git push
# Overenie ignorovaných súborov
git check-ignore -v cesta/k_suboru




## full reset repository
rm -rf .git
git init
git add .
git commit -m "Initial commit"
git branch -M main 
git remote add origin git@github.com:saupsaup/Dev.git
git push -u origin main --force
git status

# Zobraziť všetky ignorované súbory (globálne)
git status --ignored
# Zobraziť všetky ignorované súbory (short)
git status --ignored -s 

# Overiť, či konkrétny súbor je ignorovaný
git check-ignore -v <cesta/k/suboru>
git check-ignore -v Dev_V200/200/_Nh_DEV.st


# git rm -r --cached *.PNG *.png || true      # 2. vyhoď všetky PNG z indexu (repozitár), ale nechaj ich na disku
# git rm -r --cached Dev_V200/**/*.PNG Dev_V200/**/*.png || true
#  # git odstrani uplne vsetko co je aktualne sledovane v aktualnom priecinku aj -r = 
git rm -r --cached .       
# pridaj zmeny a commitni
git add .
git commit -m "Reset repo" 
# odošli na GitHub
git push           

# Označiť .sh súbor ako spustiteľný
cd ~/Mosaic/NachHouseApp/Dev
chmod +x SH/reset_dev_repo.sh

```
## Rýchly formát JSON
označ celý obsah (alebo nič – formátuje sa celý súbor)
stlač:
⇧ + ⌥ + F (Shift + Option + F)
→ automaticky zarovná odsadenie, čiarky, zátvorky atď.

# Ovladanie Magic Keyboard Home/End dokumenu
Legend: macOS (⌘ Cmd, ⌥ Option, ⌃ Ctrl, ⇧ Shift) · Windows/Linux (Ctrl, Alt, Shift)
Začiatok dokumentu: 		⌘ + ↑ (alebo fn + ←)
Koniec dokumentu: 			⌘ + ↓ (alebo fn + →)
so Shift pridáva výber


## VS Code – (klávesové skratky) editoru
Hľadať v súbore								⌘ F		Ctrl F
Hľadať v celom projekte						⌥ F		Ctrl ⇧ F
Nahradiť v súbore								⌥ ⌘ F
Nahradiť v celom projekte					⌘ ⇧ H	Ctrl ⇧ H
Prejs na zaciatok definicie (VAR) 		⌥ F3
Hľadať 				FUNCTION [clipb]		Ctrl ⌥ F
nastavit previos	FUNCTION [clipb]		⌥ PgUp	- skok na predchadzajucie blok zaciankuci FUNCTION
nastavit Next	 	FUNCTION [clipb]		⌥ PgDn	- skok na nasledujuci blok zaciankuci FUNCTION
Prejsť na riadok…								⌃ G		Ctrl G
Home 												⌘ ↑ 
End												⌘ ↓
Začiatok riadka  								↑
Koniec riadka 									↓



## VS Code – Bookmarks (klávesové skratky)
| Akcia | macOS | Windows / Linux |
|---|---|---|
| Toggle bookmark (zap./vyp.) 		⌥ ⌘ K 
| Vypis vsetkuch zaloziek				⌥ ⌘ L  
| //Predchádzajúca záložka 			⌥ ⌘ J | Zoznam záložiek v súbore 			| Command Palette → `Bookmarks: List` | Command Palette → `Bookmarks: List` |
| Zoznam zo všetkých súborov 			⌥ ⌘ L  Command Palette → `Bookmarks: List from All Files` | Command Palette → `Bookmarks: List from All Files` |
| Zmazať záložky v súbore 				⌥ ⌘ L | Command Palette → `Bookmarks: Clear` | Command Palette → `Bookmarks: Clear` |
| Zmazať záložky vo všetkých súboroch 	| Command Palette → `Bookmarks: Clear from All Files` | Command Palette → `Bookmarks: Clear from All Files` |

> Pozn.: Skutočné skratky si môžeš skontrolovať/prenastaviť v **Keyboard Shortcuts** (⌘K ⌘S / Ctrl K Ctrl S) a vyhľadať „Bookmarks“. :contentReference[oaicite:0]{index=0}


# Základné klávesové skratky vo VS Code
Legend: macOS (⌘ Cmd, ⌥ Option, ⌃ Ctrl, ⇧ Shift) · Windows/Linux (Ctrl, Alt, Shift)

Akcia										macOS	Windows / Linux
Build Mosacic							⌥ B
Paleta príkazov						shift +⌘ P		Ctrl ⇧ P

Rýchlo otvoriť súbor					⌘ P		Ctrl P
Prejsť na symbol v súbore			⌘ ⇧ O	Ctrl ⇧ O
Prejsť na symbol v pracovnom priestore	⌘ T	Ctrl T
Prejsť na definíciu					F12		F12
Náhľad definície			⌥ F12	Alt F12
Premenovať symbol			F2		F2
Formátovať dokument			⌥ ⇧ F	Alt ⇧ F
Riadkový komentár	⌘ /	Ctrl /
Blokový komentár	⌥ ⇧ A	Alt ⇧ A
Viacnásobné kurzory – klik	⌥ + klik	Alt + klik
Pridať kurzor hore/dole	⌥ ⌘ ↑/↓	Ctrl Alt ↑/↓
Vybrať ďalší výskyt	⌘ D	Ctrl D
Vybrať všetky výskyty	⌘ ⇧ L	Ctrl ⇧ L
Presun riadku	⌥ ↑/↓	Alt ↑/↓
Kopírovať riadok nadol	⌥ ⇧ ↓	Alt ⇧ ↓
Zmazať riadok	⌘ ⇧ K	Ctrl ⇧ K
Integrovaný terminál	Ctrl `	Ctrl `
Zobraziť Prieskumník	⌘ ⇧ E	Ctrl ⇧ E
Zdrojová kontrola (Git)	⌘ ⇧ G	Ctrl ⇧ G
Problémy (Errors/Warnings)	⌘ ⇧ M	Ctrl ⇧ M
Rýchle opravy / návrhy	⌘ .	Ctrl .
Skryť/Zobraziť bočný panel	⌘ B	Ctrl B
Rozdeliť editor	⌘ \	Ctrl \
Prepnutie na editor 1/2/3	⌘ 1/2/3	Ctrl 1/2/3

# standard VSCobe, ja som  si ich nahradil
//Paleta príkazov				⌘ ⇧ P	Ctrl ⇧ P
//Hľadať v celom projekte		⌘ ⇧ F	Ctrl ⇧ F


# Rspberry Pi 

pi@pi3server:~ $ influx
Connected to http://localhost:8086 version 1.6.7~rc0
InfluxDB shell version: 1.6.7~rc0
> SHOW DATABASES
name: databases
name
----
_internal
plcdata
> USE plcdata
Using database plcdata
> INSERT hvac,ev=HET,sub=02,rm=005,src=TER temp=22.5
> SELECT * FROM hvac LIMIT 5
name: hvac
time                ev  rm  src sub temp
----                --  --  --- --- ----
1760835873002681201 HET 005 TER 02  22.5

Grafana vo web:
http://192.168.33.111:3000/

