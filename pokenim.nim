type 
    # Enums
    ContactType = enum
        physic, special
    Energie = enum
        steel, fire, water, plant, normal

    # Objects
    Attack = ref object of RootObj
        name: string
        power: int
        contactType: ContactType
        energie: Energie

    Pokemon = ref object of RootObj
        name: string
        healthPoint: int
        attack, speAttack: int
        defense, speDefense: int
        attacks: array[4, Attack]

# Methode
# From Pokemon
proc show(pokemon: Pokemon): void =
    echo "--- INFO ---"
    echo pokemon.name
    echo pokemon.healthPoint, " HP"
    echo "Attack: {", pokemon.attacks[0].name, ", ", pokemon.attacks[1].name, ", ", pokemon.attacks[2].name, ", ", pokemon.attacks[3].name, "}"
    echo "------------"

var 
    charge1 = Attack(name: "Charge1", power: 25, contactType: physic, energie: normal)
    charge2 = Attack(name: "Charge2", power: 25, contactType: physic, energie: normal)
    charge3 = Attack(name: "Charge3", power: 25, contactType: physic, energie: normal)
    charge4 = Attack(name: "Charge4", power: 25, contactType: physic, energie: normal)
    
    evolie = Pokemon(name: "Evolie", healthPoint: 50, attack: 10, speAttack: 20, defense: 20, speDefense: 25, attacks: [charge1, charge2, charge3, charge4])

evolie.show