# Swift Cheat Sheet

## Good ol' Hello World
Comme le veut la tradition...

```swift
print("Hello World")
```

... affiche le texte "Hello World" dans la console.

## Variables
### Variables
Pour déclarer et assigner des variables, on utilise la syntaxe suivante: `var nom: Type = valeur`, par exemple:

```swift
var lang: String = "Swift 4"
var counter: Int = 0
var averageGrade: Double = 5.36
```

En pratique, le compilateur est souvent capable d'inférer lui-même le type des variables, ainsi il peut être omis. Dans ce cas,

```swift
var lang = "Swift 4"
var counter = 0
var averageGrade = 5.36
```
sont des déclarations valides.

### Constantes
Les constantes sont des variables dont la valeur ne peut pas être modifiée une fois qu'elles ont été assignées. Leur déclaration est identique aux variables à l'exception du mot clé `var` remplacé par `val`:

```swift
val notFound: Int = 404
val meaningOfLife = 42
```
*Notez que comme pour les variables, le compilateur peut également inférer le type dans la plupart des cas.*

Dès lors, ce genre de tournures fera crasher votre app à la compilation:

```swift
meaningOfLife += 1 // WTF
```

Les constantes offrent deux avantages majeurs par rapport aux variables:
- Leur gestion par le compilateur permet une meilleure utilisation de la mémoire (n'oubliez jamais que vous développez une application pour un smartphone, pas un ordinateur...)
- Si une valeur ne doit pas être modifiée de part sa nature, l'utilisation d'une constante vous garantit que cette valeur ne peut pas être modifiée tout au long de l'exécution de votre app.


__Conseil:__ utilisez des constantes autant que possible!

## Conditions
Sans surprise, Swift vous offre la possibilité d'écrire des `if-then-else`:

```swift
if(lang == "Swift") {
    print("❤️")
}
else if(lang == "Javascript") {
    print("🤯")
}
else {
    print("👌🏻")
}
```

Syntaxe `switch`:

```swift
switch(confusionLevel) {
    case 0:
        goOn()
    case 1, 2:
        askQuestions()
    case 3:
        askMoreQuestions()
    default:
        drinkCoffee()
}
```

## Boucles
```swift
// Boucle for avec borne supérieure inclusive
for i in 0...10 {
    print(i)
}
// Affiche 0, 1, 2, ..., 10
```

```swift
/*
Boucle  for avec borne supérieure exclusive (utile pour éviter les overflow quand on parcourt des tableaux...)
*/
for i in 0..<10 {
    print(i)
}
// Affiche 0, 1, 2, ..., 9
```

```swift
while(condition) {
    doStuff()
}
```

```swift
// Equivalent du do...while
repeat {
    doStuff()
} while(condition)
```

## Tableaux
Les tableaux sont des collections __homogènes__ (= de même type), dont la déclaration est la suivante:

```swift
val dreamTeam: [String] = ["Riri", "Fifi", "Loulou"]
val primesLessThanTen = [2, 3, 5, 7]
```

### Itérer sur des tableaux

```swift
for name in dreamTeam {
    // ...
}
```

*Side note for functional programmers: les tableaux sont des monads et vous offrent des méthodes fonctionnelles comme `map`, `flatMap`, `filter`, `foreach`, etc...*

## Fonctions
Les fonctions sont déclarées grâce au mot clé `func`, de la manière suivante:

```
func nom(parametre: Type, parametre: Type, ...) -> Type {
    code + return
}
```

Par exemple:

```swift
func metalify(name: String) -> String {
    return name + " is so metal!"
}

metalify("iOS") // "iOS is so metal!"
```
*Note: une fonction qui ne retourne rien doit avoir `Void` comme type de retour.*

## Optionals
Contrairement à beaucoup de langages, Swift propose une solution élégante pour travailler avec des valeurs manquantes ou inexistantes (`null` en Java, PHP, Javascript ou `None` en Python). Utilisées à bon escient, les valeurs optionnelles permettent d'écrire du code stable très simplement.

Un `Optional` est un type qui peut contenir soit une valeur quelconque dépendamment de son type, soit une valeur spéciale indiquant qu'elle est vide: `nil`. Par exemple:

```swift
val optInt: Int? = 5
val emptyOptInt: Int? = nil
```

Ici, `optInt` et `emptyOptInt` ont le même type: `Int?`. La différence est que `optInt` contient effectivement une valeur de type `Int` (ici 5) tandis que `emptyOptInt` est vide est contient donc la valeur spéciale `nil`.

Les `Optionals` peuvent être vus comme des paquets cadeaux qui peuvent contenir ou non une valeur. Dans cette idée, il nous faut des méthodes permettant d'ouvrir le paquet.

### Force-unwrap (dangereux)
Le force-unwrap permet de récupérer directement la valeur contenue dans l'`Optional`. Par contre... elle fait crasher l'app si l'`Optional` est vide (vous aussi vous êtes déçus quand vous ouvrez un paquet cadeau vide, non?)

```swift
val intVal = optInt! // intVal contient 5
val emptyIntVal = emptyOptInt! // BOOOOM
```

En règle générale, l'utilisation du force-upwrap est déconseillée, à moins que vous soyez certain que l'`Optional` n'est pas vide. Le test peut être effectué avec `isEmpty()`:

```swift
optInt.isEmpty() // false
emptyOptInt.isEmpty() // true
```

### Safe unwrap
Pour éviter les déceptions immenses infligées par l'ouverture d'un cadeau vide, Swift propose une forme de safe unwrap qui teste si un `Optional` est vide avant de l'ouvrir. Une manière de faire est:

```swift
if(myOptional.isEmpty()) {
    myValue = myOptional! // Beurk, mais ok
}
```

Il existe deux manières plus propres de faire, le `if let`:

```swift
if let myValue = myOptional {
    // myValue contient la valeur contenue dans myOptional s'il n'est pas vide
}
else {
    // si myOptional est vide
}
```

ainsi que le `guard let`:

```swift
guard let myValue = myOptional {
    // si myOptional est vide
}
// Ici myValue peut-être utilisé et contient la valeur contenue dans myOptional s'il n'était pas vide
```

Cette dernière syntaxe peut paraître surprenante, mais elle s'utilise fréquemment dans des fonctions:

```swift
func f(optInt: Int?) -> Int? {
    guard let intValue = optInt { return nil }
    return intValue + 1
}
```

Cette fonction retourne `nil` si le paramètre `optInt` est vide, sinon elle retourne la valeur contenue dans `optInt` incrémentée de 1.

## Dictionaires
Les dictionaires sont des associations clé-valeurs supportées par Swift. Leur déclaration est la suivante:

```
val name: [Type: Type] = [Clé: Valeur, Clé: Valeur, ...]
```

Par exemple:

```swift
val programmingSkills = ["Tim": 90, "Amandine": 70, "Luca": 85, "Xavier": 0, "Hector": -10]
```

Maintenant que nous avons vu les `Optionals`, en voici une utilisation judicieuse: la méthode `get` sur les `Dictionaries` retourne un `Optional`.

Dans notre exemple:

```swift
programmingSkills["Xavier"] // Optional[0]
programmingSkills["Steve"] // nil!
```

Pour récupérer proprement une valeur:

```swift
if let xavierSkills = programmingSkills["Xavier"] {
    doStuffWithSkill(xavierSkills) // e.g make coffee
}
```