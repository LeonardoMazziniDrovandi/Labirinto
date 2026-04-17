# Labirinto 3D (Processing)

Gioco 3D in prima persona. Il labirinto viene generato da file CSV configurabili, con movimento tridimensionale, interazione con oggetti e gestione dinamica dei materiali.

### Riepilogo
* Esplora un ambiente tridimensionale in prima persona (P3D).
* Genera dinamicamente la mappa di gioco e le collisioni tramite un file CSV completamente personalizzabile.
* Include un sistema di vittoria/sconfitta basato sul tempo (60 secondi) e sulla raccolta di oggetti (chiave).
* Supporta modelli 3D personalizzati (`.obj`) e set di texture intercambiabili.
* Necessario Processing IDE.

---

### 🛠️ Configurazione Iniziale (Step-by-Step)

Per far funzionare correttamente il progetto, è necessario configurare l'ambiente Processing e mantenere la struttura dei file intatta per il caricamento degli asset.

**1. Installare l'ambiente Processing**
* Vai sul sito ufficiale di Processing (processing.org).
* Scarica e installa la versione compatibile con il tuo sistema operativo.

**2. Strutturare le Cartelle (Fondamentale)**
Il codice richiama file specifici. Lo sketch `Progetto_Labirinto_3D.pde` e il file `mappa.csv` devono trovarsi nella root principale, affiancati **esattamente** da queste cartelle:
* `font/`: Deve contenere `edosz.ttf` e `arial.ttf`.
* `immagini/`: Deve contenere le texture base come `muro.jpg`.
* `modelli/`: Contiene i modelli 3D suddivisi in:
  * `source/`: Contiene il modello `key.obj` (la chiave).
  * `textures/`: Contiene 6 tipi di `.png` per personalizzare l'aspetto del labirinto. - (da cambiare il file png all'interno del file pde in modo manuale)
  * `traguardo/`: Contiene `traguardo.obj`, `traguardo.png` e `traguardo.mtl`.

**3. Configurare la Mappa (mappa.csv)**
Il file CSV agisce da "motore" per la generazione del livello. Puoi aprirlo con un editor di testo o Excel per creare il tuo labirinto personalizzato (griglia 13x13). La legenda dei blocchi è:
* **`0`**: Spazio vuoto (pavimento calpestabile).
* **`1`**: Muro (genera un blocco 3D con texture e collisione).
* **`2`**: Chiave (richiesta per vincere).
* **`3`**: Uscita/Traguardo.

---

### 🚀 Installazione e Utilizzo

**Scarica il repo**
```bash
git clone https://github.com/LeonardoMazziniDrovandi/Labirinto3D.git
```

**Avvio dello Script**
* Apri il file `Progetto_Labirinto_3D.pde` con l'IDE di Processing.
* Clicca sul pulsante **Esegui** (Play) in alto a sinistra.

**Comandi di Gioco**
* **Spazio:** Inizia la partita / Riavvia dopo vittoria o sconfitta.
* **W:** Cammina in avanti.
* **S:** Cammina all'indietro.
* **A:** Ruota la telecamera verso sinistra (Cambia punto cardinale).
* **D:** Ruota la telecamera verso destra (Cambia punto cardinale).

---

### 📈 Dinamiche di Gioco e Output

Il gioco gestisce in automatico le interazioni e le collisioni informando l'utente tramite gli stati di gioco:

* 🔑 **Raccolta Chiave:** Passando sopra la casella `2`, il modello della chiave scompare e viene registrato il possesso nell'inventario invisibile.
* 🛑 **Collisioni:** I muri (caselle `1`) fermano fisicamente il movimento del giocatore.
* 🏆 **Vittoria:** Raggiungendo l'uscita (casella `3`) **solo dopo** aver raccolto la chiave, il gioco si bloccherà mostrando la schermata "HAI VINTO".
* ⏳ **Sconfitta (Time Out):** Hai esattamente 60 secondi dall'inizio del livello. Se il timer scade prima di aver raggiunto l'uscita con la chiave, comparirà la schermata "HAI PERSO".

> **Note sulla Licenza:** GNU GPL v3.0 (o equivalente scelto per i tuoi progetti). Progetto realizzato a scopo educativo per esplorare le capacità P3D, la matematica dei vettori e la manipolazione di array in Java/Processing.
