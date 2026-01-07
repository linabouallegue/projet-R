# Analyse des données NHANES

## Introduction et Objectif

L'objectif de ce projet est d'étudier les déterminants du diabète de type 2 au sein de la population américaine en utilisant les données du **National Health and Nutrition Examination Survey** (NHANES) du cycle 2017-2018. Nous nous sommes concentrés sur deux facteurs principaux : **le vieillissement** et la **surcharge pondérale (IMC)**, tout en prenant en compte **l'effet du genre** sur la prévalence du diabète.

## Source des Données

Les données proviennent des **Centers for Disease Control and Prevention (CDC)** et ont été extraites sous forme de fichiers `.xpt` (format SAS). Les fichiers utilisés comprennent :
- **DEMO_J.xpt** : Démographie (âge, sexe).
- **BMX_J.xpt** : Mesures anthropométriques (IMC).
- **DIQ_J.xpt** : Questionnaire sur le diabète (statut de diabète).
- **GLU_J.xpt** : Biologie (glycémie à jeun pour vérifier les valeurs).

Les fichiers ont été fusionnés en utilisant l'identifiant unique `SEQN` pour créer un jeu de données consolidé.

## Méthodologie

Le projet suit une démarche claire :
1. **Extraction des données** : Chargement des fichiers `.xpt` à l'aide de la bibliothèque **haven**.
2. **Nettoyage des données** : Recodage des variables comme le diabète et le sexe, et suppression des valeurs manquantes.
3. **Exploration et analyse descriptive** : Utilisation de **ggplot2** pour visualiser la distribution de l'IMC et de l'âge en fonction du diabète, ainsi que pour examiner les statistiques descriptives.
4. **Interprétation** des résultats : Étude de l'impact de l'IMC et de l'âge sur la probabilité d’être diabétique, avec une attention particulière aux différences entre les sexes.

## Exploration des données

### Structure du jeu de données final

Le jeu de données après fusion contient les variables suivantes :
- **SEQN** : Identifiant unique.
- **age** : Âge du participant (en années).
- **sex** : Sexe du participant (1 = Masculin, 2 = Féminin).
- **bmi** : Indice de Masse Corporelle (IMC).
- **diabetes_bin** : Statut de diabète (1 = Diabétique, 0 = Non-diabétique).
- **glucose** : Glycémie à jeun.

Nous avons aussi vérifié les valeurs manquantes et l'absence de doublons dans le jeu de données.

### Aperçu des données démographiques

#### Distribution de l'âge et du sexe

Le tableau suivant montre la répartition par sexe dans notre échantillon nettoyé :

| Sexe       | Effectif | Proportion (%) |
|------------|----------|----------------|
| Masculin   | X        | Y              |
| Féminin    | X        | Y              |

**Analyse** : La répartition par sexe dans l'échantillon est relativement équilibrée, ce qui nous permet d'explorer les effets du sexe sur le diabète.

#### Statistiques de l'âge

Le résumé statistique de l'âge est le suivant :

| Statistique    | Valeur |
|----------------|--------|
| Minimum        | X      |
| 1er quartile   | Y      |
| Médiane        | Z      |
| Moyenne        | A      |
| 3e quartile    | B      |
| Maximum        | C      |

**Analyse** : L'âge médian indique que la majorité des participants sont dans une tranche d'âge adulte, ce qui est cohérent avec l'âge typique d'apparition du diabète de type 2.

### Analyse du diabète déclaré

#### Prévalence du diabète déclaré

Le statut diabétique a été enregistré via un questionnaire (**DIQ010**), où 1 représente les diabétiques et 2 les non-diabétiques. Le tableau suivant présente la prévalence du diabète dans l'échantillon étudié :

| Statut Diabète    | Nombre | Proportion (%) |
|-------------------|--------|----------------|
| Diabétique        | X      | Y              |
| Non-diabétique    | X      | Y              |

**Analyse de la prévalence** : Environ **X%** de la population étudiée se déclare diabétique. Cependant, il est important de noter que cette auto-déclaration pourrait sous-estimer la prévalence réelle du diabète, car certains diabétiques ne sont pas diagnostiqués.

### Distribution de l'IMC par statut diabétique

```r
ggplot(df_clean %>% filter(!is.na(diabetes_bin)), aes(x = bmi, fill = factor(diabetes_bin))) +
  geom_histogram(alpha = 0.6, bins = 35, position = "identity", color = "white") +
  scale_fill_manual(
    values = c("1" = "#e74c3c", "0" = "#4a90e2"),
    labels = c("1" = "Diabétique", "0" = "Non-diabétique")
  ) +
  labs(
    title = "Distribution de l'IMC par statut diabétique",
    x = "Indice de Masse Corporelle (kg/m²)",
    y = "Fréquence / Nombre de cas",
    fill = "Statut"
  ) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "top")
