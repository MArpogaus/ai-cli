# MLflow-Projekt // Strukturbeispiel 

Dieser Ordner beschreibt ein Basisprojekt das [MLflow](https://mlflow.org/docs/latest/index.html) in einer [Anaconda](https://www.anaconda.com/)-Umgebung verwendet und eine [Python](https://docs.python.org/3/)-Datei ausführt.    


## test.py

Diese beispielhafte Datei startet einen *run* und legt Werte fest die aufgezeichnet("logged") werden sollen. Um `mlflow` zu benutzen muss es in der Python-Datei zuerst importiert werden.  
    
    import mlflow

Danach kann der *run* gestartet werden. 


## conda.yaml

Eine YAML formatierte Textdatei um eine Anaconda Umgebung aufzubauen. Die `conda.yaml` besteht aus dem Namen der Umgebung, mehreren Kanälen (`channels`) und einer teils langen Liste an Abhängigkeiten (`dependencies`). Ein [Conda `channel`](https://conda.io/projects/conda/en/latest/user-guide/concepts/channels.html) beschreibt einen Ort, an dem viele Software Pakete abgespeichert sind. Die Abhängigkeiten zählen einzelne Bibliotheken und deren Versionen in der Umgebung auf. In den Abhängigkeiten der Anaconda Umgebung ist auch `mlflow` enthalten. 

```YAML
channels:
  - defaults
  - anaconda
  - conda-forge
dependencies:
  - python=3.8
  - pip
  - pip:
    - mlflow
```

Diese `conda.yaml` referenziert sich auf drei Standard channels und installiert den Paketmanager **pip** um damit `mlflow` herunterladen zu können. 


## MLProject File

Die YAML Datei für MLflow (=`MLProject`) spezifiziert die Umgebung des Projektes. Man kann dem Projekt einen Namen geben, Umgebungen hinzufügen (z.B. Anaconda) und auch Schnittstellen (`entry points`) definieren. Weitere mögliche **Projektumgebungen** sind: 

- Docker container environment
- System environment

Um das Projekt aufzurufen (`python test.py`) wurde ein `entry point` definiert:

```YAML
entry_points:
  main:
    command: "python test.py"
```

## MLflow Server

    https://<user>-mlflow.ai4grids.ei.htwg-konstanz.de

Der MLflow Server lässt sich dauerhaft (der [*Server container*](https://gitlab.ei.htwg-konstanz.de/it-grid-design/tools/ai-cli/-/blob/main/home/.local/share/ai-cli-docker/server.docker-compose.yaml) muss laufen) unter der oben genannten Adresse aufrufen. Darin sind alle Experimente gespeichert. Auf den MLflow Server hat jeder Benutzer mit seinem **RZ-Login** Zugriff.
