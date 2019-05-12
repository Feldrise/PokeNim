import strutils

type 
    # Enums
    ContactType = enum
        physic, special
    Energie = enum
        steel, fire, water, plant, normal

    # Objects
    Capacity = ref object of RootObj
        name: string
        energie: Energie
        attackType: string

    AttackCapacity = ref object of Capacity
        contactType: ContactType
        power: int

    StateCapacity = ref object of Capacity
        concernedState: string
        power: int

    Pokemon = ref object of RootObj
        name: string
        healthPoint: int
        attackPoint, speAttackPoint: int
        defensePoint, speDefensePoint: int
        capacities: array[4, Capacity]

# Methode
# From Pokemon
proc show(pokemon: Pokemon): void =
    echo pokemon.name
    echo " -> ", pokemon.healthPoint, " HP"
    echo " -> Capacités : {", pokemon.capacities[0].name, ", ", pokemon.capacities[1].name, ", ", pokemon.capacities[2].name, ", ", pokemon.capacities[3].name, "}"

proc attack(origin, target: var Pokemon, usedAttack: AttackCapacity): void =
    echo origin.name, " attaque ", target.name, " avec ", usedAttack.name
    var lostPoints: int

    if usedAttack.contactType == physic:
        lostPoints = (usedAttack.power * (origin.attackPoint div target.defensePoint))
    else: 
        lostPoints = (usedAttack.power * (origin.speAttackPoint div target.speDefensePoint))

    target.healthPoint -= lostPoints
    
proc attack(origin: var Pokemon, usedAttack: StateCapacity): void =
    echo origin.name, " utilise ", usedAttack.name

proc playRound(player, ennemie: var Pokemon): void =
    for i in countup(0, 5):
        echo ""

    echo "(NOUVEAU ROUND)"
    echo "---------------"
    echo " VOTRE POKEMON "
    echo "---------------"
    player.show
    echo ""
    echo "---------------"
    echo " POKEMON ENNEMIE "
    echo "---------------"
    ennemie.show
    echo ""
    echo "Quelle attaque voulez vous utilier ? (1-4)"
    
    var choice = readLine(stdin).parseBiggestInt - 1;

    if player.capacities[choice].attackType == "state":
        player.attack(StateCapacity(player.capacities[choice]))
    else:
        player.attack(ennemie, AttackCapacity(player.capacities[choice]))

    echo "Appuyer sur entré"
    var next = readLine(stdin)

var 
    charge = AttackCapacity(name: "Charge", attackType: "attack", energie: normal, contactType: physic, power: 10)
    flammeche = AttackCapacity(name: "Flammeche", attackType: "attack", energie: fire, contactType: special, power: 15)
    rugissement = StateCapacity(name: "Rugissement", attackType: "state", energie: normal, concernedState: "speAttack", power: -3)
    plenitude = StateCapacity(name: "Plenitude", attackType: "state", energie: normal, concernedState: "speDefense", power: 5)

    evolie = Pokemon(name: "Evolie", healthPoint: 50, attackPoint: 20, speAttackPoint: 20, defensePoint: 20, speDefensePoint: 25, capacities: [charge, flammeche, rugissement, plenitude])
    bulbizarre = Pokemon(name: "Bulbizarre", healthPoint: 60, attackPoint: 8, speAttackPoint: 5, defensePoint: 15, speDefensePoint: 15, capacities: [charge, flammeche, rugissement, plenitude]) 

while evolie.healthPoint > 0 and bulbizarre.healthPoint > 0:
    playRound(evolie, bulbizarre)